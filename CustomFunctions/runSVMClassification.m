function [svmOutput] = runSVMClassification(DATA, svmInput)

nCells = size(DATA, 1);
nTrials = size(DATA, 2);
nFrames = size(DATA, 3);

%Gaussian Smoothing
if svmInput.gaussianSmoothing
    [smoothedData, ~] = doGaussianSmoothing(DATA, svmInput.nSamples);
    %[smoothedDATA, gaussianKernel] = doGaussianSmoothing2D(DATA_2D, nSamples);
end

[X, X0, Y, Yfit_actual, trainingTrials, testingTrials] = createDataMatrix4Classification(DATA, svmInput); %Same function

mustBeNonnegative(X)
mustBeNonnegative(X0)
mustBeNonnegative(Y)

%Create Tall Array
T = tall(X);
%class(T)

%Standardize the data
Z = zscore(T);

%Generate the model
t = templateSVM('SaveSupportVectors',true);
svmOutput.Mdl = fitcecoc(Z, Y, ...
    'Learners', t, ...
    'ClassNames', Y, ...
    'Coding','onevsone');
%svmOutput.Mdl = fitcecoc(T, Y, 'ClassNames', Y); %Not standardized data

%Test model
svmOutput.Yfit = predict(svmOutput.Mdl, X0);

svmOutput.trainingTrials = trainingTrials;
svmOutput.testingTrials = testingTrials;
svmOutput.Yfit_actual = Yfit_actual;
svmOutput.YfitDiff = svmOutput.Yfit - Yfit_actual;

%Reshape Yfit and Yfit_actual to a 2D matrix - trials vs frames
svmOutput.Yfit_2D = reshape(svmOutput.Yfit, [length(testingTrials), nFrames]);
svmOutput.Yfit_actual_2D = reshape(svmOutput.Yfit_actual, [length(testingTrials), nFrames]);
svmOutput.YfitDiff_2D = reshape(svmOutput.YfitDiff, [length(testingTrials), nFrames]);

end