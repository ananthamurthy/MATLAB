%syntheticDataMaker
%Written by Kambadur Ananthamurthy
function [syntheticDATA, putativeTimeCells, requiredEventLength] = syntheticDataMaker(DATA, DATA_2D, eventLibrary_2D, ...
    timeCellFraction, cellOrder, ...
    maxHitTrialFraction, trialOrder, ...
    eventSize, eventTiming, ...
    precision, noise);
syntheticDATA = zeros(size(DATA));
nTotalCells = size(DATA,1);

%Which cells to select?
putativeTimeCells = zeros(nTotalCells,1);
if strcmp(cellOrder, 'basic')
    nPutativeTimeCells = timeCellFraction * nTotalCells;
    putativeTimeCells(1:nPutativeTimeCells) = 1;
elseif strcmp(cellOrder, 'random')
    %TBA
end

requiredEventLength = zeros(nTotalCells,1);
for cell = 1:nTotalCells
    if putativeTimeCells(cell) == 1
        %What size of calcium events to select?
        if strcmp(eventSize, 'max')
            %disp('Using the largest calcium events ...')
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
            if hitTrials(trial) == 1
                %What timing/frame to select?
                if strcmp(eventTiming, 'basic')
                    %Perfect sequence
                    frameIndex = cell;
                    %Pick event based on requiredEventLength
                    eventNumber = eventLibrary_2D(cell).eventLengths == requiredEventLength(cell);
                    eventStartIndex = eventLibrary_2D(cell).eventStartIndices(eventNumber);
                    event = DATA_2D(cell, eventStartIndex:1:eventStartIndex+requiredEventLength(cell)-1);
                    %Add the effect of "precision"
                    pad = floor(rand()*precision(1) + floor(rand()*precision(2)));
                    syntheticDATA(cell, trial, (frameIndex+pad):(frameIndex+pad)+length(event)-1) = event;
                    
                    clear eventNumber
                    clear eventStartIndex
                    clear event
                
                elseif strcmp(eventTiming, 'clustered')
                    startFrame = floor(trialDetails.preDuration * trialDetails.frameRate);
                    endFrame = floor( (trialDetails.preDuration ...
                        + trialDetails.csDuration ...
                        + trialDetails.traceDuration) * trialDetails.frameRate);
                    frameIndex = floor(rand()*(endFrame - startFrame)) + startFrame;
                    %Pick event based on requiredEventLength
                    eventNumber = eventLibrary_2D(cell).eventLengths == requiredEventLength(cell);
                    eventStartIndex = eventLibrary_2D(cell).eventStartIndices(eventNumber);
                    event = DATA_2D(cell, eventStartIndex:1:eventStartIndex+requiredEventLength(cell)-1);
                    %Add the effect of "precision"
                    pad = floor(rand()*precision(1) + floor(rand()*precision(2)));
                    syntheticDATA(cell, trial, (frameIndex+pad):(frameIndex+pad)+length(event)-1) = event;
                
                elseif strcmp(eventTiming, 'random')
                    frameIndex = floor(rand()*(size(DATA,3) - 10)); %Avoiding the first 10 frames
                    %Pick event based on requiredEventLength
                    eventNumber = eventLibrary_2D(cell).eventLengths == requiredEventLength(cell);
                    eventStartIndex = eventLibrary_2D(cell).eventStartIndices(eventNumber);
                    event = DATA_2D(cell, eventStartIndex:1:eventStartIndex+requiredEventLength(cell)-1);
                    %Add the effect of "precision"
                    pad = floor(rand()*precision(1) + floor(rand()*precision(2)));
                    syntheticDATA(cell, trial, (frameIndex+pad):(frameIndex+pad)+length(event)-1) = event;
                end
            else
                %Skip trial
            end
        end
    else
        %Skip cell
    end
    
end

end