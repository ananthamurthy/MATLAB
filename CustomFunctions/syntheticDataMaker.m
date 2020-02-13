%syntheticDataMaker
%Written by Kambadur Ananthamurthy
function [syntheticDATA, syntheticDATA_2D, putativeTimeCells, actualEventWidth, ...
    hitTrialPercent, frameIndex, pad, noiseComponent] = syntheticDataMaker(dataset, DATA_2D, eventLibrary_2D, ...
    timeCellPercent, cellOrder, ...
    maxHitTrialPercent, hitTrialAssignment, trialOrder, ...
    eventWidth, eventAmplificationFactor, eventTiming, startFrame, endFrame, ...
    imprecisionFWHM, imprecisionType, ...
    noise, noisePercent)

disp('Creating synthetic data ...')

%Preallocation
syntheticDATA_2D = zeros(size(DATA_2D));
nTotalCells = size(DATA_2D,1);
nTotalTrials = dataset.nTrials;
nTotalFrames = dataset.nFrames;
syntheticDATA = zeros(nTotalCells, nTotalTrials, nTotalFrames);
noiseComponent = zeros(nTotalCells, nTotalTrials, nTotalFrames);

%Which cells to select?
putativeTimeCells = zeros(nTotalCells,1);
nPutativeTimeCells = floor((timeCellPercent/100) * nTotalCells);
fprintf('... Number of Putative Time Cells: %i\n', nPutativeTimeCells)
if strcmpi(cellOrder, 'basic')
    putativeTimeCells(1:nPutativeTimeCells) = 1;
elseif strcmpi(cellOrder, 'random')
    %r = randi([1 nTotalCells], 1, nPutativeTimeCells);
    putativeTimeCells(randperm(nTotalCells, nPutativeTimeCells)) = 1;
end

actualEventWidth = zeros(nTotalCells,2);
requiredEventWidth = zeros(nTotalCells,1);
hitTrials = zeros(nTotalCells, nTotalTrials);
hitTrialPercent = zeros(nTotalCells,1);

frameIndex = zeros(nTotalCells, nTotalTrials);
pad = zeros(nTotalCells, nTotalTrials);

%For Putative Time Cells
for cell = 1:nTotalCells
    %fprintf('Cell: %i\n', cell)
    if putativeTimeCells(cell) == 1
        if strcmpi(hitTrialAssignment, 'random')
            hitTrialPercent(cell) = floor(rand() * maxHitTrialPercent);
        elseif strcmpi(hitTrialAssignment, 'fixed')
            hitTrialPercent(cell) = maxHitTrialPercent;
        end
        
        %What trials to select?
        nHitTrials = (hitTrialPercent/100) * nTotalTrials;
        if strcmpi(trialOrder, 'basic')
            hitTrials(cell, 1:nHitTrials) = 1;
        elseif strcmpi(trialOrder, 'random')
            hitTrials(cell, randperm(nTotalTrials, nHitTrials)) = 1;
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
    end
    
    for trial = 1:nTotalTrials
        count = trial - 1;
        %fprintf('Count: %i\n', count)
        if putativeTimeCells(cell) == 1
            if hitTrials(cell, trial) == 1
                eventIndices = find((eventLibrary_2D(cell).eventLengths > actualEventWidth(cell, 1)) & ...
                    (eventLibrary_2D(cell).eventLengths < actualEventWidth(cell, 2)));
                eventStartIndex = randomlyPickEvent(eventIndices, eventLibrary_2D, cell);
                %Now, we pick out exactly one event per trial
                event = DATA_2D(cell, eventStartIndex:1:eventStartIndex+actualEventWidth(cell)-1) * eventAmplificationFactor;
                [~, I] = max(event);
                %disp('Selecting the Frame Index ...')
                while (frameIndex(cell, trial) + pad(cell, trial)) <= I
                    %Pick event(s) based on requiredEventLength
                    [frameIndex(cell, trial), pad(cell, trial)] = selectFrameIndex(eventTiming, startFrame, endFrame, I, imprecisionFWHM, imprecisionType, cell);
                    %Prune trial lengths, if necessary
                    tailClip = (frameIndex(cell, trial) + pad(cell, trial)) + length(event) - 1 - nTotalFrames;
                    
                    if tailClip > 0
                        %fprintf('tail-clip: %i\n', tailClip)
                        syntheticDATA(cell, trial, ((frameIndex(cell, trial) + pad(cell, trial)):((frameIndex(cell, trial) + pad(cell, trial))+length(event) - 1 - tailClip))) = event(1:(length(event) - tailClip));
                    else
                        syntheticDATA(cell, trial, ((frameIndex(cell, trial)+ pad(cell, trial)):(frameIndex(cell, trial) + pad(cell, trial))+length(event)-1)) = event;
                    end
                    %fprintf('syntheticDATA trial length: %i\n', length(syntheticDATA(cell, trial, :)))
                    
                    clear eventIndices
                    clear eventStartIndex
                    clear event
                    clear tailClip
                end
                % Add noise (to hit trials of putative time cells; implicit)
                if ~strcmpi(noise, 'none')
                    [syntheticDATA(cell, trial, :), noiseComponent(cell, trial, :)] = addNoise(squeeze(syntheticDATA(cell, trial, :))', noise, noisePercent);
                end
            else
                % Add noise (for non-hit trials of putative time cells)
                currentTrialOptions = find(squeeze(hitTrials(cell, :)));
                selectedTrialOption = randperm(length(currentTrialOptions), 1);
                
                noiseComponent(cell, trial, :) = noiseComponent(cell, currentTrialOptions(selectedTrialOption), :);
                
                if ~strcmpi(noise, 'none')
                    syntheticDATA(cell, trial, :) = syntheticDATA(cell, trial, :) + noiseComponent(cell, trial, :);
                end
                
                clear currentCellOptions
                clear selectedCellOption
                clear currentTrialOptions
                clear selectedTrialOption
            end
        end
        
        % Add noise (for non-putative time cells; explicit)
        if putativeTimeCells(cell) == 0
            currentCellOptions = find(putativeTimeCells, cell);
            selectedCellOption = randperm(length(currentCellOptions), 1);
            currentTrialOptions = find(squeeze(hitTrials(selectedCellOption, :)));
            selectedTrialOption = randperm(length(currentTrialOptions), 1);
            
            noiseComponent(cell, trial, :) = noiseComponent(currentCellOptions(selectedCellOption), currentTrialOptions(selectedTrialOption), :);
            
            if ~strcmpi(noise, 'none')
                syntheticDATA(cell, trial, :) = syntheticDATA(cell, trial, :) + noiseComponent(cell, trial, :);
            end
            
            clear currentCellOptions
            clear selectedCellOption
            clear currentTrialOptions
            clear selectedTrialOption
        end
        
        %Ceil negative values to 0
        syntheticDATA(syntheticDATA<0) = 0;
        
        %Reshape the synthetic data into a 2D matrix
        syntheticDATA_2D(cell,(((count*nTotalFrames)+1):(count*nTotalFrames)+nTotalFrames)) = syntheticDATA(cell,trial,:);
    end
    
end
disp('... done!')

end