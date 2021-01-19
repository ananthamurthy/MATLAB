function [derivedQOutput] = runDerivedQAnalysis(DATA, derivedQInput)

nIterations = derivedQInput.nIterations;
threshold = derivedQInput.threshold;

nCells = size(DATA, 1);
%nTrials = size(DATA, 2);
%nFrames = size(DATA, 3);

timeCells1 = nan(nCells, 1);
timeCells2 = nan(nCells, 1);

[Q1, Q2] = derivedQAnalysis(DATA, derivedQInput);

randQ1 = nan(nCells, nIterations);
randQ2 = nan(nCells, nIterations);

%Generate circularly shifted randomized data
for i = 1:nIterations
    randDATA = generateRandData(DATA);
    [randQ1(:, i), randQ2(:, i)] = derivedQAnalysis(randDATA);
end

%Classify Time Cells
for cell = 1:nCells
    score1 = (sum(Q1(cell)>randQ1(cell, :))/nIterations)*100;
    score2 = (sum(Q2(cell)>randQ2(cell, :))/nIterations)*100;
    
    if score1 > threshold
        timeCells1(cell) = 1;
    else
        timeCells1(cell) = 0;
    end
    
    if score2 > threshold
        timeCells2(cell) = 1;
    else
        timeCells2(cell) = 0;
    end
end

derivedQOutput.Q1 = Q1;
derivedQOutput.Q2 = Q2;
derivedQOutput.T = peakTimeBin;
derivedQOutput.timeCells1 = timeCells1;
derivedQOutput.timeCells2 = timeCells2;
end