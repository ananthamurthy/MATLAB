%% Figures for paper - Kambadur Ananthamurthy - Q vs Max Noise
close all

% Generated Synthetic Data
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/synthDATA_batch_220.mat')

% Analysed Data
%load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200729_cRun1_cData.mat')
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200729_gRun1_methodE_batch_1-220.mat')

figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)

%% METHOD E
% Sequential Timing
% Parameter Sensitivity - Q vs Max Percent Noise

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(101).ptcList
ocList = sdo_batch(101).ocList

fig13 = figure(13);
set(fig13,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = mEOutput_batch(101).Q(ptcList);
y2 = mEOutput_batch(102).Q(ptcList);
y3 = mEOutput_batch(103).Q(ptcList);
y4 = mEOutput_batch(104).Q(ptcList);
y5 = mEOutput_batch(105).Q(ptcList);
y6 = mEOutput_batch(106).Q(ptcList);
y7 = mEOutput_batch(107).Q(ptcList);
y8 = mEOutput_batch(108).Q(ptcList);
y9 = mEOutput_batch(109).Q(ptcList);
y10 = mEOutput_batch(110).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Sequential Timing')
xlabel('Gaussian Noise (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = mEOutput_batch(101).Q(ocList);
y2 = mEOutput_batch(102).Q(ocList);
y3 = mEOutput_batch(103).Q(ocList);
y4 = mEOutput_batch(104).Q(ocList);
y5 = mEOutput_batch(105).Q(ocList);
y6 = mEOutput_batch(106).Q(ocList);
y7 = mEOutput_batch(107).Q(ocList);
y8 = mEOutput_batch(108).Q(ocList);
y9 = mEOutput_batch(109).Q(ocList);
y10 = mEOutput_batch(110).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Sequential Timing')
xlabel('Gaussian Noise (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QEvsNoisePercent_seq', '-dpng')

% Random Timing
fig14 = figure(14);
set(fig14,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = mEOutput_batch(211).Q(ptcList);
y2 = mEOutput_batch(212).Q(ptcList);
y3 = mEOutput_batch(213).Q(ptcList);
y4 = mEOutput_batch(214).Q(ptcList);
y5 = mEOutput_batch(215).Q(ptcList);
y6 = mEOutput_batch(216).Q(ptcList);
y7 = mEOutput_batch(217).Q(ptcList);
y8 = mEOutput_batch(218).Q(ptcList);
y9 = mEOutput_batch(219).Q(ptcList);
y10 = mEOutput_batch(220).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Random Timing')
xlabel('Gaussian Noise (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = mEOutput_batch(211).Q(ocList);
y2 = mEOutput_batch(212).Q(ocList);
y3 = mEOutput_batch(213).Q(ocList);
y4 = mEOutput_batch(214).Q(ocList);
y5 = mEOutput_batch(215).Q(ocList);
y6 = mEOutput_batch(216).Q(ocList);
y7 = mEOutput_batch(217).Q(ocList);
y8 = mEOutput_batch(218).Q(ocList);
y9 = mEOutput_batch(219).Q(ocList);
y10 = mEOutput_batch(220).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Random Timing')
xlabel('Gaussian Noise (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QEvsNoisePercent_rnd', '-dpng')