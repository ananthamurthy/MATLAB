function [svmOutput] = runSVMClassification(DATA, svmInput)

nCells = size(DATA, 1);
nTrials = size(DATA, 2);
nFrames = size(DATA, 3);

%Gaussian Smoothing
if svmInput.gaussianSmoothing
    [smoothedData, ~] = doGaussianSmoothing(DATA, svmInput.nSamples);
    %[smoothedDATA, gaussianKernel] = doGaussianSmoothing2D(DATA_2D, nSamples);
end

[X, X0, Y, Yfit_actual, trainingTrials, testingTrials] = createDataMatrix4Classification(DATA, svmInput);

mustBeNonnegative(X)
mustBeNonnegative(X0)
mustBeNonnegative(Y)

svmOutput.X = X;
svmOutput.X0 = X0;
svmOutput.Y = Y;

%Train Model
svmOutput.SVMModel = fitcsvm(X, Y, ...
    'KernelFunction', 'linear', ...
    'KernelScale', 'auto');

%Test model
[svmOutput.Yfit, score] = predict(svmOutput.SVMModel, X0);
svmOutput.YfitDiff = svmOutput.Yfit - Yfit_actual;
svmOutput.Q = score(:, 2); %Only looking at the "positive class" scores (to classify as "time cell")

%Reshape Yfit and Yfit_actual to a 2D matrix - trials vs frames
svmOutput.Yfit_2D = reshape(svmOutput.Yfit, [length(testingTrials), nCells]);
svmOutput.Yfit_actual_2D = reshape(Yfit_actual, [length(testingTrials), nCells]);
svmOutput.YfitDiff_2D = reshape(svmOutput.YfitDiff, [length(testingTrials), nCells]);

svmOutput.Q_2D = reshape(svmOutput.Q, [length(testingTrials), nCells]);

% Time Vector (T)
peakTimeBin = zeros(nCells, 1);
[ETH, ~, ~] = getETH(DATA, svmInput.delta, svmInput.skipFrames);
for cell = 1:nCells
    %disp(cell)
    [~, peakTimeBin(cell)] = max(squeeze(ETH(cell, :)));
end
svmOutput.T = peakTimeBin;

end