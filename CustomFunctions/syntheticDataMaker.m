%syntheticDataMaker
%Written by Kambadur Ananthamurthy
function output = syntheticDataMaker(dataset, DATA_2D, eventLibrary_2D, control)

disp('Creating synthetic data ...')

%Preallocation
nCells = size(DATA_2D,1);
nTrials = dataset.nTrials;
nFrames = dataset.nFrames;
syntheticDATA = zeros(nCells, nTrials, nFrames);
syntheticDATA_2D = zeros(nCells, nTrials*nFrames);
noiseComponent = zeros(nCells, nFrames);
eventMax = zeros(nCells, nTrials);
maxSignal = zeros(nCells, 1);

%Which cells to select?
nPutativeTimeCells = floor((control.timeCellPercent/100) * nCells);
fprintf('... Number of Putative Time Cells: %i\n', nPutativeTimeCells)
if nPutativeTimeCells ~= 0
    if strcmpi(control.cellOrder, 'basic')
        ptcList = 1:nPutativeTimeCells;
        ocList = (nPutativeTimeCells+1):nCells;
    elseif strcmpi(control.cellOrder, 'random')
        ptcList = randperm(nCells, nPutativeTimeCells);
        ocList = 1:nCells;
        ocList(ptcList) = [];
    else
        error('Unknown Cell Order')
    end
else
    ptcList = [];
    ocList = 1:nCells;
end

actualEventWidthRange = zeros(nCells, 2);
requiredEventWidth = zeros(nCells, 1);
hitTrials = zeros(nCells, nTrials);
hitTrialPercent = zeros(nCells, 1);

frameIndex = nan(nCells, nTrials);
pad = zeros(nCells, nTrials);

for cell = 1:nCells
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
        nHitTrials = floor((hitTrialPercent(cell)/100) * nTrials);
        if strcmpi(control.trialOrder, 'basic')
            hitTrials(cell, 1:nHitTrials) = 1;
        elseif strcmpi(control.trialOrder, 'random')
            hitTrials(cell, 1) = 1;
            hitTrials(cell, randperm(nTrials, (nHitTrials-1))) = 1;
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
        if strcmpi(control.eventTiming, 'sequential')
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
        
        for trial = 1:nTrials
            if hitTrials(cell, trial) == 1
                eventIndices = find((eventLibrary_2D(cell).eventWidths >= actualEventWidthRange(cell, 1)) & ...
                    (eventLibrary_2D(cell).eventWidths <= actualEventWidthRange(cell, 2)));
                if isempty(eventIndices)
                    warning('No suitable events found for cell: %i. Continuing to next cell ...\n', num2str(cell));
                    break
                end
                eventStartIndex = randomlyPickEvent(eventIndices, eventLibrary_2D, cell);
                %Now, we pick out exactly one event per trial
                event = DATA_2D(cell, eventStartIndex:1:eventStartIndex+actualEventWidthRange(cell)-1);
                
                %disp('Selecting the Frame Index ...')
                [frameIndex(cell, trial), pad(cell, trial)] = selectFrameIndex(control.eventTiming, control.startFrame, control.endFrame, control.imprecisionFWHM, control.imprecisionType, frameGroup);
                %fprintf('For cell: %i, trial: %i, the frameIndex is %i and the pad is %i\n', cell, trial, frameIndex(cell, trial), pad(cell, trial))
                
                [eventMax(cell, trial), I] = max(event);
                %Prune trial lengths, if necessary
                tailClip = (frameIndex(cell, trial) + pad(cell, trial)) + length(event) - 1 - nFrames;
                
                if tailClip > 0
                    %fprintf('tail-clip: %i\n', tailClip)
                    %remove a tailClip number of frames from the end of the
                    %event before insertion (by replacement)
                    syntheticDATA(cell, trial, ((frameIndex(cell, trial) + pad(cell, trial)) - I :((frameIndex(cell, trial) + (pad(cell, trial)) - I + length(event)) - 1 - tailClip))) = event(1:(length(event) - tailClip)) * control.eventAmplificationFactor;
                else
                    try
                        %directly insert the event (by replacement)
                        syntheticDATA(cell, trial, ((frameIndex(cell, trial)+ pad(cell, trial)) - I :(frameIndex(cell, trial) + (pad(cell, trial)) - I + length(event) - 1))) = event * control.eventAmplificationFactor;
                    catch
                        error('Cannot insert event as Pad: %d', pad(cell, trial))
                    end
                end
                %fprintf('syntheticDATA trial length: %i\n', length(syntheticDATA(cell, trial, :)))
                %fprintf('Event added to cell:%i, trial:%i at frame:%i\n', cell, trial, (frameIndex(cell, trial)+ pad (cell, trial)))
                
                clear eventIndices
                clear eventStartIndex
                clear event
                clear tailClip
                %disp(frameIndex(cell, trial) + pad(cell, trial))
                
            elseif hitTrials(cell, trial) == 0 % For Non-Hit Trials
                %do nothing
            else
                error('Unknown case for hitTrial')
            end
            
        end
    elseif ismember(cell, ocList) % For Other Cells
        %do nothing
    else
        error('Unknown nature of cell')
    end
    maxSignal(cell) = max(eventMax(cell, :));
    %fprintf('Max signal value for cell:%i is %d\n', cell, maxSignal(cell))
end

% Noise
if ~strcmpi(control.noise, 'none')
    for cell = 1:nCells
        if ismember(cell, ptcList)
            %disp(cell)
            ceil2zero = 1;
            % Generate noise
            noiseComponent(cell, :) = squeeze(generateNoise(maxSignal(cell), control.noise, control.noisePercent, nFrames, ceil2zero));
            
            % Add noise
            for trial = 1:nTrials
                syntheticDATA(cell, trial, :) = squeeze(syntheticDATA(cell, trial, :)) + noiseComponent(cell, :)';
            end
            
        elseif ismember(cell, ocList)
            selectedCellOption = ptcList(randperm(length(ptcList), 1));
            noiseComponent(cell, :) = noiseComponent(selectedCellOption, :);
            
            %Add noise
            for trial = 1:nTrials
                syntheticDATA(cell, trial, :) = squeeze(syntheticDATA(cell, trial, :)) + noiseComponent(cell, :)';
            end
        else
            error('Unknown nature of cell')
        end
    end
end

%2D Synthetic Data
for cell = 1:nCells
    syntheticDATA_2D(cell, :) = reshape(squeeze(syntheticDATA(cell, :, :))', 1, []);
end

%Setup output structure
output.syntheticDATA = syntheticDATA;
output.syntheticDATA_2D = syntheticDATA_2D;
output.maxSignal = maxSignal;
output.ptcList = ptcList;
output.ocList = ocList;
output.nCells = nCells;
output.actualEventWidth = actualEventWidthRange;
output.hitTrialPercent = hitTrialPercent;
output.hitTrials = hitTrials;
output.frameIndex = frameIndex;
output.pad = pad;
output.noiseComponent = noiseComponent;

% %Populated elsewhere
% output.scurr = {};
% output.Q = [];
% output.T = [];
% output.endtime = '';

disp('... done!')
end