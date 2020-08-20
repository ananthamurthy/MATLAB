%% Figures for paper - Kambadur Ananthamurthy - Q vs Max Noise
close all

% Generated Synthetic Data
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/synthDATA_batch_220.mat')

% Analysed Data
%load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200729_cRun2_cData.mat')
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200729_gRun2_methodE_batch_1-220.mat')

figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)

%% ORIGINAL METHOD
% Sequential Timing
% Parameter Sensitivity - Q vs Max Percent Noise

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(101).ptcList;
ocList = sdo_batch(101).ocList;

fig1 = figure(1);
set(fig1,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = sdo_batch(101).Q(ptcList);
y2 = sdo_batch(102).Q(ptcList);
y3 = sdo_batch(103).Q(ptcList);
y4 = sdo_batch(104).Q(ptcList);
y5 = sdo_batch(105).Q(ptcList);
y6 = sdo_batch(106).Q(ptcList);
y7 = sdo_batch(107).Q(ptcList);
y8 = sdo_batch(108).Q(ptcList);
y9 = sdo_batch(109).Q(ptcList);
y10 = sdo_batch(110).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Sequential Timing')
xlabel('Gaussian Noise (%)')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = sdo_batch(101).Q(ocList);
y2 = sdo_batch(102).Q(ocList);
y3 = sdo_batch(103).Q(ocList);
y4 = sdo_batch(104).Q(ocList);
y5 = sdo_batch(105).Q(ocList);
y6 = sdo_batch(106).Q(ocList);
y7 = sdo_batch(107).Q(ocList);
y8 = sdo_batch(108).Q(ocList);
y9 = sdo_batch(109).Q(ocList);
y10 = sdo_batch(110).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Sequential Timing')
xlabel('Gaussian Noise (%)')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QvsNoisePercent_seq', '-dpng')

% Random Timing
fig2 = figure(2);
set(fig2,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = sdo_batch(211).Q(ptcList);
y2 = sdo_batch(212).Q(ptcList);
y3 = sdo_batch(213).Q(ptcList);
y4 = sdo_batch(214).Q(ptcList);
y5 = sdo_batch(215).Q(ptcList);
y6 = sdo_batch(216).Q(ptcList);
y7 = sdo_batch(217).Q(ptcList);
y8 = sdo_batch(218).Q(ptcList);
y9 = sdo_batch(219).Q(ptcList);
y10 = sdo_batch(220).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Random Timing')
xlabel('Gaussian Noise (%)')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = sdo_batch(211).Q(ocList);
y2 = sdo_batch(212).Q(ocList);
y3 = sdo_batch(213).Q(ocList);
y4 = sdo_batch(214).Q(ocList);
y5 = sdo_batch(215).Q(ocList);
y6 = sdo_batch(216).Q(ocList);
y7 = sdo_batch(217).Q(ocList);
y8 = sdo_batch(218).Q(ocList);
y9 = sdo_batch(219).Q(ocList);
y10 = sdo_batch(220).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Random Timing')
xlabel('Gaussian Noise (%)')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QvsNoisePercent_rnd', '-dpng')
% 
% %% METHOD A
% % Sequential Timing
% % Parameter Sensitivity - Q vs Max Percent Noise
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(101).ptcList;
% ocList = sdo_batch(101).ocList;
% 
% fig3 = figure(3);
% set(fig3,'Position',[300,300,1000,500])
% subplot(1,2,1)
% y1 = cData.methodA.mAOutput_batch(101).Q(ptcList);
% y2 = cData.methodA.mAOutput_batch(102).Q(ptcList);
% y3 = cData.methodA.mAOutput_batch(103).Q(ptcList);
% y4 = cData.methodA.mAOutput_batch(104).Q(ptcList);
% y5 = cData.methodA.mAOutput_batch(105).Q(ptcList);
% y6 = cData.methodA.mAOutput_batch(106).Q(ptcList);
% y7 = cData.methodA.mAOutput_batch(107).Q(ptcList);
% y8 = cData.methodA.mAOutput_batch(108).Q(ptcList);
% y9 = cData.methodA.mAOutput_batch(109).Q(ptcList);
% y10 = cData.methodA.mAOutput_batch(110).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Putative Time Cells - Sequential Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QA')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(1,2,2)
% y1 = cData.methodA.mAOutput_batch(101).Q(ocList);
% y2 = cData.methodA.mAOutput_batch(102).Q(ocList);
% y3 = cData.methodA.mAOutput_batch(103).Q(ocList);
% y4 = cData.methodA.mAOutput_batch(104).Q(ocList);
% y5 = cData.methodA.mAOutput_batch(105).Q(ocList);
% y6 = cData.methodA.mAOutput_batch(106).Q(ocList);
% y7 = cData.methodA.mAOutput_batch(107).Q(ocList);
% y8 = cData.methodA.mAOutput_batch(108).Q(ocList);
% y9 = cData.methodA.mAOutput_batch(109).Q(ocList);
% y10 = cData.methodA.mAOutput_batch(110).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Other Cells - Sequential Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QA')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QAvsNoisePercent_seq', '-dpng')
% 
% % Random Timing
% fig4 = figure(4);
% set(fig4,'Position',[300,300,1000,500])
% subplot(1,2,1)
% y1 = cData.methodA.mAOutput_batch(211).Q(ptcList);
% y2 = cData.methodA.mAOutput_batch(212).Q(ptcList);
% y3 = cData.methodA.mAOutput_batch(213).Q(ptcList);
% y4 = cData.methodA.mAOutput_batch(214).Q(ptcList);
% y5 = cData.methodA.mAOutput_batch(215).Q(ptcList);
% y6 = cData.methodA.mAOutput_batch(216).Q(ptcList);
% y7 = cData.methodA.mAOutput_batch(217).Q(ptcList);
% y8 = cData.methodA.mAOutput_batch(218).Q(ptcList);
% y9 = cData.methodA.mAOutput_batch(219).Q(ptcList);
% y10 = cData.methodA.mAOutput_batch(220).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Putative Time Cells - Random Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QA')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(1,2,2)
% y1 = cData.methodA.mAOutput_batch(211).Q(ocList);
% y2 = cData.methodA.mAOutput_batch(212).Q(ocList);
% y3 = cData.methodA.mAOutput_batch(213).Q(ocList);
% y4 = cData.methodA.mAOutput_batch(214).Q(ocList);
% y5 = cData.methodA.mAOutput_batch(215).Q(ocList);
% y6 = cData.methodA.mAOutput_batch(216).Q(ocList);
% y7 = cData.methodA.mAOutput_batch(217).Q(ocList);
% y8 = cData.methodA.mAOutput_batch(218).Q(ocList);
% y9 = cData.methodA.mAOutput_batch(219).Q(ocList);
% y10 = cData.methodA.mAOutput_batch(220).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Other Cells - Random Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QA')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QAvsNoisePercent_rnd', '-dpng')
% 
% %% METHOD B
% % Sequential Timing
% % Parameter Sensitivity - Q vs Max Percent Noise
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(101).ptcList;
% ocList = sdo_batch(101).ocList;
% 
% fig5 = figure(5);
% set(fig5,'Position',[300,300,1000,500])
% subplot(1,2,1)
% y1 = cData.methodB.holyData.mBOutput_batch(101).Q(ptcList);
% y2 = cData.methodB.holyData.mBOutput_batch(102).Q(ptcList);
% y3 = cData.methodB.holyData.mBOutput_batch(103).Q(ptcList);
% y4 = cData.methodB.holyData.mBOutput_batch(104).Q(ptcList);
% y5 = cData.methodB.holyData.mBOutput_batch(105).Q(ptcList);
% y6 = cData.methodB.holyData.mBOutput_batch(106).Q(ptcList);
% y7 = cData.methodB.holyData.mBOutput_batch(107).Q(ptcList);
% y8 = cData.methodB.holyData.mBOutput_batch(108).Q(ptcList);
% y9 = cData.methodB.holyData.mBOutput_batch(109).Q(ptcList);
% y10 = cData.methodB.holyData.mBOutput_batch(110).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Putative Time Cells - Sequential Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QB')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(1,2,2)
% y1 = cData.methodB.holyData.mBOutput_batch(101).Q(ocList);
% y2 = cData.methodB.holyData.mBOutput_batch(102).Q(ocList);
% y3 = cData.methodB.holyData.mBOutput_batch(103).Q(ocList);
% y4 = cData.methodB.holyData.mBOutput_batch(104).Q(ocList);
% y5 = cData.methodB.holyData.mBOutput_batch(105).Q(ocList);
% y6 = cData.methodB.holyData.mBOutput_batch(106).Q(ocList);
% y7 = cData.methodB.holyData.mBOutput_batch(107).Q(ocList);
% y8 = cData.methodB.holyData.mBOutput_batch(108).Q(ocList);
% y9 = cData.methodB.holyData.mBOutput_batch(109).Q(ocList);
% y10 = cData.methodB.holyData.mBOutput_batch(110).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Other Cells - Sequential Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QB')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QBvsNoisePercent_seq', '-dpng')
% 
% % Random Timing
% fig6 = figure(6);
% set(fig6,'Position',[300,300,1000,500])
% subplot(1,2,1)
% y1 = cData.methodB.holyData.mBOutput_batch(211).Q(ptcList);
% y2 = cData.methodB.holyData.mBOutput_batch(212).Q(ptcList);
% y3 = cData.methodB.holyData.mBOutput_batch(213).Q(ptcList);
% y4 = cData.methodB.holyData.mBOutput_batch(214).Q(ptcList);
% y5 = cData.methodB.holyData.mBOutput_batch(215).Q(ptcList);
% y6 = cData.methodB.holyData.mBOutput_batch(216).Q(ptcList);
% y7 = cData.methodB.holyData.mBOutput_batch(217).Q(ptcList);
% y8 = cData.methodB.holyData.mBOutput_batch(218).Q(ptcList);
% y9 = cData.methodB.holyData.mBOutput_batch(219).Q(ptcList);
% y10 = cData.methodB.holyData.mBOutput_batch(220).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Putative Time Cells - Random Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QB')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(1,2,2)
% y1 = cData.methodB.holyData.mBOutput_batch(211).Q(ocList);
% y2 = cData.methodB.holyData.mBOutput_batch(212).Q(ocList);
% y3 = cData.methodB.holyData.mBOutput_batch(213).Q(ocList);
% y4 = cData.methodB.holyData.mBOutput_batch(214).Q(ocList);
% y5 = cData.methodB.holyData.mBOutput_batch(215).Q(ocList);
% y6 = cData.methodB.holyData.mBOutput_batch(216).Q(ocList);
% y7 = cData.methodB.holyData.mBOutput_batch(217).Q(ocList);
% y8 = cData.methodB.holyData.mBOutput_batch(218).Q(ocList);
% y9 = cData.methodB.holyData.mBOutput_batch(219).Q(ocList);
% y10 = cData.methodB.holyData.mBOutput_batch(220).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Other Cells - Random Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QB')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QBvsNoisePercent_rnd', '-dpng')
% 
% %% METHOD C
% % C1
% % Sequential Timing
% % Parameter Sensitivity - Q vs Max Percent Noise
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(101).ptcList;
% ocList = sdo_batch(101).ocList;
% 
% fig7 = figure(7);
% set(fig7,'Position',[300,300,1000,500])
% subplot(1,2,1)
% y1 = cData.methodC.mCOutput_batch(101).Q1(ptcList);
% y2 = cData.methodC.mCOutput_batch(102).Q1(ptcList);
% y3 = cData.methodC.mCOutput_batch(103).Q1(ptcList);
% y4 = cData.methodC.mCOutput_batch(104).Q1(ptcList);
% y5 = cData.methodC.mCOutput_batch(105).Q1(ptcList);
% y6 = cData.methodC.mCOutput_batch(106).Q1(ptcList);
% y7 = cData.methodC.mCOutput_batch(107).Q1(ptcList);
% y8 = cData.methodC.mCOutput_batch(108).Q1(ptcList);
% y9 = cData.methodC.mCOutput_batch(109).Q1(ptcList);
% y10 = cData.methodC.mCOutput_batch(110).Q1(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Putative Time Cells - Sequential Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QC1 (all putative time cells)')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(1,2,2)
% y1 = cData.methodC.mCOutput_batch(101).Q1(ocList);
% y2 = cData.methodC.mCOutput_batch(102).Q1(ocList);
% y3 = cData.methodC.mCOutput_batch(103).Q1(ocList);
% y4 = cData.methodC.mCOutput_batch(104).Q1(ocList);
% y5 = cData.methodC.mCOutput_batch(105).Q1(ocList);
% y6 = cData.methodC.mCOutput_batch(106).Q1(ocList);
% y7 = cData.methodC.mCOutput_batch(107).Q1(ocList);
% y8 = cData.methodC.mCOutput_batch(108).Q1(ocList);
% y9 = cData.methodC.mCOutput_batch(109).Q1(ocList);
% y10 = cData.methodC.mCOutput_batch(110).Q1(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Other Cells - Sequential Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QC1')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC1vsNoisePercent_seq', '-dpng')
% 
% % Random Timing
% fig8 = figure(8);
% set(fig8,'Position',[300,300,1000,500])
% subplot(1,2,1)
% y1 = cData.methodC.mCOutput_batch(211).Q1(ptcList);
% y2 = cData.methodC.mCOutput_batch(212).Q1(ptcList);
% y3 = cData.methodC.mCOutput_batch(213).Q1(ptcList);
% y4 = cData.methodC.mCOutput_batch(214).Q1(ptcList);
% y5 = cData.methodC.mCOutput_batch(215).Q1(ptcList);
% y6 = cData.methodC.mCOutput_batch(216).Q1(ptcList);
% y7 = cData.methodC.mCOutput_batch(217).Q1(ptcList);
% y8 = cData.methodC.mCOutput_batch(218).Q1(ptcList);
% y9 = cData.methodC.mCOutput_batch(219).Q1(ptcList);
% y10 = cData.methodC.mCOutput_batch(220).Q1(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Putative Time Cells - Random Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QC1')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(1,2,2)
% y1 = cData.methodC.mCOutput_batch(211).Q1(ocList);
% y2 = cData.methodC.mCOutput_batch(212).Q1(ocList);
% y3 = cData.methodC.mCOutput_batch(213).Q1(ocList);
% y4 = cData.methodC.mCOutput_batch(214).Q1(ocList);
% y5 = cData.methodC.mCOutput_batch(215).Q1(ocList);
% y6 = cData.methodC.mCOutput_batch(216).Q1(ocList);
% y7 = cData.methodC.mCOutput_batch(217).Q1(ocList);
% y8 = cData.methodC.mCOutput_batch(218).Q1(ocList);
% y9 = cData.methodC.mCOutput_batch(219).Q1(ocList);
% y10 = cData.methodC.mCOutput_batch(220).Q1(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Other Cells - Random Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QC1')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC1vsNoisePercent_rnd', '-dpng')
% 
% % C2
% % Sequential Timing
% % Parameter Sensitivity - Q vs Max Percent Noise
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(101).ptcList;
% ocList = sdo_batch(101).ocList;
% 
% fig9 = figure(9);
% set(fig9,'Position',[300,300,1000,500])
% subplot(1,2,1)
% y1 = cData.methodC.mCOutput_batch(101).Q2(ptcList);
% y2 = cData.methodC.mCOutput_batch(102).Q2(ptcList);
% y3 = cData.methodC.mCOutput_batch(103).Q2(ptcList);
% y4 = cData.methodC.mCOutput_batch(104).Q2(ptcList);
% y5 = cData.methodC.mCOutput_batch(105).Q2(ptcList);
% y6 = cData.methodC.mCOutput_batch(106).Q2(ptcList);
% y7 = cData.methodC.mCOutput_batch(107).Q2(ptcList);
% y8 = cData.methodC.mCOutput_batch(108).Q2(ptcList);
% y9 = cData.methodC.mCOutput_batch(109).Q2(ptcList);
% y10 = cData.methodC.mCOutput_batch(110).Q2(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Putative Time Cells - Sequential Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QC1 (all putative time cells)')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(1,2,2)
% y1 = cData.methodC.mCOutput_batch(101).Q2(ocList);
% y2 = cData.methodC.mCOutput_batch(102).Q2(ocList);
% y3 = cData.methodC.mCOutput_batch(103).Q2(ocList);
% y4 = cData.methodC.mCOutput_batch(104).Q2(ocList);
% y5 = cData.methodC.mCOutput_batch(105).Q2(ocList);
% y6 = cData.methodC.mCOutput_batch(106).Q2(ocList);
% y7 = cData.methodC.mCOutput_batch(107).Q2(ocList);
% y8 = cData.methodC.mCOutput_batch(108).Q2(ocList);
% y9 = cData.methodC.mCOutput_batch(109).Q2(ocList);
% y10 = cData.methodC.mCOutput_batch(110).Q2(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Other Cells - Sequential Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QC1')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC2vsNoisePercent_seq', '-dpng')
% 
% % Random Timing
% fig10 = figure(10);
% set(fig10,'Position',[300,300,1000,500])
% subplot(1,2,1)
% y1 = cData.methodC.mCOutput_batch(211).Q2(ptcList);
% y2 = cData.methodC.mCOutput_batch(212).Q2(ptcList);
% y3 = cData.methodC.mCOutput_batch(213).Q2(ptcList);
% y4 = cData.methodC.mCOutput_batch(214).Q2(ptcList);
% y5 = cData.methodC.mCOutput_batch(215).Q2(ptcList);
% y6 = cData.methodC.mCOutput_batch(216).Q2(ptcList);
% y7 = cData.methodC.mCOutput_batch(217).Q2(ptcList);
% y8 = cData.methodC.mCOutput_batch(218).Q2(ptcList);
% y9 = cData.methodC.mCOutput_batch(219).Q2(ptcList);
% y10 = cData.methodC.mCOutput_batch(220).Q2(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Putative Time Cells - Random Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QC1')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(1,2,2)
% y1 = cData.methodC.mCOutput_batch(211).Q2(ocList);
% y2 = cData.methodC.mCOutput_batch(212).Q2(ocList);
% y3 = cData.methodC.mCOutput_batch(213).Q2(ocList);
% y4 = cData.methodC.mCOutput_batch(214).Q2(ocList);
% y5 = cData.methodC.mCOutput_batch(215).Q2(ocList);
% y6 = cData.methodC.mCOutput_batch(216).Q2(ocList);
% y7 = cData.methodC.mCOutput_batch(217).Q2(ocList);
% y8 = cData.methodC.mCOutput_batch(218).Q2(ocList);
% y9 = cData.methodC.mCOutput_batch(219).Q2(ocList);
% y10 = cData.methodC.mCOutput_batch(220).Q2(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Other Cells - Random Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QC1')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC2vsNoisePercent_rnd', '-dpng')
% 
% %% METHOD D
% % Sequential Timing
% % Parameter Sensitivity - Q vs Max Percent Noise
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(101).ptcList;
% ocList = sdo_batch(101).ocList;
% 
% fig11 = figure(11);
% set(fig11,'Position',[300,300,1000,500])
% subplot(1,2,1)
% y1 = cData.methodD.mDOutput_batch(101).Q(ptcList);
% y2 = cData.methodD.mDOutput_batch(102).Q(ptcList);
% y3 = cData.methodD.mDOutput_batch(103).Q(ptcList);
% y4 = cData.methodD.mDOutput_batch(104).Q(ptcList);
% y5 = cData.methodD.mDOutput_batch(105).Q(ptcList);
% y6 = cData.methodD.mDOutput_batch(106).Q(ptcList);
% y7 = cData.methodD.mDOutput_batch(107).Q(ptcList);
% y8 = cData.methodD.mDOutput_batch(108).Q(ptcList);
% y9 = cData.methodD.mDOutput_batch(109).Q(ptcList);
% y10 = cData.methodD.mDOutput_batch(110).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Putative Time Cells - Sequential Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QD')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(1,2,2)
% y1 = cData.methodD.mDOutput_batch(101).Q(ocList);
% y2 = cData.methodD.mDOutput_batch(102).Q(ocList);
% y3 = cData.methodD.mDOutput_batch(103).Q(ocList);
% y4 = cData.methodD.mDOutput_batch(104).Q(ocList);
% y5 = cData.methodD.mDOutput_batch(105).Q(ocList);
% y6 = cData.methodD.mDOutput_batch(106).Q(ocList);
% y7 = cData.methodD.mDOutput_batch(107).Q(ocList);
% y8 = cData.methodD.mDOutput_batch(108).Q(ocList);
% y9 = cData.methodD.mDOutput_batch(109).Q(ocList);
% y10 = cData.methodD.mDOutput_batch(110).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Other Cells - Sequential Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QD')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QDvsNoisePercent_seq', '-dpng')
% 
% % Random Timing
% fig12 = figure(12);
% set(fig12,'Position',[300,300,1000,500])
% subplot(1,2,1)
% y1 = cData.methodD.mDOutput_batch(211).Q(ptcList);
% y2 = cData.methodD.mDOutput_batch(212).Q(ptcList);
% y3 = cData.methodD.mDOutput_batch(213).Q(ptcList);
% y4 = cData.methodD.mDOutput_batch(214).Q(ptcList);
% y5 = cData.methodD.mDOutput_batch(215).Q(ptcList);
% y6 = cData.methodD.mDOutput_batch(216).Q(ptcList);
% y7 = cData.methodD.mDOutput_batch(217).Q(ptcList);
% y8 = cData.methodD.mDOutput_batch(218).Q(ptcList);
% y9 = cData.methodD.mDOutput_batch(219).Q(ptcList);
% y10 = cData.methodD.mDOutput_batch(220).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Putative Time Cells - Random Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QD')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(1,2,2)
% y1 = cData.methodD.mDOutput_batch(211).Q(ocList);
% y2 = cData.methodD.mDOutput_batch(212).Q(ocList);
% y3 = cData.methodD.mDOutput_batch(213).Q(ocList);
% y4 = cData.methodD.mDOutput_batch(214).Q(ocList);
% y5 = cData.methodD.mDOutput_batch(215).Q(ocList);
% y6 = cData.methodD.mDOutput_batch(216).Q(ocList);
% y7 = cData.methodD.mDOutput_batch(217).Q(ocList);
% y8 = cData.methodD.mDOutput_batch(218).Q(ocList);
% y9 = cData.methodD.mDOutput_batch(219).Q(ocList);
% y10 = cData.methodD.mDOutput_batch(220).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
% title('Other Cells - Random Timing')
% xlabel('Gaussian Noise (%)')
% ylabel('QD')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QDvsNoisePercent_rnd', '-dpng')

%% METHOD E
% Sequential Timing
% Parameter Sensitivity - Q vs Max Percent Noise
 
% Since the ptcList does not change over the course of this
ptcList = sdo_batch(101).ptcList
ocList = sdo_batch(101).ocList

fig13 = figure(13);
set(fig13,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = cData.methodE.mEOutput_batch(101).Q(ptcList);
y2 = cData.methodE.mEOutput_batch(102).Q(ptcList);
y3 = cData.methodE.mEOutput_batch(103).Q(ptcList);
y4 = cData.methodE.mEOutput_batch(104).Q(ptcList);
y5 = cData.methodE.mEOutput_batch(105).Q(ptcList);
y6 = cData.methodE.mEOutput_batch(106).Q(ptcList);
y7 = cData.methodE.mEOutput_batch(107).Q(ptcList);
y8 = cData.methodE.mEOutput_batch(108).Q(ptcList);
y9 = cData.methodE.mEOutput_batch(109).Q(ptcList);
y10 = cData.methodE.mEOutput_batch(110).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Sequential Timing')
xlabel('Gaussian Noise (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = cData.methodE.mEOutput_batch(101).Q(ocList);
y2 = cData.methodE.mEOutput_batch(102).Q(ocList);
y3 = cData.methodE.mEOutput_batch(103).Q(ocList);
y4 = cData.methodE.mEOutput_batch(104).Q(ocList);
y5 = cData.methodE.mEOutput_batch(105).Q(ocList);
y6 = cData.methodE.mEOutput_batch(106).Q(ocList);
y7 = cData.methodE.mEOutput_batch(107).Q(ocList);
y8 = cData.methodE.mEOutput_batch(108).Q(ocList);
y9 = cData.methodE.mEOutput_batch(109).Q(ocList);
y10 = cData.methodE.mEOutput_batch(110).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Sequential Timing')
xlabel('Gaussian Noise (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QEvsNoisePercent_seq', '-dpng')

Random Timing
fig14 = figure(14);
set(fig14,'Position',[300,300,1000,500])
subplot(1,2,1)
y1 = cData.methodE.mEOutput_batch(211).Q(ptcList);
y2 = cData.methodE.mEOutput_batch(212).Q(ptcList);
y3 = cData.methodE.mEOutput_batch(213).Q(ptcList);
y4 = cData.methodE.mEOutput_batch(214).Q(ptcList);
y5 = cData.methodE.mEOutput_batch(215).Q(ptcList);
y6 = cData.methodE.mEOutput_batch(216).Q(ptcList);
y7 = cData.methodE.mEOutput_batch(217).Q(ptcList);
y8 = cData.methodE.mEOutput_batch(218).Q(ptcList);
y9 = cData.methodE.mEOutput_batch(219).Q(ptcList);
y10 = cData.methodE.mEOutput_batch(220).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Random Timing')
xlabel('Gaussian Noise (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(1,2,2)
y1 = cData.methodE.mEOutput_batch(211).Q(ocList);
y2 = cData.methodE.mEOutput_batch(212).Q(ocList);
y3 = cData.methodE.mEOutput_batch(213).Q(ocList);
y4 = cData.methodE.mEOutput_batch(214).Q(ocList);
y5 = cData.methodE.mEOutput_batch(215).Q(ocList);
y6 = cData.methodE.mEOutput_batch(216).Q(ocList);
y7 = cData.methodE.mEOutput_batch(217).Q(ocList);
y8 = cData.methodE.mEOutput_batch(218).Q(ocList);
y9 = cData.methodE.mEOutput_batch(219).Q(ocList);
y10 = cData.methodE.mEOutput_batch(220).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Random Timing')
xlabel('Gaussian Noise (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)
print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QEvsNoisePercent_rnd', '-dpng')
