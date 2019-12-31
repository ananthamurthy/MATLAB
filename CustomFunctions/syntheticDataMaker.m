%syntheticDataMaker
%Written by Kambadur Ananthamurthy
function [syntheticDATA, syntheticDATA_2D, putativeTimeCells, requiredEventLength] = syntheticDataMaker(dataset, DATA, DATA_2D, eventLibrary_2D, ...
    timeCellFraction, cellOrder, ...
    maxHitTrialFraction, trialOrder, ...
    eventSize, eventTiming, ...
    imprecision, noise)
syntheticDATA = zeros(size(DATA));
syntheticDATA_2D = zeros(size(DATA,1),size(DATA,2)*size(DATA,3));
nTotalCells = size(DATA,1);
nFrames = dataset.nFrames;

%INFORMATION
fprintf('... using cell order: %s ...\n', cellOrder)
fprintf('... using event size: %s ...\n', eventSize)
fprintf('... using trial order: %s ...\n', trialOrder)
fprintf('... using event timing: %s ...\n', cellOrder)
fprintf('... adding noise: %s ...\n', noise)

%Which cells to select?
putativeTimeCells = zeros(nTotalCells,1);
nPutativeTimeCells = timeCellFraction * nTotalCells;
if strcmp(cellOrder, 'basic')
    putativeTimeCells(1:nPutativeTimeCells) = 1;
elseif strcmp(cellOrder, 'random')
    r = randi([1 nTotalCells], 1, nPutativeTimeCells);
    putativeTimeCells(r) = 1;
end

requiredEventLength = zeros(nTotalCells,1);
for cell = 1:nTotalCells
    %fprintf('Cell: %i\n', cell)
    if putativeTimeCells(cell) == 1
        %What size of calcium events to select?
        if strcmp(eventSize, 'max')
            requiredEventLength(cell) = max(eventLibrary_2D(cell).eventLengths);
        elseif strcmp(eventSize, 'large')
            requiredEventLength(cell) = prctile(eventLibrary_2D(cell).eventLengths, 75);
        elseif strcmp(eventSize, 'medium')
            requiredEventLength(cell) = prctile(eventLibrary_2D(cell).eventLengths, 50);
        elseif strcmp(eventSize, 'small')
            requiredEventLength(cell) = prctile(eventLibrary_2D(cell).eventLengths, 25);
        elseif strcmp(eventSize, 'random')
            %Mix of all sizes of events
            %TBA
        else
            error('Unknown event size')
        end
    else
        %Skip cell
    end
    
    %What trials to select?
    nTotalTrials = size(DATA,2);
    hitTrials = zeros(nTotalTrials,1);
    hitTrialFraction = floor(rand() * maxHitTrialFraction);
    nHitTrials = hitTrialFraction * nTotalTrials;
    if strcmp(trialOrder, 'basic')
        hitTrials(1:nHitTrials) = 1;
    elseif strcmp(trialOrder, 'random')
        for trial = 1:nTotalTrials
            if sum(hitTrials) == maxHitTrialFraction*nTotalTrials
                continue
            else
                if rand() >= 0.5
                    hitTrials(trial) = 1;
                else
                    %hitTrial(trial) = 0; %Unnecessary if preallocated.
                end
            end
        end
    end
    
    %Prepare the dataset
    %nTotalFrames = size(DATA,3);
    if putativeTimeCells(cell) == 1
        for trial = 1:nTotalTrials
            count = trial - 1;
            %fprintf('Count: %i\n', count)
            if hitTrials(trial) == 1
                %What timing/frame to select?
                if strcmp(eventTiming, 'basic')
                    %Perfect sequence
                    frameIndex = cell + 10; %Avoiding the first 10 frames
                    %fprintf('frameIndex: %i\n', frameIndex)
                    %Pick event based on requiredEventLength
                    eventNumber = eventLibrary_2D(cell).eventLengths == requiredEventLength(cell);
                    eventStartIndex = eventLibrary_2D(cell).eventStartIndices(eventNumber);
                    event = DATA_2D(cell, eventStartIndex:1:eventStartIndex+requiredEventLength(cell)-1);
                    %Add the effect of "precision"
                    pad = floor(rand()*imprecision(1) + floor(rand()*imprecision(2)));
                    syntheticDATA(cell, trial, ((frameIndex+pad):(frameIndex+pad)+length(event)-1)) = event;
                    %fprintf('syntheticDATA trial length: %i\n', length(syntheticDATA(cell, trial, :)))
                elseif strcmp(eventTiming, 'clustered')
                    startFrame = 116;
                    endFrame = 123;
                    frameIndex = floor(rand()*(endFrame - startFrame)) + startFrame;
                    %fprintf('frameIndex: %i\n', frameIndex)
                    %Pick event based on requiredEventLength
                    eventNumber = eventLibrary_2D(cell).eventLengths == requiredEventLength(cell);
                    eventStartIndex = eventLibrary_2D(cell).eventStartIndices(eventNumber);
                    event = DATA_2D(cell, eventStartIndex:1:eventStartIndex+requiredEventLength(cell)-1);
                    %Add the effect of "precision"
                    pad = floor(rand()*imprecision(1) + floor(rand()*imprecision(2)));
                    syntheticDATA(cell, trial, ((frameIndex+pad):(frameIndex+pad)+length(event)-1)) = event;
                    %fprintf('syntheticDATA trial length: %i\n', length(syntheticDATA(cell, trial, :)))
                elseif strcmp(eventTiming, 'random')
                    startFrame = 10; %Avoiding the first 10 frames
                    endFrame = nFrames - 80; %Avoiding the last 80 frames
                    frameIndex = floor(rand()*(endFrame - startFrame)) + startFrame;
                    %fprintf('frameIndex: %i\n', frameIndex)
                    %Pick event based on requiredEventLength
                    eventNumber = eventLibrary_2D(cell).eventLengths == requiredEventLength(cell);
                    eventStartIndex = eventLibrary_2D(cell).eventStartIndices(eventNumber);
                    event = DATA_2D(cell, eventStartIndex:1:eventStartIndex+requiredEventLength(cell)-1);
                    %Add the effect of "precision"
                    pad = floor(rand()*imprecision(1) + floor(rand()*imprecision(2)));
                    syntheticDATA(cell, trial, ((frameIndex+pad):(frameIndex+pad)+length(event)-1)) = event;
                    %fprintf('syntheticDATA trial length: %i\n', length(syntheticDATA(cell, trial, :)))
                end
                
                clear eventNumber
                clear eventStartIndex
                clear event
                
                %Reshape the synthetic data into a 2D matrix
                syntheticDATA_2D(cell,(((count*nFrames)+1):(count*nFrames)+nFrames)) = syntheticDATA(cell,trial,:);
            else
                %Skip trial
                %Reshape the synthetic data into a 2D matrix
                syntheticDATA_2D(cell,(((count*nFrames)+1):(count*nFrames)+nFrames)) = syntheticDATA(cell,trial,:);
            end
            %Add noise (irrespective of hit trial)
            if strcmp(noise, 'none')
            elseif strcmp(noise, 'gaussian')
                %syntheticDATA(cell, trial,:) = awgn((syntheticDATA(cell, trial, :)), 15, 'measured');
            end
        end
    else
        %Skip cell
    end
    
end

end