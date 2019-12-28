%syntheticDataMaker
%Written by Kambadur Ananthamurthy
function [syntheticDATA, putativeTimeCells, requiredEventLength] = syntheticDataMaker(DATA, DATA_2D, eventLibrary_2D, timeCellFraction, hitTrialFraction, trialOrder, eventSize, cellOrder, eventTiming)
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
            %TBA
        else
        end
    else
        %Skip cell
    end
    
    %What trials to select?
    nTotalTrials = size(DATA,2);
    hitTrials = zeros(nTotalTrials,1);
    if strcmp(trialOrder, 'basic')
        nHitTrials = hitTrialFraction * nTotalTrials;
        hitTrials(1:nHitTrials) = 1;
    elseif strcmp(trialOrder, 'random')
        %TBA
    end
    
    %Prepare the dataset
    %nTotalFrames = size(DATA,3);
    if putativeTimeCells(cell) == 1
        for trial = 1:nTotalTrials
            if hitTrials == 1
            %What timing/frame to select?
            if strcmp(eventTiming, 'basic')
                %Perfect sequence
                frameIndex = cell;
                %Pick event based on requiredEventLength
                eventNumber = eventLibrary_2D(cell).eventLengths == requiredEventLength(cell);
                eventStartIndex = eventLibrary_2D(cell).eventStartIndices(eventNumber);
                event = DATA_2D(cell, eventStartIndex:1:eventStartIndex+requiredEventLength(cell)-1);
                syntheticDATA(cell, trial, frameIndex:frameIndex+length(event)-1) = event;
                
                clear eventNumber
                clear eventStartIndex
                clear event
            elseif strcmp(eventTiming, 'random')
                %TBA
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