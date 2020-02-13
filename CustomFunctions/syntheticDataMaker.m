%syntheticDataMaker
%Written by Kambadur Ananthamurthy
function [syntheticDATA, syntheticDATA_2D, ...
    ptcList, ocList, ...
    actualEventWidth, ...
    hitTrialPercent, hitTrials, ...
    frameIndex, pad, ...
    noiseComponent] = syntheticDataMaker(dataset, DATA_2D, eventLibrary_2D, ...
    timeCellPercent, cellOrder, ...
    maxHitTrialPercent, hitTrialPercentAssignment, trialOrder, ...
    eventWidth, eventAmplificationFactor, eventTiming, startFrame, endFrame, ...
    imprecisionFWHM, imprecisionType, ...
    noise, noisePercent)

disp('Creating synthetic data ...')

%Preallocation
nTotalCells = size(DATA_2D,1);
nTotalTrials = dataset.nTrials;
nTotalFrames = dataset.nFrames;
syntheticDATA = zeros(nTotalCells, nTotalTrials, nTotalFrames);
syntheticDATA_2D = zeros(nTotalCells, nTotalTrials*nTotalFrames);
noiseComponent = zeros(nTotalCells, nTotalTrials, nTotalFrames);

%Which cells to select?
nPutativeTimeCells = floor((timeCellPercent/100) * nTotalCells);
fprintf('... Number of Putative Time Cells: %i\n', nPutativeTimeCells)
if strcmpi(cellOrder, 'basic')
    ptcList = 1:nPutativeTimeCells;
    ocList = (nPutativeTimeCells+1):nTotalCells;
elseif strcmpi(cellOrder, 'random')
    ptcList = randperm(nTotalCells, nPutativeTimeCells);
    ocList = 1:nTotalCells;
    ocList(ptcList) = [];
else
    error('Unknown cellOrder')
end

actualEventWidth = zeros(nTotalCells,2);
requiredEventWidth = zeros(nTotalCells,1);
hitTrials = zeros(nTotalCells, nTotalTrials);
hitTrialPercent = zeros(nTotalCells,1);

frameIndex = zeros(nTotalCells, nTotalTrials);
pad = zeros(nTotalCells, nTotalTrials);

