%syntheticDataMaker
%Written by Kambadur Ananthamurthy
function [syntheticDATA, syntheticDATA_2D, putativeTimeCells, requiredEventLengths] = syntheticDataMaker(dataset, DATA, DATA_2D, eventLibrary_2D, ...
    percentTimeCells, cellOrder, ...
    maxPercentHitTrials, hitTrialAssignment, trialOrder, ...
    eventWidth, eventAmplificationFactor, eventTiming, startFrame, endFrame, ...
    imprecisionFWHM, imprecisionType, ...
    noise, noisePercent)
syntheticDATA = zeros(size(DATA));
syntheticDATA_2D = zeros(size(DATA,1),size(DATA,2)*size(DATA,3));
nTotalCells = size(DATA,1);
nFrames = dataset.nFrames;
%nFrames = db.nFrames;

%INFORMATION
% fprintf('... using cell order: %s ...\n', cellOrder)
% %fprintf('... using event width - percentile: %i, width: %s ...\n', eventWidth(1), eventWidth(2))
% fprintf('... using trial order: %s ...\n', trialOrder)
% fprintf('... using event timing: %s ...\n', cellOrder)
% fprintf('... adding noise: %s ...\n', noise)

%Which cells to select?
putativeTimeCells = zeros(nTotalCells,1);
nPutativeTimeCells = floor((percentTimeCells/100) * nTotalCells);
fprintf('Number of Putative Time Cells: %i\n', nPutativeTimeCells)
if strcmpi(cellOrder, 'basic')
    putativeTimeCells(1:nPutativeTimeCells) = 1;
elseif strcmpi(cellOrder, 'random')
    %r = randi([1 nTotalCells], 1, nPutativeTimeCells);
    putativeTimeCells(randperm(nTotalCells, nPutativeTimeCells)) = 1;
end

requiredEventLengths = zeros(nTotalCells,2);
requiredEventWidth = zeros(nTotalCells,1);
for cell = 1:nTotalCells
    %fprintf('Cell: %i\n', cell)
    if putativeTimeCells(cell) == 1
        %What size of calcium events to select?
        if strcmpi(eventWidth(2), 'stddev') %Only defined case with a string argument
            requiredEventWidth(cell) = std(eventLibrary_2D(cell).eventLengths);
            requiredEventLengths(cell, 1) = floor(max(eventLibrary_2D(cell).eventLengths) - requiredEventWidth(cell));
            requiredEventLengths(cell, 2) = ceil(max(eventLibrary_2D(cell).eventLengths) + requiredEventWidth(cell));
        else
            requiredEventWidth(cell) = eventWidth{2}; %Use the actual argument value
            requiredEventLengths(cell, 1) = floor(prctile(eventLibrary_2D(cell).eventLengths, eventWidth{1})) - requiredEventWidth(cell);
            requiredEventLengths(cell, 2) = ceil(prctile(eventLibrary_2D(cell).eventLengths, eventWidth{1})) + requiredEventWidth(cell);
        end
    else
        %Skip cell
    end
    
    %What trials to select?
    nTotalTrials = size(DATA,2);
    hitTrials = zeros(nTotalTrials,1);
    
    if strcmpi(hitTrialAssignment, 'random')
        percentHitTrials = floor(rand() * (maxPercentHitTrials));
    elseif strcmpi(hitTrialAssignment, 'fixed')
        percentHitTrials = (maxPercentHitTrials);
    else
    end
    
    nHitTrials = (percentHitTrials/100) * nTotalTrials;
    if strcmpi(trialOrder, 'basic')
        hitTrials(1:nHitTrials) = 1;
    elseif strcmpi(trialOrder, 'random')
        hitTrials(randperm(nTotalTrials, nHitTrials)) = 1;
    end
    
    %Prepare the dataset
    %nTotalFrames = size(DATA,3);
    if putativeTimeCells(cell) == 1
        for trial = 1:nTotalTrials
            count = trial - 1;
            %fprintf('Count: %i\n', count)
            if hitTrials(trial) == 1
                frameIndex = 0; %Only for Initialization
                pad = 0; %Only for Initialization
                I = 0; %Only for Initialization
                %disp('Selecting the Frame Index ...')
                while (frameIndex + pad) <= I
                    %Pick event(s) based on requiredEventLength
                    eventIndices = find((eventLibrary_2D(cell).eventLengths > requiredEventLengths(cell, 1)) & ...
                        (eventLibrary_2D(cell).eventLengths < requiredEventLengths(cell, 2)));
                    eventStartIndex = randomlyPickEvent(eventIndices, eventLibrary_2D, cell);
                    %Now, we pick out exactly one event per trial
                    event = DATA_2D(cell, eventStartIndex:1:eventStartIndex+requiredEventLengths(cell)-1) * eventAmplificationFactor;
                    [~, I] = max(event);
                    [frameIndex, pad] = selectFrameIndex(eventTiming, startFrame, endFrame, I, imprecisionFWHM, imprecisionType, cell);
                end
                
                %Prune trial lengths, if necessary
                tailClip = (frameIndex+pad) + length(event) - 1 - nFrames;
                
                if tailClip > 0
                    %fprintf('tail-clip: %i\n', tailClip)
                    syntheticDATA(cell, trial, ((frameIndex+pad):((frameIndex+pad)+length(event) - 1 - tailClip))) = event(1:(length(event) - tailClip));
                else
                    syntheticDATA(cell, trial, ((frameIndex+pad):(frameIndex+pad)+length(event)-1)) = event;
                end
                %fprintf('syntheticDATA trial length: %i\n', length(syntheticDATA(cell, trial, :)))
                
                clear eventIndices
                clear eventStartIndex
                clear event
                clear tailClip
                
            else
                %Skip trial
            end
            
            %Add noise (irrespective of hit trial)
            if ~strcmpi(noise, 'none')
                syntheticDATA(cell, trial, :) = addNoise(squeeze(syntheticDATA(cell, trial, :))', noise, noisePercent);
            end
            
            %Reshape the synthetic data into a 2D matrix
            syntheticDATA_2D(cell,(((count*nFrames)+1):(count*nFrames)+nFrames)) = syntheticDATA(cell,trial,:);
        end
    else
        %Skip cell
    end
    
end

end