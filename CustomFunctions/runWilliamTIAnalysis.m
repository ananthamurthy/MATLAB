function [williamOutput] = runWilliamTIAnalysis(DATA, williamInput)
nCells = size(DATA, 1);
%nTrials = size(DATA, 2);
nFrames = size(DATA, 3);

%Preallocations
MI = nan(nCells,1);
Isec = nan(nCells,1);
Ispk = nan(nCells,1);
Itime = nan(nCells,size(DATA,3),1);
timeCells = nan(nCells, 1);
time = nan(nCells, 1);

%Quality (Q) or Temporal Information
for cell = 1:size(DATA,1)
    [MI(cell), Isec(cell), Ispk(cell), Itime(cell, :)] = tempInfoOneNeuron(squeeze(DATA(cell,:,:)));
end

[X, X0, Y, Yfit_actual, trainingTrials, testingTrials] = createDataMatrix4Bayes(DATA, williamInput);

mustBeNonnegative(X)
mustBeNonnegative(X0)
mustBeNonnegative(Y)

%Generate the model
%Mdl = fitcnb(X, Y, 'distributionnames','mn', 'ClassNames', Y);
% williamOutput.Mdl = fitcnb(X, Y, ...
%     'distributionnames', williamInput.distribution4Bayes, ...
%     'ClassNames', Y);
Mdl = fitcnb(X, Y, ...
    'distributionnames', williamInput.distribution4Bayes, ...
    'ClassNames', Y);

%Test model
williamOutput.Yfit = predict(Mdl, X0);

%williamOutput.Isec = Isec;
williamOutput.Q = Ispk;
williamOutput.trainingTrials = trainingTrials;
williamOutput.testingTrials = testingTrials;
williamOutput.Yfit_actual = Yfit_actual;
williamOutput.YfitDiff = williamOutput.Yfit - Yfit_actual;

%Reshape Yfit and Yfit_actual to a 2D matrix - trials vs frames
williamOutput.Yfit_2D = reshape(williamOutput.Yfit, [length(testingTrials), nFrames]);
williamOutput.Yfit_actual_2D = reshape(williamOutput.Yfit_actual, [length(testingTrials), nFrames]);
williamOutput.YfitDiff_2D = reshape(williamOutput.YfitDiff, [length(testingTrials), nFrames]);

williamOutput.timeCells = timeCells;
end