for cell = 1:nTotalCells
    %For Putative Time Cells
    if ismember(cell, ptcList)
        if strcmpi(hitTrialPercentAssignment, 'fixed')
            hitTrialPercent(cell) = maxHitTrialPercent;
        elseif strcmpi(hitTrialPercentAssignment, 'random')
            hitTrialPercent(cell) = randi([floor(maxHitTrialPercent/2), maxHitTrialPercent]); % Ensures that the range of Hit Trial Percent is within [max/2, max]
            %hitTrialPercent(cell) = randi(maxHitTrialPercent);
        else
            error('Unknown hitTrialPercentAssignment')
        end
        
        %What trials to select?
        nHitTrials = floor((hitTrialPercent(cell)/100) * nTotalTrials);
        if strcmpi(trialOrder, 'basic')
            hitTrials(cell, 1:nHitTrials) = 1;
        elseif strcmpi(trialOrder, 'random')
            hitTrials(cell, 1) = 1;
            hitTrials(cell, randperm(nTotalTrials, (nHitTrials-1))) = 1;
        else
            error('Unknown trialOrder')
        end
        
        %What size of calcium events to select?
        if strcmpi(eventWidth(2), 'stddev') %Only defined case with a string argument
            requiredEventWidth(cell) = std(eventLibrary_2D(cell).eventLengths);
            actualEventWidth(cell, 1) = floor(max(eventLibrary_2D(cell).eventLengths) - requiredEventWidth(cell)); % Min
            actualEventWidth(cell, 2) = ceil(max(eventLibrary_2D(cell).eventLengths) + requiredEventWidth(cell)); % Max
        else
            requiredEventWidth(cell) = eventWidth{2}; %Use the actual argument value
            actualEventWidth(cell, 1) = floor(prctile(eventLibrary_2D(cell).eventLengths, eventWidth{1})) - requiredEventWidth(cell); % Min
            actualEventWidth(cell, 2) = ceil(prctile(eventLibrary_2D(cell).eventLengths, eventWidth{1})) + requiredEventWidth(cell); % Max
        end
        
        for trial = 1:nTotalTrials
            if hitTrials(cell, trial) == 1
                eventIndices = find((eventLibrary_2D(cell).eventLengths > actualEventWidth(cell, 1)) & ...
                    (eventLibrary_2D(cell).eventLengths < actualEventWidth(cell, 2)));
                eventStartIndex = randomlyPickEvent(eventIndices, eventLibrary_2D, cell);
                %Now, we pick out exactly one event per trial
                event = DATA_2D(cell, eventStartIndex:1:eventStartIndex+actualEventWidth(cell)-1);
                
                % Generate noise
                noiseComponent(cell, trial, :) = generateNoise(event, noise, noisePercent, nTotalFrames);
                % Add noise
                if ~strcmpi(noise, 'none')
                    syntheticDATA(cell, trial, :) = noiseComponent(cell, trial, :);
                end
                
                %disp('Selecting the Frame Index ...')
                [~, I] = max(event);
                while (frameIndex(cell, trial) + pad(cell, trial)) <= I
                    %Pick event(s) based on requiredEventLength
                    [frameIndex(cell, trial), pad(cell, trial)] = selectFrameIndex(eventTiming, startFrame, endFrame, I, imprecisionFWHM, imprecisionType, cell);
                end
                
                %Prune trial lengths, if necessary
                tailClip = (frameIndex(cell, trial) + pad(cell, trial)) + length(event) - 1 - nTotalFrames;
                
                if tailClip > 0
                    %fprintf('tail-clip: %i\n', tailClip)
                    syntheticDATA(cell, trial, ((frameIndex(cell, trial) + pad(cell, trial)):((frameIndex(cell, trial) + (pad(cell, trial))+length(event)) - 1 - tailClip))) = event(1:(length(event) - tailClip)) * eventAmplificationFactor;
                else
                    syntheticDATA(cell, trial, ((frameIndex(cell, trial)+ pad(cell, trial)):(frameIndex(cell, trial) + (pad(cell, trial))+length(event)-1))) = event * eventAmplificationFactor;
                end
                %fprintf('syntheticDATA trial length: %i\n', length(syntheticDATA(cell, trial, :)))
                %fprintf('Event added to cell:%i, trial:%i at frame:%i\n', cell, trial, (frameIndex(cell, trial)+ pad (cell, trial)))
                
                clear eventIndices
                clear eventStartIndex
                clear event
                clear tailClip
                %disp(frameIndex(cell, trial) + pad(cell, trial))
            elseif hitTrials(cell, trial) == 0 % For Non-Hit Trials
                % Add noise
                currentTrialOptions = find(hitTrials(cell, 1:trial));
                selectedTrialOption = randperm(length(currentTrialOptions), 1);
                
                noiseComponent(cell, trial, :) = noiseComponent(cell, currentTrialOptions(selectedTrialOption), :);
                
                if ~strcmpi(noise, 'none')
                    syntheticDATA(cell, trial, :) = syntheticDATA(cell, trial, :) + noiseComponent(cell, trial, :);
                end
            else
                error('Unknown case for hitTrial')
            end
        end
    elseif ismember(cell, ocList) % For Other Cells
        % Add noise
        selectedCellOption = ptcList(randperm(length(ptcList), 1));
        
        for trial = 1:nTotalTrials
            noiseComponent(cell, trial, :) = noiseComponent(selectedCellOption, trial, :);
            
            if ~strcmpi(noise, 'none')
                syntheticDATA(cell, trial, :) = syntheticDATA(cell, trial, :) + noiseComponent(cell, trial, :);
            end
        end
    else
        error('Unknown nature of cell')
    end
end

%Ceil negative values to 0
syntheticDATA(syntheticDATA<0) = 0;

%2D Synthetic Data
for cell = 1:nTotalCells
    syntheticDATA_2D(cell, :) = reshape(squeeze(syntheticDATA(cell, :, :))', 1, []);
end

disp('... done!')
end