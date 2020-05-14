function [X_all, X, X0, Y_all, Y, Yfit_actual, trainingCells, testingCells] = createDataMatrix4Classification(DATA, input)

nCells = size(DATA, 1);
nTrials = size(DATA, 2);
nFrames = size(DATA, 3); %per trial
%nTotalFrames = nTrials*nFrames; %total frames in dataset.

if strcmpi(input.whichCells, 'first')
    trainingCells = 1:floor(nCells/2);
    testingCells = floor(nCells/2)+1:nTrials;
    
elseif strcmpi(input.whichCells, 'alternate')
    trainingCells = 1:2:nCells;
    testingCells = 2:2:nCells;
    
elseif strcmpi(input.whichCells, 'random')
    allCells = 1:nCells;
    trainingCells = sort(randperm(nCells, floor(nCells/2)));
    testingCells = allCells;
    testingCells(trainingCells) = [];
    clear allTrials
    
elseif strcmpi(input.whichCells, 'timecells')
    trainingCells = input.ptcList;
    testingCells = input.ocList;
    
elseif strcmpi(input.whichCells, 'othercells')
    trainingCells = input.ocList;
    testingCells = input.ptcList;
    
elseif strcmpi(input.whichCells, 'all')
    trainingCells = 1:nCells;
    testingCells = 1:nCells;
    
else
    error('Unable to select test cells')
end

X_all = [];
X = [];
X0 = [];

Y_all = [];
Y = [];
Yfit_actual = [];

fprintf('Label Shuffle Control: %s\n', input.labelShuffle)
if strcmpi(input.labelShuffle, 'on')
    randomCells = randperm(nCells);
end

if input.crossValidate == 1
    %Training Cells
    for cellIndex = 1:length(trainingCells)
        %disp(cellIndex)
        
        trainingData_ = squeeze(DATA(trainingCells(cellIndex), :, :))'; % nFrames x nTrials
        X = [X; trainingData_]; %reshaped data
        %size(Xprime)
        
        %Training Labels
        if strcmpi(input.labelShuffle, 'on')
            if ismember(randomCells(cellIndex), input.ptcList)
                Y(((nFrames*(cellIndex-1)) + 1): ((nFrames*(cellIndex-1)) +nFrames), 1) = 1;
            elseif ismember(randomCells(cellIndex), input.ocList)
                Y(((nFrames*(cellIndex-1)) + 1): ((nFrames*(cellIndex-1)) +nFrames), 1) = 0;
            end
            
        elseif strcmpi(input.labelShuffle, 'off')
            if strcmpi(input.whichCells, 'timecells')
                Y(((nFrames*(cellIndex-1)) + 1): ((nFrames*(cellIndex-1)) +nFrames), 1) = 1;
            elseif strcmpi(input.whichCells, 'othercells')
                Y(((nFrames*(cellIndex-1)) + 1): ((nFrames*(cellIndex-1)) +nFrames), 1) = 0;
            else
                if ismember(trainingCells(cellIndex), input.ptcList)
                    Y(((nFrames*(cellIndex-1)) + 1): ((nFrames*(cellIndex-1)) +nFrames), 1) = 1;
                elseif ismember(trainingCells(cellIndex), input.ocList)
                    Y(((nFrames*(cellIndex-1)) + 1): ((nFrames*(cellIndex-1)) +nFrames), 1) = 0;
                end
            end
        else
            error('Unable to determine if label shuffle control is on/off')
        end
    end
    
    %Testing Cells
    for cellIndex = 1:length(testingCells)
        %disp(cellIndex)
        
        testingData_ = squeeze(DATA(testingCells(cellIndex), :, :))'; % nFrames x nTrials
        X0 = [X0; testingData_]; %reshaped data
        
        %Testing Labels
        if ismember(testingCells(cellIndex), input.ptcList)
            Yfit_actual(((nFrames*(cellIndex-1)) + 1): ((nFrames*(cellIndex-1)) +nFrames), 1) = 1;
        elseif ismember(testingCells(cellIndex), input.ocList)
            Yfit_actual(((nFrames*(cellIndex-1)) + 1): ((nFrames*(cellIndex-1)) +nFrames), 1) = 0;
        end
    end
    
else %Use all the data points
    for cellIndex = 1:length(nCells)
        %disp(cellIndex)
        
        trainingData_ = squeeze(DATA(cellIndex, :, :))'; % nFrames x nTrials
        X_all = [X_all; trainingData_]; %reshaped data
        %size(Xprime)
        
        %Training Labels
        if strcmpi(input.labelShuffle, 'on')
            if ismember(randomCells(cellIndex), input.ptcList)
                Y_all(((nFrames*(cellIndex-1)) + 1): ((nFrames*(cellIndex-1)) +nFrames), 1) = 1;
            elseif ismember(randomCells(cellIndex), input.ocList)
                Y_all(((nFrames*(cellIndex-1)) + 1): ((nFrames*(cellIndex-1)) +nFrames), 1) = 0;
            end
        elseif strcmpi(input.labelShuffle, 'off')
            if ismember(cellIndex, input.ptcList)
                Y_all(((nFrames*(cellIndex-1)) + 1): ((nFrames*(cellIndex-1)) +nFrames), 1) = 1;
            elseif ismember(cellIndex, input.ocList)
                Y_all(((nFrames*(cellIndex-1)) + 1): ((nFrames*(cellIndex-1)) +nFrames), 1) = 0;
            end
        else
            error('Unable to determine if label shuffle control is on/off')
        end
    end
    
end
