%syntheticDataMaker
%Written by Kambadur Ananthamurthy
function output = syntheticDataMaker(dataset, DATA_2D, eventLibrary_2D, control)

disp('Creating synthetic data ...')

%Preallocation
nTotalCells = size(DATA_2D,1);
nTotalTrials = dataset.nTrials;
nTotalFrames = dataset.nFrames;
syntheticDATA = zeros(nTotalCells, nTotalTrials, nTotalFrames);
syntheticDATA_2D = zeros(nTotalCells, nTotalTrials*nTotalFrames);
noiseComponent = zeros(nTotalCells, nTotalTrials, nTotalFrames);

%Which cells to select?
nPutativeTimeCells = floor((control.timeCellPercent/100) * nTotalCells);
fprintf('... Number of Putative Time Cells: %i\n', nPutativeTimeCells)
if strcmpi(control.cellOrder, 'basic')
    ptcList = 1:nPutativeTimeCells;
    ocList = (nPutativeTimeCells+1):nTotalCells;
elseif strcmpi(control.cellOrder, 'random')
    ptcList = randperm(nTotalCells, nPutativeTimeCells);
    ocList = 1:nTotalCells;
    ocList(ptcList) = [];
else
    error('Unknown Cell Order')
end

actualEventWidthRange = zeros(nTotalCells, 2);
requiredEventWidth = zeros(nTotalCells, 1);
hitTrials = zeros(nTotalCells, nTotalTrials);
hitTrialPercent = zeros(nTotalCells, 1);

frameIndex = nan(nTotalCells, nTotalTrials);
pad = zeros(nTotalCells, nTotalTrials);

