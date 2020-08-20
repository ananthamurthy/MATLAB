%% Figures for paper - Kambadur Ananthamurthy - Q vs Event Widths
close all

% Generated Synthetic Data
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/synthDATA_batch_220.mat')

% Analysed Data
%load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200615_cRun4_cData.mat')
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200729_gRun2_methodE_batch_1-220.mat')

figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)

% ORIGINAL METHOD
% Sequential Timing
% Parameter Sensitivity - Q vs Max Percent Noise

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(61).ptcList;
ocList = sdo_batch(61).ocList;

fig1 = figure(1);
set(fig1,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = sdo_batch(61).Q(ptcList);
y2 = sdo_batch(62).Q(ptcList);
y3 = sdo_batch(63).Q(ptcList);
y4 = sdo_batch(64).Q(ptcList);
y5 = sdo_batch(65).Q(ptcList);
y6 = sdo_batch(66).Q(ptcList);
y7 = sdo_batch(67).Q(ptcList);
y8 = sdo_batch(68).Q(ptcList);
y9 = sdo_batch(69).Q(ptcList);
y10 = sdo_batch(70).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = sdo_batch(61).Q(ocList);
y2 = sdo_batch(62).Q(ocList);
y3 = sdo_batch(63).Q(ocList);
y4 = sdo_batch(64).Q(ocList);
y5 = sdo_batch(65).Q(ocList);
y6 = sdo_batch(66).Q(ocList);
y7 = sdo_batch(67).Q(ocList);
y8 = sdo_batch(68).Q(ocList);
y9 = sdo_batch(69).Q(ocList);
y10 = sdo_batch(70).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QvsEventWidth_fixed', '-dpng')

fig2 = figure(2);
set(fig2,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = sdo_batch(71).Q(ptcList);
y2 = sdo_batch(72).Q(ptcList);
y3 = sdo_batch(73).Q(ptcList);
y4 = sdo_batch(74).Q(ptcList);
y5 = sdo_batch(75).Q(ptcList);
y6 = sdo_batch(76).Q(ptcList);
y7 = sdo_batch(77).Q(ptcList);
y8 = sdo_batch(78).Q(ptcList);
y9 = sdo_batch(79).Q(ptcList);
y10 = sdo_batch(80).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - 1 stddev')
xlabel('Event Width Percentile')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = sdo_batch(71).Q(ocList);
y2 = sdo_batch(72).Q(ocList);
y3 = sdo_batch(73).Q(ocList);
y4 = sdo_batch(74).Q(ocList);
y5 = sdo_batch(75).Q(ocList);
y6 = sdo_batch(76).Q(ocList);
y7 = sdo_batch(77).Q(ocList);
y8 = sdo_batch(78).Q(ocList);
y9 = sdo_batch(79).Q(ocList);
y10 = sdo_batch(80).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - 1 stddev')
xlabel('Event Width Percentile')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QvsEventWidth_1stddev', '-dpng')

%% METHOD A
% Sequential Timing
% Parameter Sensitivity - Q vs Max Percent Noise

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(61).ptcList;
ocList = sdo_batch(61).ocList;

fig3 = figure(3);
set(fig3,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = cData.methodA.mAOutput_batch(61).Q(ptcList);
y2 = cData.methodA.mAOutput_batch(62).Q(ptcList);
y3 = cData.methodA.mAOutput_batch(63).Q(ptcList);
y4 = cData.methodA.mAOutput_batch(64).Q(ptcList);
y5 = cData.methodA.mAOutput_batch(65).Q(ptcList);
y6 = cData.methodA.mAOutput_batch(66).Q(ptcList);
y7 = cData.methodA.mAOutput_batch(67).Q(ptcList);
y8 = cData.methodA.mAOutput_batch(68).Q(ptcList);
y9 = cData.methodA.mAOutput_batch(69).Q(ptcList);
y10 = cData.methodA.mAOutput_batch(70).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('QA')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = cData.methodA.mAOutput_batch(61).Q(ocList);
y2 = cData.methodA.mAOutput_batch(62).Q(ocList);
y3 = cData.methodA.mAOutput_batch(63).Q(ocList);
y4 = cData.methodA.mAOutput_batch(64).Q(ocList);
y5 = cData.methodA.mAOutput_batch(65).Q(ocList);
y6 = cData.methodA.mAOutput_batch(66).Q(ocList);
y7 = cData.methodA.mAOutput_batch(67).Q(ocList);
y8 = cData.methodA.mAOutput_batch(68).Q(ocList);
y9 = cData.methodA.mAOutput_batch(69).Q(ocList);
y10 = cData.methodA.mAOutput_batch(70).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('QA')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QAvsEventWidth_fixed', '-dpng')

fig4 = figure(4);
set(fig4,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = cData.methodA.mAOutput_batch(71).Q(ptcList);
y2 = cData.methodA.mAOutput_batch(72).Q(ptcList);
y3 = cData.methodA.mAOutput_batch(73).Q(ptcList);
y4 = cData.methodA.mAOutput_batch(74).Q(ptcList);
y5 = cData.methodA.mAOutput_batch(75).Q(ptcList);
y6 = cData.methodA.mAOutput_batch(76).Q(ptcList);
y7 = cData.methodA.mAOutput_batch(77).Q(ptcList);
y8 = cData.methodA.mAOutput_batch(78).Q(ptcList);
y9 = cData.methodA.mAOutput_batch(79).Q(ptcList);
y10 = cData.methodA.mAOutput_batch(80).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - 1 stddev')
xlabel('Event Width Percentile')
ylabel('QA')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = cData.methodA.mAOutput_batch(71).Q(ocList);
y2 = cData.methodA.mAOutput_batch(72).Q(ocList);
y3 = cData.methodA.mAOutput_batch(73).Q(ocList);
y4 = cData.methodA.mAOutput_batch(74).Q(ocList);
y5 = cData.methodA.mAOutput_batch(75).Q(ocList);
y6 = cData.methodA.mAOutput_batch(76).Q(ocList);
y7 = cData.methodA.mAOutput_batch(77).Q(ocList);
y8 = cData.methodA.mAOutput_batch(78).Q(ocList);
y9 = cData.methodA.mAOutput_batch(79).Q(ocList);
y10 = cData.methodA.mAOutput_batch(80).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - 1 stddev')
xlabel('Event Width Percentile')
ylabel('QA')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QAvsEventWidth_1stddev', '-dpng')

%% METHOD B
% Sequential Timing
% Parameter Sensitivity - Q vs Max Percent Noise

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(61).ptcList;
ocList = sdo_batch(61).ocList;

fig5 = figure(5);
set(fig5,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = cData.methodB.holyData.mBOutput_batch(61).Q(ptcList);
y2 = cData.methodB.holyData.mBOutput_batch(62).Q(ptcList);
y3 = cData.methodB.holyData.mBOutput_batch(63).Q(ptcList);
y4 = cData.methodB.holyData.mBOutput_batch(64).Q(ptcList);
y5 = cData.methodB.holyData.mBOutput_batch(65).Q(ptcList);
y6 = cData.methodB.holyData.mBOutput_batch(66).Q(ptcList);
y7 = cData.methodB.holyData.mBOutput_batch(67).Q(ptcList);
y8 = cData.methodB.holyData.mBOutput_batch(68).Q(ptcList);
y9 = cData.methodB.holyData.mBOutput_batch(69).Q(ptcList);
y10 = cData.methodB.holyData.mBOutput_batch(70).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('QB')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = cData.methodB.holyData.mBOutput_batch(61).Q(ocList);
y2 = cData.methodB.holyData.mBOutput_batch(62).Q(ocList);
y3 = cData.methodB.holyData.mBOutput_batch(63).Q(ocList);
y4 = cData.methodB.holyData.mBOutput_batch(64).Q(ocList);
y5 = cData.methodB.holyData.mBOutput_batch(65).Q(ocList);
y6 = cData.methodB.holyData.mBOutput_batch(66).Q(ocList);
y7 = cData.methodB.holyData.mBOutput_batch(67).Q(ocList);
y8 = cData.methodB.holyData.mBOutput_batch(68).Q(ocList);
y9 = cData.methodB.holyData.mBOutput_batch(69).Q(ocList);
y10 = cData.methodB.holyData.mBOutput_batch(70).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('QB')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QBvsEventWidth_fixed', '-dpng')

fig6 = figure(6);
set(fig6,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = cData.methodB.holyData.mBOutput_batch(71).Q(ptcList);
y2 = cData.methodB.holyData.mBOutput_batch(72).Q(ptcList);
y3 = cData.methodB.holyData.mBOutput_batch(73).Q(ptcList);
y4 = cData.methodB.holyData.mBOutput_batch(74).Q(ptcList);
y5 = cData.methodB.holyData.mBOutput_batch(75).Q(ptcList);
y6 = cData.methodB.holyData.mBOutput_batch(76).Q(ptcList);
y7 = cData.methodB.holyData.mBOutput_batch(77).Q(ptcList);
y8 = cData.methodB.holyData.mBOutput_batch(78).Q(ptcList);
y9 = cData.methodB.holyData.mBOutput_batch(79).Q(ptcList);
y10 = cData.methodB.holyData.mBOutput_batch(80).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - 1 stddev')
xlabel('Event Width Percentile')
ylabel('QB')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = cData.methodB.holyData.mBOutput_batch(71).Q(ocList);
y2 = cData.methodB.holyData.mBOutput_batch(72).Q(ocList);
y3 = cData.methodB.holyData.mBOutput_batch(73).Q(ocList);
y4 = cData.methodB.holyData.mBOutput_batch(74).Q(ocList);
y5 = cData.methodB.holyData.mBOutput_batch(75).Q(ocList);
y6 = cData.methodB.holyData.mBOutput_batch(76).Q(ocList);
y7 = cData.methodB.holyData.mBOutput_batch(77).Q(ocList);
y8 = cData.methodB.holyData.mBOutput_batch(78).Q(ocList);
y9 = cData.methodB.holyData.mBOutput_batch(79).Q(ocList);
y10 = cData.methodB.holyData.mBOutput_batch(80).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - 1 stddev')
xlabel('Event Width Percentile')
ylabel('QB')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QBvsEventWidth_1stddev', '-dpng')

%% METHOD C
%C1
% Sequential Timing
% Parameter Sensitivity - Q vs Max Percent Noise

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(61).ptcList;
ocList = sdo_batch(61).ocList;

fig7 = figure(7);
set(fig7,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = cData.methodC.mCOutput_batch(61).Q1(ptcList);
y2 = cData.methodC.mCOutput_batch(62).Q1(ptcList);
y3 = cData.methodC.mCOutput_batch(63).Q1(ptcList);
y4 = cData.methodC.mCOutput_batch(64).Q1(ptcList);
y5 = cData.methodC.mCOutput_batch(65).Q1(ptcList);
y6 = cData.methodC.mCOutput_batch(66).Q1(ptcList);
y7 = cData.methodC.mCOutput_batch(67).Q1(ptcList);
y8 = cData.methodC.mCOutput_batch(68).Q1(ptcList);
y9 = cData.methodC.mCOutput_batch(69).Q1(ptcList);
y10 = cData.methodC.mCOutput_batch(70).Q1(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('QC1')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = cData.methodC.mCOutput_batch(61).Q1(ocList);
y2 = cData.methodC.mCOutput_batch(62).Q1(ocList);
y3 = cData.methodC.mCOutput_batch(63).Q1(ocList);
y4 = cData.methodC.mCOutput_batch(64).Q1(ocList);
y5 = cData.methodC.mCOutput_batch(65).Q1(ocList);
y6 = cData.methodC.mCOutput_batch(66).Q1(ocList);
y7 = cData.methodC.mCOutput_batch(67).Q1(ocList);
y8 = cData.methodC.mCOutput_batch(68).Q1(ocList);
y9 = cData.methodC.mCOutput_batch(69).Q1(ocList);
y10 = cData.methodC.mCOutput_batch(70).Q1(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('QC1')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC1vsEventWidth_fixed', '-dpng')

fig8 = figure(8);
set(fig8,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = cData.methodC.mCOutput_batch(71).Q1(ptcList);
y2 = cData.methodC.mCOutput_batch(72).Q1(ptcList);
y3 = cData.methodC.mCOutput_batch(73).Q1(ptcList);
y4 = cData.methodC.mCOutput_batch(74).Q1(ptcList);
y5 = cData.methodC.mCOutput_batch(75).Q1(ptcList);
y6 = cData.methodC.mCOutput_batch(76).Q1(ptcList);
y7 = cData.methodC.mCOutput_batch(77).Q1(ptcList);
y8 = cData.methodC.mCOutput_batch(78).Q1(ptcList);
y9 = cData.methodC.mCOutput_batch(79).Q1(ptcList);
y10 = cData.methodC.mCOutput_batch(80).Q1(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - 1 stddev')
xlabel('Event Width Percentile')
ylabel('QC1')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = cData.methodC.mCOutput_batch(71).Q1(ocList);
y2 = cData.methodC.mCOutput_batch(72).Q1(ocList);
y3 = cData.methodC.mCOutput_batch(73).Q1(ocList);
y4 = cData.methodC.mCOutput_batch(74).Q1(ocList);
y5 = cData.methodC.mCOutput_batch(75).Q1(ocList);
y6 = cData.methodC.mCOutput_batch(76).Q1(ocList);
y7 = cData.methodC.mCOutput_batch(77).Q1(ocList);
y8 = cData.methodC.mCOutput_batch(78).Q1(ocList);
y9 = cData.methodC.mCOutput_batch(79).Q1(ocList);
y10 = cData.methodC.mCOutput_batch(80).Q1(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - 1 stddev')
xlabel('Event Width Percentile')
ylabel('QC1')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC1vsEventWidth_1stddev', '-dpng')

%C2
% Sequential Timing
% Parameter Sensitivity - Q vs Max Percent Noise

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(61).ptcList;
ocList = sdo_batch(61).ocList;

fig9 = figure(9);
set(fig9,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = cData.methodC.mCOutput_batch(61).Q2(ptcList);
y2 = cData.methodC.mCOutput_batch(62).Q2(ptcList);
y3 = cData.methodC.mCOutput_batch(63).Q2(ptcList);
y4 = cData.methodC.mCOutput_batch(64).Q2(ptcList);
y5 = cData.methodC.mCOutput_batch(65).Q2(ptcList);
y6 = cData.methodC.mCOutput_batch(66).Q2(ptcList);
y7 = cData.methodC.mCOutput_batch(67).Q2(ptcList);
y8 = cData.methodC.mCOutput_batch(68).Q2(ptcList);
y9 = cData.methodC.mCOutput_batch(69).Q2(ptcList);
y10 = cData.methodC.mCOutput_batch(70).Q2(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('QC2')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = cData.methodC.mCOutput_batch(61).Q2(ocList);
y2 = cData.methodC.mCOutput_batch(62).Q2(ocList);
y3 = cData.methodC.mCOutput_batch(63).Q2(ocList);
y4 = cData.methodC.mCOutput_batch(64).Q2(ocList);
y5 = cData.methodC.mCOutput_batch(65).Q2(ocList);
y6 = cData.methodC.mCOutput_batch(66).Q2(ocList);
y7 = cData.methodC.mCOutput_batch(67).Q2(ocList);
y8 = cData.methodC.mCOutput_batch(68).Q2(ocList);
y9 = cData.methodC.mCOutput_batch(69).Q2(ocList);
y10 = cData.methodC.mCOutput_batch(70).Q2(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('QC2')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC2vsEventWidth_fixed', '-dpng')

fig10 = figure(10);
set(fig10,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = cData.methodC.mCOutput_batch(71).Q2(ptcList);
y2 = cData.methodC.mCOutput_batch(72).Q2(ptcList);
y3 = cData.methodC.mCOutput_batch(73).Q2(ptcList);
y4 = cData.methodC.mCOutput_batch(74).Q2(ptcList);
y5 = cData.methodC.mCOutput_batch(75).Q2(ptcList);
y6 = cData.methodC.mCOutput_batch(76).Q2(ptcList);
y7 = cData.methodC.mCOutput_batch(77).Q2(ptcList);
y8 = cData.methodC.mCOutput_batch(78).Q2(ptcList);
y9 = cData.methodC.mCOutput_batch(79).Q2(ptcList);
y10 = cData.methodC.mCOutput_batch(80).Q2(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - 1 stddev')
xlabel('Event Width Percentile')
ylabel('QC2')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = cData.methodC.mCOutput_batch(71).Q2(ocList);
y2 = cData.methodC.mCOutput_batch(72).Q2(ocList);
y3 = cData.methodC.mCOutput_batch(73).Q2(ocList);
y4 = cData.methodC.mCOutput_batch(74).Q2(ocList);
y5 = cData.methodC.mCOutput_batch(75).Q2(ocList);
y6 = cData.methodC.mCOutput_batch(76).Q2(ocList);
y7 = cData.methodC.mCOutput_batch(77).Q2(ocList);
y8 = cData.methodC.mCOutput_batch(78).Q2(ocList);
y9 = cData.methodC.mCOutput_batch(79).Q2(ocList);
y10 = cData.methodC.mCOutput_batch(80).Q2(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - 1 stddev')
xlabel('Event Width Percentile')
ylabel('QC2')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC2vsEventWidth_1stddev', '-dpng')

%% METHOD D
% Sequential Timing
% Parameter Sensitivity - Q vs Max Percent Noise

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(61).ptcList;
ocList = sdo_batch(61).ocList;

fig11 = figure(11);
set(fig11,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = cData.methodD.mDOutput_batch(61).Q(ptcList);
y2 = cData.methodD.mDOutput_batch(62).Q(ptcList);
y3 = cData.methodD.mDOutput_batch(63).Q(ptcList);
y4 = cData.methodD.mDOutput_batch(64).Q(ptcList);
y5 = cData.methodD.mDOutput_batch(65).Q(ptcList);
y6 = cData.methodD.mDOutput_batch(66).Q(ptcList);
y7 = cData.methodD.mDOutput_batch(67).Q(ptcList);
y8 = cData.methodD.mDOutput_batch(68).Q(ptcList);
y9 = cData.methodD.mDOutput_batch(69).Q(ptcList);
y10 = cData.methodD.mDOutput_batch(70).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('QD')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = cData.methodD.mDOutput_batch(61).Q(ocList);
y2 = cData.methodD.mDOutput_batch(62).Q(ocList);
y3 = cData.methodD.mDOutput_batch(63).Q(ocList);
y4 = cData.methodD.mDOutput_batch(64).Q(ocList);
y5 = cData.methodD.mDOutput_batch(65).Q(ocList);
y6 = cData.methodD.mDOutput_batch(66).Q(ocList);
y7 = cData.methodD.mDOutput_batch(67).Q(ocList);
y8 = cData.methodD.mDOutput_batch(68).Q(ocList);
y9 = cData.methodD.mDOutput_batch(69).Q(ocList);
y10 = cData.methodD.mDOutput_batch(70).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('QD')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QDvsEventWidth_fixed', '-dpng')

fig12 = figure(12);
set(fig12,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = cData.methodD.mDOutput_batch(71).Q(ptcList);
y2 = cData.methodD.mDOutput_batch(72).Q(ptcList);
y3 = cData.methodD.mDOutput_batch(73).Q(ptcList);
y4 = cData.methodD.mDOutput_batch(74).Q(ptcList);
y5 = cData.methodD.mDOutput_batch(75).Q(ptcList);
y6 = cData.methodD.mDOutput_batch(76).Q(ptcList);
y7 = cData.methodD.mDOutput_batch(77).Q(ptcList);
y8 = cData.methodD.mDOutput_batch(78).Q(ptcList);
y9 = cData.methodD.mDOutput_batch(79).Q(ptcList);
y10 = cData.methodD.mDOutput_batch(80).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - 1 stddev')
xlabel('Event Width Percentile')
ylabel('QD')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = cData.methodD.mDOutput_batch(71).Q(ocList);
y2 = cData.methodD.mDOutput_batch(72).Q(ocList);
y3 = cData.methodD.mDOutput_batch(73).Q(ocList);
y4 = cData.methodD.mDOutput_batch(74).Q(ocList);
y5 = cData.methodD.mDOutput_batch(75).Q(ocList);
y6 = cData.methodD.mDOutput_batch(76).Q(ocList);
y7 = cData.methodD.mDOutput_batch(77).Q(ocList);
y8 = cData.methodD.mDOutput_batch(78).Q(ocList);
y9 = cData.methodD.mDOutput_batch(79).Q(ocList);
y10 = cData.methodD.mDOutput_batch(80).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - 1 stddev')
xlabel('Event Width Percentile')
ylabel('QD')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QDvsEventWidth_1stddev', '-dpng')

%% METHOD E
% Sequential Timing
% Parameter Sensitivity - Q vs Max Percent Noise

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(61).ptcList;
ocList = sdo_batch(61).ocList;

fig13 = figure(13);
set(fig13,'Position',[300,300,1000,500])
subplot(1,2,1)
y1(1, 1:ptcList) = mEOutput_batch(61).Q(ptcList)';
y2(1, 1:ptcList) = mEOutput_batch(62).Q(ptcList)';
y3(1, 1:ptcList) = mEOutput_batch(63).Q(ptcList)';
y4(1, 1:ptcList) = mEOutput_batch(64).Q(ptcList)';
y5(1, 1:ptcList) = mEOutput_batch(65).Q(ptcList)';
y6(1, 1:ptcList) = mEOutput_batch(66).Q(ptcList)';
y7(1, 1:ptcList) = mEOutput_batch(67).Q(ptcList)';
y8(1, 1:ptcList) = mEOutput_batch(68).Q(ptcList)';
y9(1, 1:ptcList) = mEOutput_batch(69).Q(ptcList)';
y10(1, 1:ptcList) = mEOutput_batch(70).Q(ptcList)';

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
z1 = mEOutput_batch(61).Q(ocList)';
z2 = mEOutput_batch(62).Q(ocList)';
z3 = mEOutput_batch(63).Q(ocList)';
z4 = mEOutput_batch(64).Q(ocList)';
z5 = mEOutput_batch(65).Q(ocList)';
z6 = mEOutput_batch(66).Q(ocList)';
z7 = mEOutput_batch(67).Q(ocList)';
z8 = mEOutput_batch(68).Q(ocList)';
z9 = mEOutput_batch(69).Q(ocList)';
z10 = mEOutput_batch(70).Q(ocList)';

boxplot([z1, z2, z3, z4, z5, z6, z7, z8, z9, z10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QEvsEventWidth_fixed', '-dpng')

fig14 = figure(14);
set(fig14,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = mEOutput_batch(71).Q(ptcList)';
y2 = mEOutput_batch(72).Q(ptcList)';
y3 = mEOutput_batch(73).Q(ptcList)';
y4 = mEOutput_batch(74).Q(ptcList)';
y5 = mEOutput_batch(75).Q(ptcList)';
y6 = mEOutput_batch(76).Q(ptcList)';
y7 = mEOutput_batch(77).Q(ptcList)';
y8 = mEOutput_batch(78).Q(ptcList)';
y9 = mEOutput_batch(79).Q(ptcList)';
y10 = mEOutput_batch(80).Q(ptcList)';

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - 1 stddev')
xlabel('Event Width Percentile')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
z1 = mEOutput_batch(71).Q(ocList)';
z2 = mEOutput_batch(72).Q(ocList)';
z3 = mEOutput_batch(73).Q(ocList)';
z4 = mEOutput_batch(74).Q(ocList)';
z5 = mEOutput_batch(75).Q(ocList)';
z6 = mEOutput_batch(76).Q(ocList)';
z7 = mEOutput_batch(77).Q(ocList)';
z8 = mEOutput_batch(78).Q(ocList)';
z9 = mEOutput_batch(79).Q(ocList)';
z10 = mEOutput_batch(80).Q(ocList)';

boxplot([z1, z2, z3, z4, z5, z6, z7, z8, z9, z10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - 1 stddev')
xlabel('Event Width Percentile')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QEvsEventWidth_1stddev', '-dpng')