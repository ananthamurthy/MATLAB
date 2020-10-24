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
plotSyntheticData = 1;
plotAnalysedData = 1;

addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions'))

%% Load Generated Synthetic Data
if plotSyntheticData
    gDate = 20201008; %generation date
    gRun = 1; %generation run number
    nDatasets = 208;
    synthDataFilePath = sprintf('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/synthDATA_%i_gRun%i_batch_%i.mat', gDate, gRun, nDatasets);
    load(synthDataFilePath)
end

%% Load Analysed Data
if plotAnalysedData
    cDate = 20201010; %consolidation date
    cRun = 1; %consolidation run number
    analysisFilePath = sprintf('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_%i_cRun%i_cData.mat', cDate, cRun);
    load(analysisFilePath)
else
    cData = [];
end
%% Q vs HTR

% %dIndices = 1:1:10;
% dIndices = 21:1:30;
% normalize = 1;
% nParams = 10;
% if plotAnalysedData
%     nMethods = 7;
% else
%     nMethods = 1;
% end
% labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
% labels.titleMain = 'Sequential Activity';
% labels.titlePTC = 'Putative Time Cells';
% labels.titleOC = 'Other Time Cells';
% labels.xtitle = 'Fixed Hit Trial Ratio (%)';
% labels.ytitle = 'Normalized Quality';
% figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
% %plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
% plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams)
% mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
% 
% dIndices = 31:1:40;
% normalize = 1;
% nParams = 10;
% if plotAnalysedData
%     nMethods = 7;
% else
%     nMethods = 1;
% end
% labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
% labels.titleMain = 'Sequential Activity';
% labels.titlePTC = 'Putative Time Cells';
% labels.titleOC = 'Other Time Cells';
% labels.xtitle = 'Randomized Hit Trial Ratio (%)';
% labels.ytitle = 'Normalized Quality';
% figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
% %plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
% plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams)
% mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
% 
% dIndices = 125:1:134;
% normalize = 1;
% nParams = 10;
% if plotAnalysedData
%     nMethods = 7;
% else
%     nMethods = 1;
% end
% labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
% labels.titleMain = 'Random Activity';
% labels.titlePTC = 'Putative Time Cells';
% labels.titleOC = 'Other Time Cells';
% labels.xtitle = 'Fixed Hit Trial Ratio (%)';
% labels.ytitle = 'Normalized Quality';
% figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
% %plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
% plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams)
% mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
% 
% dIndices = 135:1:144;
% normalize = 1;
% nParams = 10;
% if plotAnalysedData
%     nMethods = 7;
% else
%     nMethods = 1;
% end
% labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
% labels.titleMain = 'Random Activity';
% labels.titlePTC = 'Putative Time Cells';
% labels.titleOC = 'Other Time Cells';
% labels.xtitle = 'Randomized Hit Trial Ratio (%)';
% labels.ytitle = 'Normalized Quality';
% figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
% %plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
% plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams)
% mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
% 
% %% Q vs Noise
% 
% dIndices = 95:1:104;
% normalize = 1;
% nParams = 10;
% if plotAnalysedData
%     nMethods = 7;
% else
%     nMethods = 1;
% end
% labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
% labels.titleMain = 'Sequential Activity';
% labels.titlePTC = 'Putative Time Cells';
% labels.titleOC = 'Other Time Cells';
% labels.xtitle = 'Gaussian Noise (%)';
% labels.ytitle = 'Normalized Quality';
% figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
% %plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
% plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams)
% mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
% 
% dIndices = 199:1:208;
% normalize = 1;
% nParams = 10;
% if plotAnalysedData
%     nMethods = 7;
% else
%     nMethods = 1;
% end
% labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
% labels.titleMain = 'Random Activity';
% labels.titlePTC = 'Putative Time Cells';
% labels.titleOC = 'Other Time Cells';
% labels.xtitle = 'Gaussian Noise (%)';
% labels.ytitle = 'Normalized Quality';
% figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
% %plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
% plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams)
% mainDatasetCheck3(dIndices, sdo_batch, figureDetails)

