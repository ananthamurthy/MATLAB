function [X, X0, Y] = createDataMatrix4Bayes(DATA, input)

nCells = size(DATA, 1);
nTrials = size(DATA, 2);
nFrames = size(DATA, 3); %per trial
nTotalFrames = nTrials*nFrames; %total frames in dataset.

if strcmpi(input.whichTrials, 'first')
    trainingTrials = 1:floor(nTrials/2);
    testingTrials = floor(nTrials/2)+1:nTrials;
    
elseif strcmpi(input.whichTrials, 'alternate')
    trainingTrials = 1:2:nTrials;
    testingTrials = 2:2:nTrials;
    
elseif strcmpi(input.whichTrials, 'random')
    allTrials = 1:nTrials;
    trainingTrials = sort(randperm(nTrials, floor(nTrials/2)));
    testingTrials = allTrials;
    testingTrials(trainingTrials) = [];
    clear allTrials

elseif strcmpi(input.whichTrials, 'all')
    trainingTrials = 1:nTrials;
    testingTrials = 1:nTrials;

else
    error('Unable to select test trials')
end

Xprime = [];
%Y = zeros(nTotalFrames, 1);
count = 0;
for frame = 1:size(DATA, 3)
    %disp(frame)
    
    %Training Trials
    trainingData_ = squeeze(DATA(:, trainingTrials, frame));
    if input.shuffle == 1
        trialOrder = randperm(size(trainingData_,2));
        trainingData = trainingData_(:, trialOrder);
        Xprime = [Xprime; trainingData]; %reshaped data
        %clear trainingData
    else
        Xprime = [Xprime; trainingData_]; %reshaped data
        %clear trainingData_
    end
    
    %Testing Trials
    testingData_ = squeeze(DATA(:, testingTrials, frame));
    if input.shuffle == 1
        trialOrder = randperm(size(testingData_,2));
        testingData = testingData_(:, trialOrder);
        X0prime = [X0prime; testingData];
        %clear testingData
    else
        X0prime = [X0prime; testingData_];
        %clear testingData_
    end
    
    %Labels
    Y(((nTrials*(count)) + 1): ((nTrials*(count)) + nTrials)) = frame;
    count = count +1;
end
%Rows are now the calcium activity and columns are cells
X = Xprime'; %Training
X0 = X0prime'; %Testing

end

