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
close all

plotRefQ = 1;
plotAnalysedQs = 1;
plotDatasetCheck = 0;
%updateMethodF = 0;

useNames = 1;

addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions'))

%% Load Generated Synthetic Data
if plotRefQ
    gDate = 20201112; %generation date
    gRun = 1; %generation run number
    nDatasets = 208;
    synthDataFilePath = sprintf('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/synthDATA_%i_gRun%i_batch_%i.mat', gDate, gRun, nDatasets);
    load(synthDataFilePath)
end

%% Load Analysed Data
if plotAnalysedQs
    cDate = 20201209; %consolidation date
    cRun = 1; %consolidation run number
    analysisFilePath = sprintf('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_%i_cRun%i_cData.mat', cDate, cRun);
    load(analysisFilePath)
else
    cData = [];
end

% if updateMethodF
%     gDate = 20201107; %generation date
%     gRun = 1; %generation run number
%     nDatasets = 208;
%     analysedDataFilePath = strcat('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/', ...
%         'M26_20180514_synthDataAnalysis_20201106_gRun1_methodF_batch_1-208.mat');
%     load(analysedDataFilePath)
%     cData.methodF.mFInput = mFInput;
%     cData.methodF.mFOutput_batch = mFOutput_batch;
% end
%%
expCase_seq = 0;
X_seq_PC = zeros(9, 7); % (nMethods, nExpCases)
expCase_rnd = 0;
X_rnd_PC = zeros(9, 7); % (nMethods, nExpCases)
%% Q vs HTR

%dIndices = 1:1:10;
dIndices = 21:1:30;
expCase_seq = expCase_seq + 1
normalize = 1;
nParams = 10;
if plotAnalysedQs
    nMethods = 9;
else
    nMethods = 1;
end
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titleMain = 'Sequential Activity';
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = 'Fixed Hit Trial Ratio (%)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 2, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
sensitivity = plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams, useNames);
if plotDatasetCheck
    mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
end
allSeqExpNames{expCase_seq} = labels.xtitle(~isspace(labels.xtitle));
X_seq_PC(:, expCase_seq) = sensitivity';

dIndices = 31:1:40;
expCase_seq = expCase_seq + 1
normalize = 1;
nParams = 10;
if plotAnalysedQs
    nMethods = 9;
else
    nMethods = 1;
end
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titleMain = 'Sequential Activity';
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = 'Randomized Hit Trial Ratio (%)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
sensitivity = plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams, useNames);
if plotDatasetCheck
    mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
end
allSeqExpNames{expCase_seq} = labels.xtitle(~isspace(labels.xtitle));
X_seq_PC(:, expCase_seq) = sensitivity';

dIndices = 125:1:134;
expCase_rnd = expCase_rnd + 1
normalize = 1;
nParams = 10;
if plotAnalysedQs
    nMethods = 9;
else
    nMethods = 1;
end
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titleMain = 'Random Activity';
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = 'Fixed Hit Trial Ratio (%)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
sensitivity = plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams, useNames);
if plotDatasetCheck
    mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
end
allRndExpNames{expCase_rnd} = labels.xtitle(~isspace(labels.xtitle));
X_rnd_PC(:, expCase_seq) = sensitivity';

dIndices = 135:1:144;
expCase_rnd = expCase_rnd + 1
normalize = 1;
nParams = 10;
if plotAnalysedQs
    nMethods = 9;
else
    nMethods = 1;
end
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titleMain = 'Random Activity';
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = 'Randomized Hit Trial Ratio (%)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
sensitivity = plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams, useNames);
if plotDatasetCheck
    mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
end
allRndExpNames{expCase_rnd} = labels.xtitle(~isspace(labels.xtitle));
X_rnd_PC(:, expCase_seq) = sensitivity';
%% Q vs Noise

dIndices = 95:1:104;
expCase_seq = expCase_seq + 1
normalize = 1;
nParams = 10;
if plotAnalysedQs
    nMethods = 9;
else
    nMethods = 1;
end
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titleMain = 'Sequential Activity';
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = 'Gaussian Noise (%)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
sensitivity = plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams, useNames);
if plotDatasetCheck
    mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
end
allSeqExpNames{expCase_seq} = labels.xtitle(~isspace(labels.xtitle));
X_seq_PC(:, expCase_seq) = sensitivity';

dIndices = 199:1:208;
expCase_rnd = expCase_rnd + 1
normalize = 1;
nParams = 10;
if plotAnalysedQs
    nMethods = 9;
else
    nMethods = 1;
end
labels.xtickscell = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
labels.titleMain = 'Random Activity';
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = 'Gaussian Noise (%)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
sensitivity = plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams, useNames);
if plotDatasetCheck
    mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
end
allRndExpNames{expCase_rnd} = labels.xtitle(~isspace(labels.xtitle));
X_rnd_PC(:, expCase_seq) = sensitivity';
%% Q vs Event Widths

%dIndices = 1:1:7;
dIndices = 61:1:67;
expCase_seq = expCase_seq + 1
normalize = 1;
nParams = 7;
if plotAnalysedQs
    nMethods = 9;
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
sensitivity = plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams, useNames);
if plotDatasetCheck
    mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
end
allSeqExpNames{expCase_seq} = labels.xtitle(~isspace(labels.xtitle));
X_seq_PC(:, expCase_seq) = sensitivity';

%dIndices = 8:1:14;
dIndices = 68:1:74;
expCase_seq = expCase_seq + 1
normalize = 1;
nParams = 7;
if plotAnalysedQs
    nMethods = 9;
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
sensitivity = plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams, useNames);
if plotDatasetCheck
    mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
end
allSeqExpNames{expCase_seq} = labels.xtitle(~isspace(labels.xtitle));
X_seq_PC(:, expCase_seq) = sensitivity';

