%% Figures for paper - Kambadur Ananthamurthy - Q vs Imprecision FWHM
close all

% Generated Synthetic Data
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/synthDATA_batch_220.mat')

% Analysed Data
%load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200615_cRun4_cData.mat')
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200729_gRun2_methodE_batch_1-220.mat')

figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)

%% ORIGINAL METHOD
% % Sequential Timing
% % Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(81).ptcList;
% ocList = sdo_batch(81).ocList;
% 
% fig1 = figure(1);
% set(fig1,'Position',[300,300,1000,1000])
% subplot(2,2,1)
% y1 = sdo_batch(81).Q(ptcList);
% y2 = sdo_batch(82).Q(ptcList);
% y3 = sdo_batch(83).Q(ptcList);
% y4 = sdo_batch(84).Q(ptcList);
% y5 = sdo_batch(85).Q(ptcList);
% y6 = sdo_batch(86).Q(ptcList);
% y7 = sdo_batch(87).Q(ptcList);
% y8 = sdo_batch(88).Q(ptcList);
% y9 = sdo_batch(89).Q(ptcList);
% y10 = sdo_batch(90).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Uniform Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('Q')
% ylim([-0.5 1])
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,2)
% y1 = sdo_batch(81).Q(ocList);
% y2 = sdo_batch(82).Q(ocList);
% y3 = sdo_batch(83).Q(ocList);
% y4 = sdo_batch(84).Q(ocList);
% y5 = sdo_batch(85).Q(ocList);
% y6 = sdo_batch(86).Q(ocList);
% y7 = sdo_batch(87).Q(ocList);
% y8 = sdo_batch(88).Q(ocList);
% y9 = sdo_batch(89).Q(ocList);
% y10 = sdo_batch(90).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Uniform Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('Q')
% ylim([-0.5 1])
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,3)
% y1 = sdo_batch(91).Q(ptcList);
% y2 = sdo_batch(92).Q(ptcList);
% y3 = sdo_batch(93).Q(ptcList);
% y4 = sdo_batch(94).Q(ptcList);
% y5 = sdo_batch(95).Q(ptcList);
% y6 = sdo_batch(96).Q(ptcList);
% y7 = sdo_batch(97).Q(ptcList);
% y8 = sdo_batch(98).Q(ptcList);
% y9 = sdo_batch(99).Q(ptcList);
% y10 = sdo_batch(100).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Normal Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('Q')
% ylim([-0.5 1])
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,4)
% y1 = sdo_batch(91).Q(ocList);
% y2 = sdo_batch(92).Q(ocList);
% y3 = sdo_batch(93).Q(ocList);
% y4 = sdo_batch(94).Q(ocList);
% y5 = sdo_batch(95).Q(ocList);
% y6 = sdo_batch(96).Q(ocList);
% y7 = sdo_batch(97).Q(ocList);
% y8 = sdo_batch(98).Q(ocList);
% y9 = sdo_batch(99).Q(ocList);
% y10 = sdo_batch(100).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Normal Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('Q')
% ylim([-0.5 1])
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QvsImprecision_seq', '-dpng')
% 
% % Random Timing
% % Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(81).ptcList;
% ocList = sdo_batch(81).ocList;
% 
% fig2 = figure(2);
% set(fig2,'Position',[300,300,1000,1000])
% subplot(2,2,1)
% y1 = sdo_batch(191).Q(ptcList);
% y2 = sdo_batch(192).Q(ptcList);
% y3 = sdo_batch(193).Q(ptcList);
% y4 = sdo_batch(194).Q(ptcList);
% y5 = sdo_batch(195).Q(ptcList);
% y6 = sdo_batch(196).Q(ptcList);
% y7 = sdo_batch(197).Q(ptcList);
% y8 = sdo_batch(198).Q(ptcList);
% y9 = sdo_batch(199).Q(ptcList);
% y10 = sdo_batch(200).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Uniform Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('Q')
% ylim([-0.5 1])
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,2)
% y1 = sdo_batch(191).Q(ocList);
% y2 = sdo_batch(192).Q(ocList);
% y3 = sdo_batch(193).Q(ocList);
% y4 = sdo_batch(194).Q(ocList);
% y5 = sdo_batch(195).Q(ocList);
% y6 = sdo_batch(196).Q(ocList);
% y7 = sdo_batch(197).Q(ocList);
% y8 = sdo_batch(198).Q(ocList);
% y9 = sdo_batch(199).Q(ocList);
% y10 = sdo_batch(200).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Uniform Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('Q')
% ylim([-0.5 1])
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,3)
% y1 = sdo_batch(201).Q(ptcList);
% y2 = sdo_batch(202).Q(ptcList);
% y3 = sdo_batch(203).Q(ptcList);
% y4 = sdo_batch(204).Q(ptcList);
% y5 = sdo_batch(205).Q(ptcList);
% y6 = sdo_batch(206).Q(ptcList);
% y7 = sdo_batch(207).Q(ptcList);
% y8 = sdo_batch(208).Q(ptcList);
% y9 = sdo_batch(209).Q(ptcList);
% y10 = sdo_batch(210).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Normal Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('Q')
% ylim([-0.5 1])
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,4)
% y1 = sdo_batch(201).Q(ocList);
% y2 = sdo_batch(202).Q(ocList);
% y3 = sdo_batch(203).Q(ocList);
% y4 = sdo_batch(204).Q(ocList);
% y5 = sdo_batch(205).Q(ocList);
% y6 = sdo_batch(206).Q(ocList);
% y7 = sdo_batch(207).Q(ocList);
% y8 = sdo_batch(208).Q(ocList);
% y9 = sdo_batch(209).Q(ocList);
% y10 = sdo_batch(210).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Normal Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('Q')
% ylim([-0.5 1])
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QvsImprecision_rnd', '-dpng')
% 
% %% METHOD A
% % Sequential Timing
% % Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(81).ptcList;
% ocList = sdo_batch(81).ocList;
% 
% fig3 = figure(3);
% set(fig3,'Position',[300,300,1000,1000])
% subplot(2,2,1)
% y1 = cData.methodA.mAOutput_batch(81).Q(ptcList);
% y2 = cData.methodA.mAOutput_batch(82).Q(ptcList);
% y3 = cData.methodA.mAOutput_batch(83).Q(ptcList);
% y4 = cData.methodA.mAOutput_batch(84).Q(ptcList);
% y5 = cData.methodA.mAOutput_batch(85).Q(ptcList);
% y6 = cData.methodA.mAOutput_batch(86).Q(ptcList);
% y7 = cData.methodA.mAOutput_batch(87).Q(ptcList);
% y8 = cData.methodA.mAOutput_batch(88).Q(ptcList);
% y9 = cData.methodA.mAOutput_batch(89).Q(ptcList);
% y10 = cData.methodA.mAOutput_batch(90).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Uniform Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QA')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,2)
% y1 = cData.methodA.mAOutput_batch(81).Q(ocList);
% y2 = cData.methodA.mAOutput_batch(82).Q(ocList);
% y3 = cData.methodA.mAOutput_batch(83).Q(ocList);
% y4 = cData.methodA.mAOutput_batch(84).Q(ocList);
% y5 = cData.methodA.mAOutput_batch(85).Q(ocList);
% y6 = cData.methodA.mAOutput_batch(86).Q(ocList);
% y7 = cData.methodA.mAOutput_batch(87).Q(ocList);
% y8 = cData.methodA.mAOutput_batch(88).Q(ocList);
% y9 = cData.methodA.mAOutput_batch(89).Q(ocList);
% y10 = cData.methodA.mAOutput_batch(90).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Uniform Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QA')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,3)
% y1 = cData.methodA.mAOutput_batch(91).Q(ptcList);
% y2 = cData.methodA.mAOutput_batch(92).Q(ptcList);
% y3 = cData.methodA.mAOutput_batch(93).Q(ptcList);
% y4 = cData.methodA.mAOutput_batch(94).Q(ptcList);
% y5 = cData.methodA.mAOutput_batch(95).Q(ptcList);
% y6 = cData.methodA.mAOutput_batch(96).Q(ptcList);
% y7 = cData.methodA.mAOutput_batch(97).Q(ptcList);
% y8 = cData.methodA.mAOutput_batch(98).Q(ptcList);
% y9 = cData.methodA.mAOutput_batch(99).Q(ptcList);
% y10 = cData.methodA.mAOutput_batch(100).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Normal Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QA')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,4)
% y1 = cData.methodA.mAOutput_batch(91).Q(ocList);
% y2 = cData.methodA.mAOutput_batch(92).Q(ocList);
% y3 = cData.methodA.mAOutput_batch(93).Q(ocList);
% y4 = cData.methodA.mAOutput_batch(94).Q(ocList);
% y5 = cData.methodA.mAOutput_batch(95).Q(ocList);
% y6 = cData.methodA.mAOutput_batch(96).Q(ocList);
% y7 = cData.methodA.mAOutput_batch(97).Q(ocList);
% y8 = cData.methodA.mAOutput_batch(98).Q(ocList);
% y9 = cData.methodA.mAOutput_batch(99).Q(ocList);
% y10 = cData.methodA.mAOutput_batch(100).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Normal Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QA')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QAvsImprecision_seq', '-dpng')
% 
% % Random Timing
% % Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(81).ptcList;
% ocList = sdo_batch(81).ocList;
% 
% fig4 = figure(4);
% set(fig4,'Position',[300,300,1000,1000])
% subplot(2,2,1)
% y1 = cData.methodA.mAOutput_batch(191).Q(ptcList);
% y2 = cData.methodA.mAOutput_batch(192).Q(ptcList);
% y3 = cData.methodA.mAOutput_batch(193).Q(ptcList);
% y4 = cData.methodA.mAOutput_batch(194).Q(ptcList);
% y5 = cData.methodA.mAOutput_batch(195).Q(ptcList);
% y6 = cData.methodA.mAOutput_batch(196).Q(ptcList);
% y7 = cData.methodA.mAOutput_batch(197).Q(ptcList);
% y8 = cData.methodA.mAOutput_batch(198).Q(ptcList);
% y9 = cData.methodA.mAOutput_batch(199).Q(ptcList);
% y10 = cData.methodA.mAOutput_batch(200).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Uniform Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QA')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,2)
% y1 = cData.methodA.mAOutput_batch(191).Q(ocList);
% y2 = cData.methodA.mAOutput_batch(192).Q(ocList);
% y3 = cData.methodA.mAOutput_batch(193).Q(ocList);
% y4 = cData.methodA.mAOutput_batch(194).Q(ocList);
% y5 = cData.methodA.mAOutput_batch(195).Q(ocList);
% y6 = cData.methodA.mAOutput_batch(196).Q(ocList);
% y7 = cData.methodA.mAOutput_batch(197).Q(ocList);
% y8 = cData.methodA.mAOutput_batch(198).Q(ocList);
% y9 = cData.methodA.mAOutput_batch(199).Q(ocList);
% y10 = cData.methodA.mAOutput_batch(200).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Uniform Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QA')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,3)
% y1 = cData.methodA.mAOutput_batch(201).Q(ptcList);
% y2 = cData.methodA.mAOutput_batch(202).Q(ptcList);
% y3 = cData.methodA.mAOutput_batch(203).Q(ptcList);
% y4 = cData.methodA.mAOutput_batch(204).Q(ptcList);
% y5 = cData.methodA.mAOutput_batch(205).Q(ptcList);
% y6 = cData.methodA.mAOutput_batch(206).Q(ptcList);
% y7 = cData.methodA.mAOutput_batch(207).Q(ptcList);
% y8 = cData.methodA.mAOutput_batch(208).Q(ptcList);
% y9 = cData.methodA.mAOutput_batch(209).Q(ptcList);
% y10 = cData.methodA.mAOutput_batch(210).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Normal Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QA')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,4)
% y1 = cData.methodA.mAOutput_batch(201).Q(ocList);
% y2 = cData.methodA.mAOutput_batch(202).Q(ocList);
% y3 = cData.methodA.mAOutput_batch(203).Q(ocList);
% y4 = cData.methodA.mAOutput_batch(204).Q(ocList);
% y5 = cData.methodA.mAOutput_batch(205).Q(ocList);
% y6 = cData.methodA.mAOutput_batch(206).Q(ocList);
% y7 = cData.methodA.mAOutput_batch(207).Q(ocList);
% y8 = cData.methodA.mAOutput_batch(208).Q(ocList);
% y9 = cData.methodA.mAOutput_batch(209).Q(ocList);
% y10 = cData.methodA.mAOutput_batch(210).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Normal Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QA')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QAvsImprecision_rnd', '-dpng')
% 
% %% METHOD B
% % Sequential Timing
% % Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(81).ptcList;
% ocList = sdo_batch(81).ocList;
% 
% fig5 = figure(5);
% set(fig5,'Position',[300,300,1000,1000])
% subplot(2,2,1)
% y1 = cData.methodB.holyData.mBOutput_batch(81).Q(ptcList);
% y2 = cData.methodB.holyData.mBOutput_batch(82).Q(ptcList);
% y3 = cData.methodB.holyData.mBOutput_batch(83).Q(ptcList);
% y4 = cData.methodB.holyData.mBOutput_batch(84).Q(ptcList);
% y5 = cData.methodB.holyData.mBOutput_batch(85).Q(ptcList);
% y6 = cData.methodB.holyData.mBOutput_batch(86).Q(ptcList);
% y7 = cData.methodB.holyData.mBOutput_batch(87).Q(ptcList);
% y8 = cData.methodB.holyData.mBOutput_batch(88).Q(ptcList);
% y9 = cData.methodB.holyData.mBOutput_batch(89).Q(ptcList);
% y10 = cData.methodB.holyData.mBOutput_batch(90).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Uniform Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QB')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,2)
% y1 = cData.methodB.holyData.mBOutput_batch(81).Q(ocList);
% y2 = cData.methodB.holyData.mBOutput_batch(82).Q(ocList);
% y3 = cData.methodB.holyData.mBOutput_batch(83).Q(ocList);
% y4 = cData.methodB.holyData.mBOutput_batch(84).Q(ocList);
% y5 = cData.methodB.holyData.mBOutput_batch(85).Q(ocList);
% y6 = cData.methodB.holyData.mBOutput_batch(86).Q(ocList);
% y7 = cData.methodB.holyData.mBOutput_batch(87).Q(ocList);
% y8 = cData.methodB.holyData.mBOutput_batch(88).Q(ocList);
% y9 = cData.methodB.holyData.mBOutput_batch(89).Q(ocList);
% y10 = cData.methodB.holyData.mBOutput_batch(90).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Uniform Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QB')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,3)
% y1 = cData.methodB.holyData.mBOutput_batch(91).Q(ptcList);
% y2 = cData.methodB.holyData.mBOutput_batch(92).Q(ptcList);
% y3 = cData.methodB.holyData.mBOutput_batch(93).Q(ptcList);
% y4 = cData.methodB.holyData.mBOutput_batch(94).Q(ptcList);
% y5 = cData.methodB.holyData.mBOutput_batch(95).Q(ptcList);
% y6 = cData.methodB.holyData.mBOutput_batch(96).Q(ptcList);
% y7 = cData.methodB.holyData.mBOutput_batch(97).Q(ptcList);
% y8 = cData.methodB.holyData.mBOutput_batch(98).Q(ptcList);
% y9 = cData.methodB.holyData.mBOutput_batch(99).Q(ptcList);
% y10 = cData.methodB.holyData.mBOutput_batch(100).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Normal Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QB')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,4)
% y1 = cData.methodB.holyData.mBOutput_batch(91).Q(ocList);
% y2 = cData.methodB.holyData.mBOutput_batch(92).Q(ocList);
% y3 = cData.methodB.holyData.mBOutput_batch(93).Q(ocList);
% y4 = cData.methodB.holyData.mBOutput_batch(94).Q(ocList);
% y5 = cData.methodB.holyData.mBOutput_batch(95).Q(ocList);
% y6 = cData.methodB.holyData.mBOutput_batch(96).Q(ocList);
% y7 = cData.methodB.holyData.mBOutput_batch(97).Q(ocList);
% y8 = cData.methodB.holyData.mBOutput_batch(98).Q(ocList);
% y9 = cData.methodB.holyData.mBOutput_batch(99).Q(ocList);
% y10 = cData.methodB.holyData.mBOutput_batch(100).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Normal Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QB')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QBvsImprecision_seq', '-dpng')
% 
% % Random Timing
% % Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(81).ptcList;
% ocList = sdo_batch(81).ocList;
% 
% fig6 = figure(6);
% set(fig6,'Position',[300,300,1000,1000])
% subplot(2,2,1)
% y1 = cData.methodB.holyData.mBOutput_batch(191).Q(ptcList);
% y2 = cData.methodB.holyData.mBOutput_batch(192).Q(ptcList);
% y3 = cData.methodB.holyData.mBOutput_batch(193).Q(ptcList);
% y4 = cData.methodB.holyData.mBOutput_batch(194).Q(ptcList);
% y5 = cData.methodB.holyData.mBOutput_batch(195).Q(ptcList);
% y6 = cData.methodB.holyData.mBOutput_batch(196).Q(ptcList);
% y7 = cData.methodB.holyData.mBOutput_batch(197).Q(ptcList);
% y8 = cData.methodB.holyData.mBOutput_batch(198).Q(ptcList);
% y9 = cData.methodB.holyData.mBOutput_batch(199).Q(ptcList);
% y10 = cData.methodB.holyData.mBOutput_batch(200).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Uniform Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QB')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,2)
% y1 = cData.methodB.holyData.mBOutput_batch(191).Q(ocList);
% y2 = cData.methodB.holyData.mBOutput_batch(192).Q(ocList);
% y3 = cData.methodB.holyData.mBOutput_batch(193).Q(ocList);
% y4 = cData.methodB.holyData.mBOutput_batch(194).Q(ocList);
% y5 = cData.methodB.holyData.mBOutput_batch(195).Q(ocList);
% y6 = cData.methodB.holyData.mBOutput_batch(196).Q(ocList);
% y7 = cData.methodB.holyData.mBOutput_batch(197).Q(ocList);
% y8 = cData.methodB.holyData.mBOutput_batch(198).Q(ocList);
% y9 = cData.methodB.holyData.mBOutput_batch(199).Q(ocList);
% y10 = cData.methodB.holyData.mBOutput_batch(200).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Uniform Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QB')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,3)
% y1 = cData.methodB.holyData.mBOutput_batch(201).Q(ptcList);
% y2 = cData.methodB.holyData.mBOutput_batch(202).Q(ptcList);
% y3 = cData.methodB.holyData.mBOutput_batch(203).Q(ptcList);
% y4 = cData.methodB.holyData.mBOutput_batch(204).Q(ptcList);
% y5 = cData.methodB.holyData.mBOutput_batch(205).Q(ptcList);
% y6 = cData.methodB.holyData.mBOutput_batch(206).Q(ptcList);
% y7 = cData.methodB.holyData.mBOutput_batch(207).Q(ptcList);
% y8 = cData.methodB.holyData.mBOutput_batch(208).Q(ptcList);
% y9 = cData.methodB.holyData.mBOutput_batch(209).Q(ptcList);
% y10 = cData.methodB.holyData.mBOutput_batch(210).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Normal Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QB')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,4)
% y1 = cData.methodB.holyData.mBOutput_batch(201).Q(ocList);
% y2 = cData.methodB.holyData.mBOutput_batch(202).Q(ocList);
% y3 = cData.methodB.holyData.mBOutput_batch(203).Q(ocList);
% y4 = cData.methodB.holyData.mBOutput_batch(204).Q(ocList);
% y5 = cData.methodB.holyData.mBOutput_batch(205).Q(ocList);
% y6 = cData.methodB.holyData.mBOutput_batch(206).Q(ocList);
% y7 = cData.methodB.holyData.mBOutput_batch(207).Q(ocList);
% y8 = cData.methodB.holyData.mBOutput_batch(208).Q(ocList);
% y9 = cData.methodB.holyData.mBOutput_batch(209).Q(ocList);
% y10 = cData.methodB.holyData.mBOutput_batch(210).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Normal Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QB')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QBvsImprecision_rnd', '-dpng')
% 
% %% METHOD C
% %C1
% % Sequential Timing
% % Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(81).ptcList;
% ocList = sdo_batch(81).ocList;
% 
% fig7 = figure(7);
% set(fig7,'Position',[300,300,1000,1000])
% subplot(2,2,1)
% y1 = cData.methodC.mCOutput_batch(81).Q1(ptcList);
% y2 = cData.methodC.mCOutput_batch(82).Q1(ptcList);
% y3 = cData.methodC.mCOutput_batch(83).Q1(ptcList);
% y4 = cData.methodC.mCOutput_batch(84).Q1(ptcList);
% y5 = cData.methodC.mCOutput_batch(85).Q1(ptcList);
% y6 = cData.methodC.mCOutput_batch(86).Q1(ptcList);
% y7 = cData.methodC.mCOutput_batch(87).Q1(ptcList);
% y8 = cData.methodC.mCOutput_batch(88).Q1(ptcList);
% y9 = cData.methodC.mCOutput_batch(89).Q1(ptcList);
% y10 = cData.methodC.mCOutput_batch(90).Q1(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Uniform Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC1')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,2)
% y1 = cData.methodC.mCOutput_batch(81).Q1(ocList);
% y2 = cData.methodC.mCOutput_batch(82).Q1(ocList);
% y3 = cData.methodC.mCOutput_batch(83).Q1(ocList);
% y4 = cData.methodC.mCOutput_batch(84).Q1(ocList);
% y5 = cData.methodC.mCOutput_batch(85).Q1(ocList);
% y6 = cData.methodC.mCOutput_batch(86).Q1(ocList);
% y7 = cData.methodC.mCOutput_batch(87).Q1(ocList);
% y8 = cData.methodC.mCOutput_batch(88).Q1(ocList);
% y9 = cData.methodC.mCOutput_batch(89).Q1(ocList);
% y10 = cData.methodC.mCOutput_batch(90).Q1(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Uniform Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC1')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,3)
% y1 = cData.methodC.mCOutput_batch(91).Q1(ptcList);
% y2 = cData.methodC.mCOutput_batch(92).Q1(ptcList);
% y3 = cData.methodC.mCOutput_batch(93).Q1(ptcList);
% y4 = cData.methodC.mCOutput_batch(94).Q1(ptcList);
% y5 = cData.methodC.mCOutput_batch(95).Q1(ptcList);
% y6 = cData.methodC.mCOutput_batch(96).Q1(ptcList);
% y7 = cData.methodC.mCOutput_batch(97).Q1(ptcList);
% y8 = cData.methodC.mCOutput_batch(98).Q1(ptcList);
% y9 = cData.methodC.mCOutput_batch(99).Q1(ptcList);
% y10 = cData.methodC.mCOutput_batch(100).Q1(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Normal Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC1')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,4)
% y1 = cData.methodC.mCOutput_batch(91).Q1(ocList);
% y2 = cData.methodC.mCOutput_batch(92).Q1(ocList);
% y3 = cData.methodC.mCOutput_batch(93).Q1(ocList);
% y4 = cData.methodC.mCOutput_batch(94).Q1(ocList);
% y5 = cData.methodC.mCOutput_batch(95).Q1(ocList);
% y6 = cData.methodC.mCOutput_batch(96).Q1(ocList);
% y7 = cData.methodC.mCOutput_batch(97).Q1(ocList);
% y8 = cData.methodC.mCOutput_batch(98).Q1(ocList);
% y9 = cData.methodC.mCOutput_batch(99).Q1(ocList);
% y10 = cData.methodC.mCOutput_batch(100).Q1(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Normal Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC1')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC1vsImprecision_seq', '-dpng')
% 
% % Random Timing
% % Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(81).ptcList;
% ocList = sdo_batch(81).ocList;
% 
% fig8 = figure(8);
% set(fig8,'Position',[300,300,1000,1000])
% subplot(2,2,1)
% y1 = cData.methodC.mCOutput_batch(191).Q1(ptcList);
% y2 = cData.methodC.mCOutput_batch(192).Q1(ptcList);
% y3 = cData.methodC.mCOutput_batch(193).Q1(ptcList);
% y4 = cData.methodC.mCOutput_batch(194).Q1(ptcList);
% y5 = cData.methodC.mCOutput_batch(195).Q1(ptcList);
% y6 = cData.methodC.mCOutput_batch(196).Q1(ptcList);
% y7 = cData.methodC.mCOutput_batch(197).Q1(ptcList);
% y8 = cData.methodC.mCOutput_batch(198).Q1(ptcList);
% y9 = cData.methodC.mCOutput_batch(199).Q1(ptcList);
% y10 = cData.methodC.mCOutput_batch(200).Q1(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Uniform Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC1')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,2)
% y1 = cData.methodC.mCOutput_batch(191).Q1(ocList);
% y2 = cData.methodC.mCOutput_batch(192).Q1(ocList);
% y3 = cData.methodC.mCOutput_batch(193).Q1(ocList);
% y4 = cData.methodC.mCOutput_batch(194).Q1(ocList);
% y5 = cData.methodC.mCOutput_batch(195).Q1(ocList);
% y6 = cData.methodC.mCOutput_batch(196).Q1(ocList);
% y7 = cData.methodC.mCOutput_batch(197).Q1(ocList);
% y8 = cData.methodC.mCOutput_batch(198).Q1(ocList);
% y9 = cData.methodC.mCOutput_batch(199).Q1(ocList);
% y10 = cData.methodC.mCOutput_batch(200).Q1(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Uniform Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC1')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,3)
% y1 = cData.methodC.mCOutput_batch(201).Q1(ptcList);
% y2 = cData.methodC.mCOutput_batch(202).Q1(ptcList);
% y3 = cData.methodC.mCOutput_batch(203).Q1(ptcList);
% y4 = cData.methodC.mCOutput_batch(204).Q1(ptcList);
% y5 = cData.methodC.mCOutput_batch(205).Q1(ptcList);
% y6 = cData.methodC.mCOutput_batch(206).Q1(ptcList);
% y7 = cData.methodC.mCOutput_batch(207).Q1(ptcList);
% y8 = cData.methodC.mCOutput_batch(208).Q1(ptcList);
% y9 = cData.methodC.mCOutput_batch(209).Q1(ptcList);
% y10 = cData.methodC.mCOutput_batch(210).Q1(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Normal Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC1')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,4)
% y1 = cData.methodC.mCOutput_batch(201).Q1(ocList);
% y2 = cData.methodC.mCOutput_batch(202).Q1(ocList);
% y3 = cData.methodC.mCOutput_batch(203).Q1(ocList);
% y4 = cData.methodC.mCOutput_batch(204).Q1(ocList);
% y5 = cData.methodC.mCOutput_batch(205).Q1(ocList);
% y6 = cData.methodC.mCOutput_batch(206).Q1(ocList);
% y7 = cData.methodC.mCOutput_batch(207).Q1(ocList);
% y8 = cData.methodC.mCOutput_batch(208).Q1(ocList);
% y9 = cData.methodC.mCOutput_batch(209).Q1(ocList);
% y10 = cData.methodC.mCOutput_batch(210).Q1(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Normal Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC1')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC1vsImprecision_rnd', '-dpng')
% 
% %C2
% % Sequential Timing
% % Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(81).ptcList;
% ocList = sdo_batch(81).ocList;
% 
% fig9 = figure(9);
% set(fig9,'Position',[300,300,1000,1000])
% subplot(2,2,1)
% y1 = cData.methodC.mCOutput_batch(81).Q2(ptcList);
% y2 = cData.methodC.mCOutput_batch(82).Q2(ptcList);
% y3 = cData.methodC.mCOutput_batch(83).Q2(ptcList);
% y4 = cData.methodC.mCOutput_batch(84).Q2(ptcList);
% y5 = cData.methodC.mCOutput_batch(85).Q2(ptcList);
% y6 = cData.methodC.mCOutput_batch(86).Q2(ptcList);
% y7 = cData.methodC.mCOutput_batch(87).Q2(ptcList);
% y8 = cData.methodC.mCOutput_batch(88).Q2(ptcList);
% y9 = cData.methodC.mCOutput_batch(89).Q2(ptcList);
% y10 = cData.methodC.mCOutput_batch(90).Q2(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Uniform Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC2')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,2)
% y1 = cData.methodC.mCOutput_batch(81).Q2(ocList);
% y2 = cData.methodC.mCOutput_batch(82).Q2(ocList);
% y3 = cData.methodC.mCOutput_batch(83).Q2(ocList);
% y4 = cData.methodC.mCOutput_batch(84).Q2(ocList);
% y5 = cData.methodC.mCOutput_batch(85).Q2(ocList);
% y6 = cData.methodC.mCOutput_batch(86).Q2(ocList);
% y7 = cData.methodC.mCOutput_batch(87).Q2(ocList);
% y8 = cData.methodC.mCOutput_batch(88).Q2(ocList);
% y9 = cData.methodC.mCOutput_batch(89).Q2(ocList);
% y10 = cData.methodC.mCOutput_batch(90).Q2(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Uniform Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC2')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,3)
% y1 = cData.methodC.mCOutput_batch(91).Q2(ptcList);
% y2 = cData.methodC.mCOutput_batch(92).Q2(ptcList);
% y3 = cData.methodC.mCOutput_batch(93).Q2(ptcList);
% y4 = cData.methodC.mCOutput_batch(94).Q2(ptcList);
% y5 = cData.methodC.mCOutput_batch(95).Q2(ptcList);
% y6 = cData.methodC.mCOutput_batch(96).Q2(ptcList);
% y7 = cData.methodC.mCOutput_batch(97).Q2(ptcList);
% y8 = cData.methodC.mCOutput_batch(98).Q2(ptcList);
% y9 = cData.methodC.mCOutput_batch(99).Q2(ptcList);
% y10 = cData.methodC.mCOutput_batch(100).Q2(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Normal Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC2')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,4)
% y1 = cData.methodC.mCOutput_batch(91).Q2(ocList);
% y2 = cData.methodC.mCOutput_batch(92).Q2(ocList);
% y3 = cData.methodC.mCOutput_batch(93).Q2(ocList);
% y4 = cData.methodC.mCOutput_batch(94).Q2(ocList);
% y5 = cData.methodC.mCOutput_batch(95).Q2(ocList);
% y6 = cData.methodC.mCOutput_batch(96).Q2(ocList);
% y7 = cData.methodC.mCOutput_batch(97).Q2(ocList);
% y8 = cData.methodC.mCOutput_batch(98).Q2(ocList);
% y9 = cData.methodC.mCOutput_batch(99).Q2(ocList);
% y10 = cData.methodC.mCOutput_batch(100).Q2(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Normal Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC2')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC2vsImprecision_seq', '-dpng')
% 
% % Random Timing
% % Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(81).ptcList;
% ocList = sdo_batch(81).ocList;
% 
% fig10 = figure(10);
% set(fig10,'Position',[300,300,1000,1000])
% subplot(2,2,1)
% y1 = cData.methodC.mCOutput_batch(191).Q2(ptcList);
% y2 = cData.methodC.mCOutput_batch(192).Q2(ptcList);
% y3 = cData.methodC.mCOutput_batch(193).Q2(ptcList);
% y4 = cData.methodC.mCOutput_batch(194).Q2(ptcList);
% y5 = cData.methodC.mCOutput_batch(195).Q2(ptcList);
% y6 = cData.methodC.mCOutput_batch(196).Q2(ptcList);
% y7 = cData.methodC.mCOutput_batch(197).Q2(ptcList);
% y8 = cData.methodC.mCOutput_batch(198).Q2(ptcList);
% y9 = cData.methodC.mCOutput_batch(199).Q2(ptcList);
% y10 = cData.methodC.mCOutput_batch(200).Q2(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Uniform Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC2')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,2)
% y1 = cData.methodC.mCOutput_batch(191).Q2(ocList);
% y2 = cData.methodC.mCOutput_batch(192).Q2(ocList);
% y3 = cData.methodC.mCOutput_batch(193).Q2(ocList);
% y4 = cData.methodC.mCOutput_batch(194).Q2(ocList);
% y5 = cData.methodC.mCOutput_batch(195).Q2(ocList);
% y6 = cData.methodC.mCOutput_batch(196).Q2(ocList);
% y7 = cData.methodC.mCOutput_batch(197).Q2(ocList);
% y8 = cData.methodC.mCOutput_batch(198).Q2(ocList);
% y9 = cData.methodC.mCOutput_batch(199).Q2(ocList);
% y10 = cData.methodC.mCOutput_batch(200).Q2(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Uniform Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC2')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,3)
% y1 = cData.methodC.mCOutput_batch(201).Q2(ptcList);
% y2 = cData.methodC.mCOutput_batch(202).Q2(ptcList);
% y3 = cData.methodC.mCOutput_batch(203).Q2(ptcList);
% y4 = cData.methodC.mCOutput_batch(204).Q2(ptcList);
% y5 = cData.methodC.mCOutput_batch(205).Q2(ptcList);
% y6 = cData.methodC.mCOutput_batch(206).Q2(ptcList);
% y7 = cData.methodC.mCOutput_batch(207).Q2(ptcList);
% y8 = cData.methodC.mCOutput_batch(208).Q2(ptcList);
% y9 = cData.methodC.mCOutput_batch(209).Q2(ptcList);
% y10 = cData.methodC.mCOutput_batch(210).Q2(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Normal Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC2')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,4)
% y1 = cData.methodC.mCOutput_batch(201).Q2(ocList);
% y2 = cData.methodC.mCOutput_batch(202).Q2(ocList);
% y3 = cData.methodC.mCOutput_batch(203).Q2(ocList);
% y4 = cData.methodC.mCOutput_batch(204).Q2(ocList);
% y5 = cData.methodC.mCOutput_batch(205).Q2(ocList);
% y6 = cData.methodC.mCOutput_batch(206).Q2(ocList);
% y7 = cData.methodC.mCOutput_batch(207).Q2(ocList);
% y8 = cData.methodC.mCOutput_batch(208).Q2(ocList);
% y9 = cData.methodC.mCOutput_batch(209).Q2(ocList);
% y10 = cData.methodC.mCOutput_batch(210).Q2(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Normal Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QC2')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC2vsImprecision_rnd', '-dpng')
% %% METHOD D
% % Sequential Timing
% % Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(81).ptcList;
% ocList = sdo_batch(81).ocList;
% 
% fig11 = figure(11);
% set(fig11,'Position',[300,300,1000,1000])
% subplot(2,2,1)
% y1 = cData.methodD.mDOutput_batch(81).Q(ptcList);
% y2 = cData.methodD.mDOutput_batch(82).Q(ptcList);
% y3 = cData.methodD.mDOutput_batch(83).Q(ptcList);
% y4 = cData.methodD.mDOutput_batch(84).Q(ptcList);
% y5 = cData.methodD.mDOutput_batch(85).Q(ptcList);
% y6 = cData.methodD.mDOutput_batch(86).Q(ptcList);
% y7 = cData.methodD.mDOutput_batch(87).Q(ptcList);
% y8 = cData.methodD.mDOutput_batch(88).Q(ptcList);
% y9 = cData.methodD.mDOutput_batch(89).Q(ptcList);
% y10 = cData.methodD.mDOutput_batch(90).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Uniform Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QD')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,2)
% y1 = cData.methodD.mDOutput_batch(81).Q(ocList);
% y2 = cData.methodD.mDOutput_batch(82).Q(ocList);
% y3 = cData.methodD.mDOutput_batch(83).Q(ocList);
% y4 = cData.methodD.mDOutput_batch(84).Q(ocList);
% y5 = cData.methodD.mDOutput_batch(85).Q(ocList);
% y6 = cData.methodD.mDOutput_batch(86).Q(ocList);
% y7 = cData.methodD.mDOutput_batch(87).Q(ocList);
% y8 = cData.methodD.mDOutput_batch(88).Q(ocList);
% y9 = cData.methodD.mDOutput_batch(89).Q(ocList);
% y10 = cData.methodD.mDOutput_batch(90).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Uniform Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QD')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,3)
% y1 = cData.methodD.mDOutput_batch(91).Q(ptcList);
% y2 = cData.methodD.mDOutput_batch(92).Q(ptcList);
% y3 = cData.methodD.mDOutput_batch(93).Q(ptcList);
% y4 = cData.methodD.mDOutput_batch(94).Q(ptcList);
% y5 = cData.methodD.mDOutput_batch(95).Q(ptcList);
% y6 = cData.methodD.mDOutput_batch(96).Q(ptcList);
% y7 = cData.methodD.mDOutput_batch(97).Q(ptcList);
% y8 = cData.methodD.mDOutput_batch(98).Q(ptcList);
% y9 = cData.methodD.mDOutput_batch(99).Q(ptcList);
% y10 = cData.methodD.mDOutput_batch(100).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Normal Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QD')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,4)
% y1 = cData.methodD.mDOutput_batch(91).Q(ocList);
% y2 = cData.methodD.mDOutput_batch(92).Q(ocList);
% y3 = cData.methodD.mDOutput_batch(93).Q(ocList);
% y4 = cData.methodD.mDOutput_batch(94).Q(ocList);
% y5 = cData.methodD.mDOutput_batch(95).Q(ocList);
% y6 = cData.methodD.mDOutput_batch(96).Q(ocList);
% y7 = cData.methodD.mDOutput_batch(97).Q(ocList);
% y8 = cData.methodD.mDOutput_batch(98).Q(ocList);
% y9 = cData.methodD.mDOutput_batch(99).Q(ocList);
% y10 = cData.methodD.mDOutput_batch(100).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Normal Imprecision | Seq')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QD')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QDvsImprecision_seq', '-dpng')
% 
% % Random Timing
% % Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt
% 
% %Since the ptcList does not change over the course of this
% ptcList = sdo_batch(81).ptcList;
% ocList = sdo_batch(81).ocList;
% 
% fig12 = figure(12);
% set(fig12,'Position',[300,300,1000,1000])
% subplot(2,2,1)
% y1 = cData.methodD.mDOutput_batch(191).Q(ptcList);
% y2 = cData.methodD.mDOutput_batch(192).Q(ptcList);
% y3 = cData.methodD.mDOutput_batch(193).Q(ptcList);
% y4 = cData.methodD.mDOutput_batch(194).Q(ptcList);
% y5 = cData.methodD.mDOutput_batch(195).Q(ptcList);
% y6 = cData.methodD.mDOutput_batch(196).Q(ptcList);
% y7 = cData.methodD.mDOutput_batch(197).Q(ptcList);
% y8 = cData.methodD.mDOutput_batch(198).Q(ptcList);
% y9 = cData.methodD.mDOutput_batch(199).Q(ptcList);
% y10 = cData.methodD.mDOutput_batch(200).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Uniform Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QD')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,2)
% y1 = cData.methodD.mDOutput_batch(191).Q(ocList);
% y2 = cData.methodD.mDOutput_batch(192).Q(ocList);
% y3 = cData.methodD.mDOutput_batch(193).Q(ocList);
% y4 = cData.methodD.mDOutput_batch(194).Q(ocList);
% y5 = cData.methodD.mDOutput_batch(195).Q(ocList);
% y6 = cData.methodD.mDOutput_batch(196).Q(ocList);
% y7 = cData.methodD.mDOutput_batch(197).Q(ocList);
% y8 = cData.methodD.mDOutput_batch(198).Q(ocList);
% y9 = cData.methodD.mDOutput_batch(199).Q(ocList);
% y10 = cData.methodD.mDOutput_batch(200).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Uniform Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QD')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,3)
% y1 = cData.methodD.mDOutput_batch(201).Q(ptcList);
% y2 = cData.methodD.mDOutput_batch(202).Q(ptcList);
% y3 = cData.methodD.mDOutput_batch(203).Q(ptcList);
% y4 = cData.methodD.mDOutput_batch(204).Q(ptcList);
% y5 = cData.methodD.mDOutput_batch(205).Q(ptcList);
% y6 = cData.methodD.mDOutput_batch(206).Q(ptcList);
% y7 = cData.methodD.mDOutput_batch(207).Q(ptcList);
% y8 = cData.methodD.mDOutput_batch(208).Q(ptcList);
% y9 = cData.methodD.mDOutput_batch(209).Q(ptcList);
% y10 = cData.methodD.mDOutput_batch(210).Q(ptcList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Putative Time Cells - Normal Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QD')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% subplot(2,2,4)
% y1 = cData.methodD.mDOutput_batch(201).Q(ocList);
% y2 = cData.methodD.mDOutput_batch(202).Q(ocList);
% y3 = cData.methodD.mDOutput_batch(203).Q(ocList);
% y4 = cData.methodD.mDOutput_batch(204).Q(ocList);
% y5 = cData.methodD.mDOutput_batch(205).Q(ocList);
% y6 = cData.methodD.mDOutput_batch(206).Q(ocList);
% y7 = cData.methodD.mDOutput_batch(207).Q(ocList);
% y8 = cData.methodD.mDOutput_batch(208).Q(ocList);
% y9 = cData.methodD.mDOutput_batch(209).Q(ocList);
% y10 = cData.methodD.mDOutput_batch(210).Q(ocList);
% 
% boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
%     'Notch','on', ...
%     'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
% title('Other Cells - Normal Imprecision | Rnd')
% xlabel('Imprecision FWHM (frames)')
% ylabel('QD')
% 
% set(gca, 'FontSize', figureDetails.fontSize-2)
% 
% print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QDvsImprecision_rnd', '-dpng')

%% METHOD E
% Sequential Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(81).ptcList;
ocList = sdo_batch(81).ocList;

fig13 = figure(13);
set(fig13,'Position',[300,300,1000,1000])
subplot(2,2,1)
y1 = mEOutput_batch(81).Q(ptcList)';
y2 = mEOutput_batch(82).Q(ptcList)';
y3 = mEOutput_batch(83).Q(ptcList)';
y4 = mEOutput_batch(84).Q(ptcList)';
y5 = mEOutput_batch(85).Q(ptcList)';
y6 = mEOutput_batch(86).Q(ptcList)';
y7 = mEOutput_batch(87).Q(ptcList)';
y8 = mEOutput_batch(88).Q(ptcList)';
y9 = mEOutput_batch(89).Q(ptcList)';
y10 = mEOutput_batch(90).Q(ptcList)';

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
title('Putative Time Cells - Uniform Imprecision | Seq')
xlabel('Imprecision FWHM (frames)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = mEOutput_batch(81).Q(ocList)';
y2 = mEOutput_batch(82).Q(ocList)';
y3 = mEOutput_batch(83).Q(ocList)';
y4 = mEOutput_batch(84).Q(ocList)';
y5 = mEOutput_batch(85).Q(ocList)';
y6 = mEOutput_batch(86).Q(ocList)';
y7 = mEOutput_batch(87).Q(ocList)';
y8 = mEOutput_batch(88).Q(ocList)';
y9 = mEOutput_batch(89).Q(ocList)';
y10 = mEOutput_batch(90).Q(ocList)';

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
title('Other Cells - Uniform Imprecision | Seq')
xlabel('Imprecision FWHM (frames)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = mEOutput_batch(91).Q(ptcList)';
y2 = mEOutput_batch(92).Q(ptcList)';
y3 = mEOutput_batch(93).Q(ptcList)';
y4 = mEOutput_batch(94).Q(ptcList)';
y5 = mEOutput_batch(95).Q(ptcList)';
y6 = mEOutput_batch(96).Q(ptcList)';
y7 = mEOutput_batch(97).Q(ptcList)';
y8 = mEOutput_batch(98).Q(ptcList)';
y9 = mEOutput_batch(99).Q(ptcList)';
y10 = mEOutput_batch(100).Q(ptcList)';

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
title('Putative Time Cells - Normal Imprecision | Seq')
xlabel('Imprecision FWHM (frames)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = mEOutput_batch(91).Q(ocList)';
y2 = mEOutput_batch(92).Q(ocList)';
y3 = mEOutput_batch(93).Q(ocList)';
y4 = mEOutput_batch(94).Q(ocList)';
y5 = mEOutput_batch(95).Q(ocList)';
y6 = mEOutput_batch(96).Q(ocList)';
y7 = mEOutput_batch(97).Q(ocList)';
y8 = mEOutput_batch(98).Q(ocList)';
y9 = mEOutput_batch(99).Q(ocList)';
y10 = mEOutput_batch(100).Q(ocList)';

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
title('Other Cells - Normal Imprecision | Seq')
xlabel('Imprecision FWHM (frames)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QEvsImprecision_seq', '-dpng')

% Random Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(81).ptcList;
ocList = sdo_batch(81).ocList;

fig14 = figure(14);
set(fig14,'Position',[300,300,1000,1000])
subplot(2,2,1)
y1 = mEOutput_batch(191).Q(ptcList)';
y2 = mEOutput_batch(192).Q(ptcList)';
y3 = mEOutput_batch(193).Q(ptcList)';
y4 = mEOutput_batch(194).Q(ptcList)';
y5 = mEOutput_batch(195).Q(ptcList)';
y6 = mEOutput_batch(196).Q(ptcList)';
y7 = mEOutput_batch(197).Q(ptcList)';
y8 = mEOutput_batch(198).Q(ptcList)';
y9 = mEOutput_batch(199).Q(ptcList)';
y10 = mEOutput_batch(200).Q(ptcList)';

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
title('Putative Time Cells - Uniform Imprecision | Rnd')
xlabel('Imprecision FWHM (frames)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = mEOutput_batch(191).Q(ocList)';
y2 = mEOutput_batch(192).Q(ocList)';
y3 = mEOutput_batch(193).Q(ocList)';
y4 = mEOutput_batch(194).Q(ocList)';
y5 = mEOutput_batch(195).Q(ocList)';
y6 = mEOutput_batch(196).Q(ocList)';
y7 = mEOutput_batch(197).Q(ocList)';
y8 = mEOutput_batch(198).Q(ocList)';
y9 = mEOutput_batch(199).Q(ocList)';
y10 = mEOutput_batch(200).Q(ocList)';

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
title('Other Cells - Uniform Imprecision | Rnd')
xlabel('Imprecision FWHM (frames)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = mEOutput_batch(201).Q(ptcList)';
y2 = mEOutput_batch(202).Q(ptcList)';
y3 = mEOutput_batch(203).Q(ptcList)';
y4 = mEOutput_batch(204).Q(ptcList)';
y5 = mEOutput_batch(205).Q(ptcList)';
y6 = mEOutput_batch(206).Q(ptcList)';
y7 = mEOutput_batch(207).Q(ptcList)';
y8 = mEOutput_batch(208).Q(ptcList)';
y9 = mEOutput_batch(209).Q(ptcList)';
y10 = mEOutput_batch(210).Q(ptcList)';

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
title('Putative Time Cells - Normal Imprecision | Rnd')
xlabel('Imprecision FWHM (frames)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = mEOutput_batch(201).Q(ocList)';
y2 = mEOutput_batch(202).Q(ocList)';
y3 = mEOutput_batch(203).Q(ocList)';
y4 = mEOutput_batch(204).Q(ocList)';
y5 = mEOutput_batch(205).Q(ocList)';
y6 = mEOutput_batch(206).Q(ocList)';
y7 = mEOutput_batch(207).Q(ocList)';
y8 = mEOutput_batch(208).Q(ocList)';
y9 = mEOutput_batch(209).Q(ocList)';
y10 = mEOutput_batch(210).Q(ocList)';

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'1', '3', '5', '7', '9', '11', '13', '15', '17', '19'})
title('Other Cells - Normal Imprecision | Rnd')
xlabel('Imprecision FWHM (frames)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QEvsImprecision_rnd', '-dpng')