function [stcaOutput] = runSimpleTCAnalysis(DATA, simpleInput)

nIterations = simpleInput.nIterations;
threshold1 = simpleInput.threshold;

%Preallocation
timeCells1 = nan(nCells, 1);
timeCells2 = nan(nCells, 2);
%timeCells3 = nan(nCells, 1);
%timeCells4 = nan(nCells, 2);
randQ1 = nan(nCells, nIterations);
randQ2 = nan(nCells, nIterations);

[peakTimeBin, Q1, Q2] = simpleAnalysis(DATA, simpleInput);

%Generate circularly shifted randomized data
for i = 1:nIterations
    randDATA = generateRandData(DATA);
    [~, ~, randQ1(:, i), randQ2(:, i)] = simpleAnalysis(randDATA, simpleInput);
end

%Classify Time Cells
%Using comparisons to randomized data
for cell = 1:nCells
    score1 = (sum(Q1(cell)>randQ1(cell, :))/nIterations)*100;
    score2 = (sum(Q2(cell)>randQ2(cell, :))/nIterations)*100;
    
    if score1 > threshold1
        timeCells1(cell) = 1;
    else
        timeCells1(cell) = 0;
    end
    
    if score2 > threshold1
        timeCells2(cell) = 1;
    else
        timeCells2(cell) = 0;
    end
end

%Using Otsu's method of finding threshold
thresholdOtsu1 = graythresh(Q1); %Otsu's method
thresholdOtsu2 = graythresh(Q2); %Otsu's method
timeCells3 = Q1 > thresholdOtsu1;
timeCells4 = Q2 > thresholdOtsu2;

%stcaOutput.ETH = ETH;
stcaOutput.Q1 = Q1;
stcaOutput.Q2 = Q2;
stcaOutput.T = peakTimeBin;
stcaOutput.timeCells1 = timeCells1;
stcaOutput.timeCells2 = timeCells2;
stcaOutput.timeCells3 = timeCells3;
stcaOutput.timeCells4 = timeCells4;

end