dIndices = 165:1:171;
expCase_rnd = expCase_rnd + 1
normalize = 1;
nParams = 7;
if plotAnalysedQs
    nMethods = 9;
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
sensitivity = plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams, useNames);
if plotDatasetCheck
    mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
end
allRndExpNames{expCase_rnd} = labels.xtitle(~isspace(labels.xtitle));
X_rnd_PC(:, expCase_seq) = sensitivity';

dIndices = 172:1:178;
expCase_rnd = expCase_rnd + 1
normalize = 1;
nParams = 7;
if plotAnalysedQs
    nMethods = 9;
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
sensitivity = plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams, useNames);
if plotDatasetCheck
    mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
end
allRndExpNames{expCase_rnd} = labels.xtitle(~isspace(labels.xtitle));
X_rnd_PC(:, expCase_seq) = sensitivity';

%% Q vs Imprecision

dIndices = 75:1:84;
expCase_seq = expCase_seq + 1
normalize = 1;
nParams = 10;
if plotAnalysedQs
    nMethods = 9;
else
    nMethods = 1;
end
labels.xtickscell = {'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'};
labels.titleMain = 'Sequential Activity';
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = 'Uniform Imprecision FWHM (frames)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
sensitivity = plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams, useNames);
if plotDatasetCheck
    mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
end
allSeqExpNames{expCase_seq} = labels.xtitle(~isspace(labels.xtitle));
X_seq_PC(:, expCase_seq) = sensitivity';

dIndices = 85:1:94;
expCase_seq = expCase_seq + 1
normalize = 1;
nParams = 10;
if plotAnalysedQs
    nMethods = 9;
else
    nMethods = 1;
end
labels.xtickscell = {'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'};
labels.titleMain = 'Sequential Activity';
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = 'Normal Imprecision FWHM (frames)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
sensitivity = plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams, useNames);
if plotDatasetCheck
    mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
end
allSeqExpNames{expCase_seq} = labels.xtitle(~isspace(labels.xtitle));
X_seq_PC(:, expCase_seq) = sensitivity';

dIndices = 179:1:188;
expCase_rnd = expCase_rnd + 1
normalize = 1;
nParams = 10;
if plotAnalysedQs
    nMethods = 9;
else
    nMethods = 1;
end
labels.xtickscell = {'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'};
labels.titleMain = 'Random Activity';
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = 'Uniform Imprecision FWHM (frames)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
sensitivity = plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams, useNames);
if plotDatasetCheck
    mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
end
allRndExpNames{expCase_rnd} = labels.xtitle(~isspace(labels.xtitle));
X_rnd_PC(:, expCase_seq) = sensitivity';

dIndices = 189:1:198;
expCase_rnd = expCase_rnd + 1
normalize = 1;
nParams = 10;
if plotAnalysedQs
    nMethods = 9;
else
    nMethods = 1;
end
labels.xtickscell = {'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'};
labels.titleMain = 'Random Activity';
labels.titlePTC = 'Putative Time Cells';
labels.titleOC = 'Other Time Cells';
labels.xtitle = 'Normal Imprecision FWHM (frames)';
labels.ytitle = 'Normalized Quality';
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData)
sensitivity = plotParamSensitivityLinePlot2(dIndices, normalize, labels, figureDetails, sdo_batch, cData, nMethods, nParams, useNames);
if plotDatasetCheck
    mainDatasetCheck3(dIndices, sdo_batch, figureDetails)
end
allRndExpNames{expCase_rnd} = labels.xtitle(~isspace(labels.xtitle));
X_rnd_PC(:, expCase_seq) = sensitivity';

%% Full Summary
%Summary - Sequence Experiments - Putative Time Cells
fig5 = figure(5);
set(fig5,'Position',[200, 200, 1600, 900])
subplot(1, 2, 1)
imagesc(squeeze(X_seq_PC/max(max(X_seq_PC))));
colormap('jet')
title('Sequential Activity')
%xlabel('Experiment Cases')
xticks([1 2 3 4 5 6 7])
xticklabels(allSeqExpNames)
xtickangle(45)
ylabel('Methods')
yticks([1 2 3 4 5 6 7 8 9])
yticklabels({'Ref', 'R2B', 'TI', 'C1', 'C2', 'PCA', 'SVM', 'DerQ1', 'DerQ2'})
z = colorbar;
ylabel(z,'Normalized Sensitivity (A.U.)', ...
    'FontSize', figureDetails.fontSize+3, ...
    'FontWeight', 'bold')
caxis([0 1])
set(gca, 'FontSize', figureDetails.fontSize+7)
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/sensitivityAnalyses-Seq', ...
%     '-dpng')

%Summary - Sequence Experiments - Putative Time Cells
%fig6 = figure(6);
%set(fig6,'Position',[300, 300, 800, 900])
subplot(1, 2, 2)
imagesc(squeeze(X_rnd_PC/max(max(X_seq_PC))));
colormap('jet')
title('Random Activity')
%xlabel('Experiment Cases')
xticks([1 2 3 4 5 6 7])
xticklabels(allRndExpNames)
xtickangle(45)
ylabel('Methods')
yticks([1 2 3 4 5 6 7 8 9])
yticklabels({'Ref', 'R2B', 'TI', 'C1', 'C2', 'PCA', 'SVM', 'DerQ1', 'DerQ2'})
z = colorbar;
ylabel(z,'Normalized Sensitivity (A.U.)', ...
    'FontSize', figureDetails.fontSize+3, ...
    'FontWeight', 'bold')
caxis([0 1])
set(gca, 'FontSize', figureDetails.fontSize+7)
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/sensitivityAnalyses-Seq', ...
%     '-dpng')
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/allSensitivityAnalyses', ...
    '-dpng')