for cell = 1:nTotalCells
    %disp(cell)
    %For Putative Time Cells
    if ismember(cell, ptcList)
        if strcmpi(control.hitTrialPercentAssignment, 'fixed')
            hitTrialPercent(cell) = control.maxHitTrialPercent;
        elseif strcmpi(control.hitTrialPercentAssignment, 'random')
            hitTrialPercent(cell) = randi([floor(control.maxHitTrialPercent/2), control.maxHitTrialPercent]); % Ensures that the range of Hit Trial Percent is within [max/2, max]
            %hitTrialPercent(cell) = randi(sdcp.maxHitTrialPercent);
        else
            error('Unknown sdcp.hitTrialPercentAssignment')
        end
        
        %What trials to select?
        nHitTrials = floor((hitTrialPercent(cell)/100) * nTotalTrials);
        if strcmpi(control.trialOrder, 'basic')
            hitTrials(cell, 1:nHitTrials) = 1;
        elseif strcmpi(control.trialOrder, 'random')
            hitTrials(cell, 1) = 1;
            hitTrials(cell, randperm(nTotalTrials, (nHitTrials-1))) = 1;
        else
            error('Unknown sdcp.trialOrder')
        end
        
        %What size of calcium events to select?
        if strcmpi(control.eventWidth(2), 'stddev') %One stddev worth of options
            requiredEventWidth(cell) = std(eventLibrary_2D(cell).eventWidths);
            actualEventWidthRange(cell, 1) = floor(max(eventLibrary_2D(cell).eventWidths) - requiredEventWidth(cell)); % Min
            actualEventWidthRange(cell, 2) = ceil(max(eventLibrary_2D(cell).eventWidths) + requiredEventWidth(cell)); % Max
        elseif strcmpi(control.eventWidth(2), 'same') %same option every time
            actualEventWidthRange(cell, 1) = prctile(eventLibrary_2D(cell).eventWidths, control.eventWidth{1});
            actualEventWidthRange(cell, 2) = prctile(eventLibrary_2D(cell).eventWidths, control.eventWidth{1}); %NOTE: keeping max and min the same.
        else
            requiredEventWidth(cell) = control.eventWidth{2};
            actualEventWidthRange(cell, 1) = floor(prctile(eventLibrary_2D(cell).eventWidths, control.eventWidth{1})) - requiredEventWidth(cell); % Min
            actualEventWidthRange(cell, 2) = ceil(prctile(eventLibrary_2D(cell).eventWidths, control.eventWidth{1})) + requiredEventWidth(cell); % Max
        end
        
        %This section is only important for the sequential case
        %Here we need to define which frame each cell gets targetted to
        if control.eventTiming == 'sequential'
            nGroups = control.endFrame - control.startFrame;
            if length(ptcList) >= nGroups
                nCellsPerFrame = floor(length(ptcList)/nGroups);
                frameGroup = ceil(find(ptcList == cell)/nCellsPerFrame);
            else
                frameGroup = cell; %uses the cell index
            end
        else
            frameGroup = 0;
        end
        
        for trial = 1:nTotalTrials
            if hitTrials(cell, trial) == 1
                eventIndices = find((eventLibrary_2D(cell).eventWidths >= actualEventWidthRange(cell, 1)) & ...
                    (eventLibrary_2D(cell).eventWidths <= actualEventWidthRange(cell, 2)));
                if isempty(eventIndices)
                    warning('No suitable events found for cell: %i. Continuing to next cell ...', num2str(cell));
                    break
                end
                eventStartIndex = randomlyPickEvent(eventIndices, eventLibrary_2D, cell);
                %Now, we pick out exactly one event per trial
                event = DATA_2D(cell, eventStartIndex:1:eventStartIndex+actualEventWidthRange(cell)-1);
                
                % Generate noise
                noiseComponent(cell, trial, :) = generateNoise(event, control.noise, control.noisePercent, nTotalFrames);
                % Add noise
                if ~strcmpi(control.noise, 'none')
                    syntheticDATA(cell, trial, :) = noiseComponent(cell, trial, :);
                end
                
                %disp('Selecting the Frame Index ...')
                [frameIndex(cell, trial), pad(cell, trial)] = selectFrameIndex(control.eventTiming, control.startFrame, control.endFrame, control.imprecisionFWHM, control.imprecisionType, frameGroup);
                %fprintf('For cell: %i, trial: %i, the frameIndex is %i and the pad is %i\n', cell, trial, frameIndex(cell, trial), pad(cell, trial))
                
                [~, I] = max(event);
                %Prune trial lengths, if necessary
                tailClip = (frameIndex(cell, trial) + pad(cell, trial)) + length(event) - 1 - nTotalFrames;
                
                if tailClip > 0
                    %fprintf('tail-clip: %i\n', tailClip)
                    syntheticDATA(cell, trial, ((frameIndex(cell, trial) + pad(cell, trial)) - I :((frameIndex(cell, trial) + (pad(cell, trial)) - I + length(event)) - 1 - tailClip))) = event(1:(length(event) - tailClip)) * control.eventAmplificationFactor;
                else
                    syntheticDATA(cell, trial, ((frameIndex(cell, trial)+ pad(cell, trial)) - I :(frameIndex(cell, trial) + (pad(cell, trial)) - I + length(event) - 1))) = event * control.eventAmplificationFactor;
                end
                %fprintf('syntheticDATA trial length: %i\n', length(syntheticDATA(cell, trial, :)))
                %fprintf('Event added to cell:%i, trial:%i at frame:%i\n', cell, trial, (frameIndex(cell, trial)+ pad (cell, trial)))
                
                clear eventIndices
                clear eventStartIndex
                clear event
                clear tailClip
                %disp(frameIndex(cell, trial) + pad(cell, trial))
            elseif hitTrials(cell, trial) == 0 % For Non-Hit Trials
                frameIndex(cell, trial) = nan;
                pad(cell, trial) = nan;
                
                % Add noise
                currentTrialOptions = find(hitTrials(cell, 1:trial));
                selectedTrialOption = randperm(length(currentTrialOptions), 1);
                
                noiseComponent(cell, trial, :) = noiseComponent(cell, currentTrialOptions(selectedTrialOption), :);
                
                if ~strcmpi(control.noise, 'none')
                    syntheticDATA(cell, trial, :) = syntheticDATA(cell, trial, :) + noiseComponent(cell, trial, :);
                end
            else
                error('Unknown case for hitTrial')
            end
        end
    elseif ismember(cell, ocList) % For Other Cells
        frameIndex(cell, :) = nan;
        pad(cell, :) = nan;
        
        % Add noise
        selectedCellOption = ptcList(randperm(length(ptcList), 1));
        
        for trial = 1:nTotalTrials
            
            noiseComponent(cell, trial, :) = noiseComponent(selectedCellOption, trial, :);
            
            if ~strcmpi(control.noise, 'none')
                syntheticDATA(cell, trial, :) = syntheticDATA(cell, trial, :) + noiseComponent(cell, trial, :);
            end
            
            %             % Since no target frame is required
            %             frameIndex(cell, trial) = nan;
            %             pad(cell, trial) = nan;
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

%Setup output structure
output.syntheticDATA = syntheticDATA;
output.syntheticDATA_2D = syntheticDATA_2D;
output.ptcList = ptcList;
output.ocList = ocList;
output.actualEventWidth = actualEventWidthRange;
output.hitTrialPercent = hitTrialPercent;
output.hitTrials = hitTrials;
output.frameIndex = frameIndex;
output.pad = pad;
output.noiseComponent = noiseComponent;

disp('... done!')
end