%% Q vs Event Widths

%dIndices = 1:1:7;
dIndices = 61:1:67;
normalize = 1;
nParams = 7;
if plotAnalysedData
    nMethods = 7;
else
    nMethods = 1;
end
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titleMain = 'Sequential Activity';
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = 'Fixed Event Width Percentile';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams)
mainDatasetCheck3(dIndices, sdo_batch, figureDetails)

%dIndices = 8:1:14;
dIndices = 68:1:74;
normalize = 1;
nParams = 7;
if plotAnalysedData
    nMethods = 7;
else
    nMethods = 1;
end
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titleMain = 'Sequential Activity';
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = sprintf('Variable Event Width Percentile (%i stddev)', sdcp(68).eventWidth{2});
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams)
mainDatasetCheck3(dIndices, sdo_batch, figureDetails)

dIndices = 165:1:171;
normalize = 1;
nParams = 7;
if plotAnalysedData
    nMethods = 7;
else
    nMethods = 1;
end
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titleMain = 'Random Activity';
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = 'Fixed Event Width Percentile';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams)
mainDatasetCheck3(dIndices, sdo_batch, figureDetails)

dIndices = 172:1:178;
normalize = 1;
nParams = 7;
if plotAnalysedData
    nMethods = 7;
else
    nMethods = 1;
end
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titleMain = 'Random Activity';
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = sprintf('Variable Event Width Percentile (%i stddev)', sdcp(172).eventWidth{2});
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams)
mainDatasetCheck3(dIndices, sdo_batch, figureDetails)

%% Q vs Imprecision

% dIndices = 75:1:84;
% normalize = 1;
% nParams = 10;
% if plotAnalysedData
%     nMethods = 7;
% else
%     nMethods = 1;
% end
% labels.xtickscell = {'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'};
% labels.titleMain = 'Sequential Activity';
% labels.titlePTC = 'Putative Time Cells';
% labels.titleOC = 'Other Time Cells';
% labels.xtitle = 'Uniform Imprecision FWHM (frames)';
% labels.ytitle = 'Normalized Quality';
% figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
% %plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
% plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams)
% mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
% 
% dIndices = 85:1:94;
% normalize = 1;
% nParams = 10;
% if plotAnalysedData
%     nMethods = 7;
% else
%     nMethods = 1;
% end
% labels.xtickscell = {'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'};
% labels.titleMain = 'Sequential Activity';
% labels.titlePTC = 'Putative Time Cells';
% labels.titleOC = 'Other Time Cells';
% labels.xtitle = 'Normal Imprecision FWHM (frames)';
% labels.ytitle = 'Normalized Quality';
% figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
% %plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
% plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams)
% mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
% 
% dIndices = 179:1:188;
% normalize = 1;
% nParams = 10;
% if plotAnalysedData
%     nMethods = 7;
% else
%     nMethods = 1;
% end
% labels.xtickscell = {'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'};
% labels.titleMain = 'Random Activity';
% labels.titlePTC = 'Putative Time Cells';
% labels.titleOC = 'Other Time Cells';
% labels.xtitle = 'Uniform Imprecision FWHM (frames)';
% labels.ytitle = 'Normalized Quality';
% figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
% %plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
% plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams)
% mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
% 
% dIndices = 189:1:198;
% normalize = 1;
% nParams = 10;
% if plotAnalysedData
%     nMethods = 7;
% else
%     nMethods = 1;
% end
% labels.xtickscell = {'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'};
% labels.titleMain = 'Random Activity';
% labels.titlePTC = 'Putative Time Cells';
% labels.titleOC = 'Other Time Cells';
% labels.xtitle = 'Normal Imprecision FWHM (frames)';
% labels.ytitle = 'Normalized Quality';
% figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
% %plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
% plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams)
% mainDatasetCheck3(dIndices, sdo_batch, figureDetails)