%{
Input arguments:
datasets
normalize
labels.xtickscell
labels.titlePTC
labels.titleOC
labels.xtitle
labels.ytitle
%}
addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions'))

% Generated Synthetic Data
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/synthDATA_batch_220.mat')

% Analysed Data
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200615_cRun4_cData.mat')
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200729_gRun2_methodE_batch_1-220.mat')

%% Q vs HTR

dIndices = 21:1:30;
normalize = 1;
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titlePTC = 'Putative Time Cells - Sequential Activity';
labels.titleOC = 'Other Time Cells - Sequential Activity';
labels.xtitle = 'Fixed Hit Trial Ratio (%)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)
plotParamSensitivityLinePlot(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)

dIndices = 31:1:40;
normalize = 1;
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titlePTC = 'Putative Time Cells - Sequential Activity';
labels.titleOC = 'Other Time Cells - Sequential Activity';
labels.xtitle = 'Randomized Hit Trial Ratio (%)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)
plotParamSensitivityLinePlot(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)

dIndices = 131:1:140;
normalize = 1;
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titlePTC = 'Putative Time Cells - Random Activity';
labels.titleOC = 'Other Time Cells - Random Activity';
labels.xtitle = 'Fixed Hit Trial Ratio (%)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)
plotParamSensitivityLinePlot(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)

dIndices = 141:1:150;
normalize = 1;
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titlePTC = 'Putative Time Cells - Random Activity';
labels.titleOC = 'Other Time Cells - Random Activity';
labels.xtitle = 'Randomized Hit Trial Ratio (%)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)
plotParamSensitivityLinePlot(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)

%% Q vs Noise

dIndices = 101:1:110;
normalize = 1;
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titlePTC = 'Putative Time Cells - Sequential Activity';
labels.titleOC = 'Other Time Cells - Sequential Activity';
labels.xtitle = 'Gaussian Noise (%)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)
plotParamSensitivityLinePlot(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)

dIndices = 211:1:220;
normalize = 1;
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titlePTC = 'Putative Time Cells - Random Activity';
labels.titleOC = 'Other Time Cells - Random Activity';
labels.xtitle = 'Gaussian Noise (%)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)
plotParamSensitivityLinePlot(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)

%% Q vs Event Widths

dIndices = 61:1:70;
normalize = 1;
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = 'Fixed Event Width Percentile';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)
plotParamSensitivityLinePlot(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)

dIndices = 71:1:80;
normalize = 1;
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = 'Variable Event Width Percentile (1 stddev)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)
plotParamSensitivityLinePlot(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)

%% Q vs Imprecision

dIndices = 81:1:90;
normalize = 1;
labels.xtickscell = {'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'};
labels.titlePTC = 'Putative Time Cells - Sequential Activity';
labels.titleOC = 'Other Time Cells - Sequential Activity';
labels.xtitle = 'Uniform Imprecision FWHM (frames)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)
plotParamSensitivityLinePlot(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)

dIndices = 91:1:100;
normalize = 1;
labels.xtickscell = {'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'};
labels.titlePTC = 'Putative Time Cells - Sequential Activity';
labels.titleOC = 'Other Time Cells - Sequential Activity';
labels.xtitle = 'Normal Imprecision FWHM (frames)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)
plotParamSensitivityLinePlot(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)

dIndices = 191:1:200;
normalize = 1;
labels.xtickscell = {'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'};
labels.titlePTC = 'Putative Time Cells - Random Activity';
labels.titleOC = 'Other Time Cells - Random Activity';
labels.xtitle = 'Uniform Imprecision FWHM (frames)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)
plotParamSensitivityLinePlot(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)

dIndices = 201:1:210;
normalize = 1;
labels.xtickscell = {'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'};
labels.titlePTC = 'Putative Time Cells - Random Activity';
labels.titleOC = 'Other Time Cells - Random Activity';
labels.xtitle = 'Normal Imprecision FWHM (frames)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)
plotParamSensitivityLinePlot(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)