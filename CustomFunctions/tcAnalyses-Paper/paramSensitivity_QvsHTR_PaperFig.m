%% Figures for paper - Kambadur Ananthamurthy - Q vs HTR
close all

% Generated Synthetic Data
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/synthDATA_batch_220.mat')

% Analysed Data
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200724_cRun1_cData.mat')

figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)

%% ORIGINAL METHOD
% Sequential Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(21).ptcList;
ocList = sdo_batch(21).ocList;

fig1 = figure(1);
set(fig1,'Position',[300,300,1000,1000])
subplot(2,2,1)
y1 = sdo_batch(21).Q(ptcList);
y2 = sdo_batch(22).Q(ptcList);
y3 = sdo_batch(23).Q(ptcList);
y4 = sdo_batch(24).Q(ptcList);
y5 = sdo_batch(25).Q(ptcList);
y6 = sdo_batch(26).Q(ptcList);
y7 = sdo_batch(27).Q(ptcList);
y8 = sdo_batch(28).Q(ptcList);
y9 = sdo_batch(29).Q(ptcList);
y10 = sdo_batch(30).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed HTR % | Seq')
xlabel('Hit Trial Ratio (%)')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = sdo_batch(21).Q(ocList);
y2 = sdo_batch(22).Q(ocList);
y3 = sdo_batch(23).Q(ocList);
y4 = sdo_batch(24).Q(ocList);
y5 = sdo_batch(25).Q(ocList);
y6 = sdo_batch(26).Q(ocList);
y7 = sdo_batch(27).Q(ocList);
y8 = sdo_batch(28).Q(ocList);
y9 = sdo_batch(29).Q(ocList);
y10 = sdo_batch(30).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed HTR % | Seq')
xlabel('Hit Trial Ratio (%)')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = sdo_batch(31).Q(ptcList);
y2 = sdo_batch(32).Q(ptcList);
y3 = sdo_batch(33).Q(ptcList);
y4 = sdo_batch(34).Q(ptcList);
y5 = sdo_batch(35).Q(ptcList);
y6 = sdo_batch(36).Q(ptcList);
y7 = sdo_batch(37).Q(ptcList);
y8 = sdo_batch(38).Q(ptcList);
y9 = sdo_batch(39).Q(ptcList);
y10 = sdo_batch(40).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Randomized HTR % | Seq')
xlabel('Max Hit Trial Ratio (%)')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = sdo_batch(31).Q(ocList);
y2 = sdo_batch(32).Q(ocList);
y3 = sdo_batch(33).Q(ocList);
y4 = sdo_batch(34).Q(ocList);
y5 = sdo_batch(35).Q(ocList);
y6 = sdo_batch(36).Q(ocList);
y7 = sdo_batch(37).Q(ocList);
y8 = sdo_batch(38).Q(ocList);
y9 = sdo_batch(39).Q(ocList);
y10 = sdo_batch(40).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Randomized HTR % | Seq')
xlabel('Max Hit Trial Ratio (%)')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QvsHTR_seq', '-dpng')

% Random Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(131).ptcList;
ocList = sdo_batch(131).ocList;

fig2 = figure(2);
set(fig2,'Position',[300,300,1000,1000])
subplot(2,2,1)
y1 = sdo_batch(131).Q(ptcList);
y2 = sdo_batch(132).Q(ptcList);
y3 = sdo_batch(133).Q(ptcList);
y4 = sdo_batch(134).Q(ptcList);
y5 = sdo_batch(135).Q(ptcList);
y6 = sdo_batch(136).Q(ptcList);
y7 = sdo_batch(137).Q(ptcList);
y8 = sdo_batch(138).Q(ptcList);
y9 = sdo_batch(139).Q(ptcList);
y10 = sdo_batch(140).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed HTR % | Rnd')
xlabel('Hit Trial Ratio (%)')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = sdo_batch(131).Q(ocList);
y2 = sdo_batch(132).Q(ocList);
y3 = sdo_batch(133).Q(ocList);
y4 = sdo_batch(134).Q(ocList);
y5 = sdo_batch(135).Q(ocList);
y6 = sdo_batch(136).Q(ocList);
y7 = sdo_batch(137).Q(ocList);
y8 = sdo_batch(138).Q(ocList);
y9 = sdo_batch(139).Q(ocList);
y10 = sdo_batch(140).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed HTR % | Rnd')
xlabel('Hit Trial Ratio (%)')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = sdo_batch(141).Q(ptcList);
y2 = sdo_batch(142).Q(ptcList);
y3 = sdo_batch(143).Q(ptcList);
y4 = sdo_batch(144).Q(ptcList);
y5 = sdo_batch(145).Q(ptcList);
y6 = sdo_batch(146).Q(ptcList);
y7 = sdo_batch(147).Q(ptcList);
y8 = sdo_batch(148).Q(ptcList);
y9 = sdo_batch(149).Q(ptcList);
y10 = sdo_batch(150).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Randomized HTR % | Rnd')
xlabel('Max Hit Trial Ratio (%)')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = sdo_batch(141).Q(ocList);
y2 = sdo_batch(142).Q(ocList);
y3 = sdo_batch(143).Q(ocList);
y4 = sdo_batch(144).Q(ocList);
y5 = sdo_batch(145).Q(ocList);
y6 = sdo_batch(146).Q(ocList);
y7 = sdo_batch(147).Q(ocList);
y8 = sdo_batch(148).Q(ocList);
y9 = sdo_batch(149).Q(ocList);
y10 = sdo_batch(150).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Randomized HTR % | Rnd')
xlabel('Max Hit Trial Ratio (%)')
ylabel('Q')
ylim([-0.5 1])
set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QvsHTR_rnd', '-dpng')

%% METHOD A
% Sequential Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(21).ptcList;
ocList = sdo_batch(21).ocList;

fig3 = figure(3);
set(fig3,'Position',[300,300,1000,1000])

subplot(2,2,1)
y1 = cData.methodA.mAOutput_batch(21).Q(ptcList);
y2 = cData.methodA.mAOutput_batch(22).Q(ptcList);
y3 = cData.methodA.mAOutput_batch(23).Q(ptcList);
y4 = cData.methodA.mAOutput_batch(24).Q(ptcList);
y5 = cData.methodA.mAOutput_batch(25).Q(ptcList);
y6 = cData.methodA.mAOutput_batch(26).Q(ptcList);
y7 = cData.methodA.mAOutput_batch(27).Q(ptcList);
y8 = cData.methodA.mAOutput_batch(28).Q(ptcList);
y9 = cData.methodA.mAOutput_batch(29).Q(ptcList);
y10 = cData.methodA.mAOutput_batch(30).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed HTR % | Seq')
xlabel('Hit Trial Ratio (%)')
ylabel('QA')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = cData.methodA.mAOutput_batch(21).Q(ocList);
y2 = cData.methodA.mAOutput_batch(22).Q(ocList);
y3 = cData.methodA.mAOutput_batch(23).Q(ocList);
y4 = cData.methodA.mAOutput_batch(24).Q(ocList);
y5 = cData.methodA.mAOutput_batch(25).Q(ocList);
y6 = cData.methodA.mAOutput_batch(26).Q(ocList);
y7 = cData.methodA.mAOutput_batch(27).Q(ocList);
y8 = cData.methodA.mAOutput_batch(28).Q(ocList);
y9 = cData.methodA.mAOutput_batch(29).Q(ocList);
y10 = cData.methodA.mAOutput_batch(30).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed HTR % | Seq')
xlabel('Hit Trial Ratio (%)')
ylabel('QA')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = cData.methodA.mAOutput_batch(31).Q(ptcList);
y2 = cData.methodA.mAOutput_batch(32).Q(ptcList);
y3 = cData.methodA.mAOutput_batch(33).Q(ptcList);
y4 = cData.methodA.mAOutput_batch(34).Q(ptcList);
y5 = cData.methodA.mAOutput_batch(35).Q(ptcList);
y6 = cData.methodA.mAOutput_batch(36).Q(ptcList);
y7 = cData.methodA.mAOutput_batch(37).Q(ptcList);
y8 = cData.methodA.mAOutput_batch(38).Q(ptcList);
y9 = cData.methodA.mAOutput_batch(39).Q(ptcList);
y10 = cData.methodA.mAOutput_batch(40).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Randomized HTR % | Seq')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QA')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = cData.methodA.mAOutput_batch(31).Q(ocList);
y2 = cData.methodA.mAOutput_batch(32).Q(ocList);
y3 = cData.methodA.mAOutput_batch(33).Q(ocList);
y4 = cData.methodA.mAOutput_batch(34).Q(ocList);
y5 = cData.methodA.mAOutput_batch(35).Q(ocList);
y6 = cData.methodA.mAOutput_batch(36).Q(ocList);
y7 = cData.methodA.mAOutput_batch(37).Q(ocList);
y8 = cData.methodA.mAOutput_batch(38).Q(ocList);
y9 = cData.methodA.mAOutput_batch(39).Q(ocList);
y10 = cData.methodA.mAOutput_batch(40).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Randomized HTR % | Seq')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QA')

set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QAvsHTR_seq', '-dpng')

% Random Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(131).ptcList;
ocList = sdo_batch(131).ocList;

fig4 = figure(4);
set(fig4,'Position',[300,300,1000,1000])
subplot(2,2,1)
y1 = cData.methodA.mAOutput_batch(131).Q(ptcList);
y2 = cData.methodA.mAOutput_batch(132).Q(ptcList);
y3 = cData.methodA.mAOutput_batch(133).Q(ptcList);
y4 = cData.methodA.mAOutput_batch(134).Q(ptcList);
y5 = cData.methodA.mAOutput_batch(135).Q(ptcList);
y6 = cData.methodA.mAOutput_batch(136).Q(ptcList);
y7 = cData.methodA.mAOutput_batch(137).Q(ptcList);
y8 = cData.methodA.mAOutput_batch(138).Q(ptcList);
y9 = cData.methodA.mAOutput_batch(139).Q(ptcList);
y10 = cData.methodA.mAOutput_batch(140).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed HTR % | Rnd')
xlabel('Hit Trial Ratio (%)')
ylabel('QA')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = cData.methodA.mAOutput_batch(131).Q(ocList);
y2 = cData.methodA.mAOutput_batch(132).Q(ocList);
y3 = cData.methodA.mAOutput_batch(133).Q(ocList);
y4 = cData.methodA.mAOutput_batch(134).Q(ocList);
y5 = cData.methodA.mAOutput_batch(135).Q(ocList);
y6 = cData.methodA.mAOutput_batch(136).Q(ocList);
y7 = cData.methodA.mAOutput_batch(137).Q(ocList);
y8 = cData.methodA.mAOutput_batch(138).Q(ocList);
y9 = cData.methodA.mAOutput_batch(139).Q(ocList);
y10 = cData.methodA.mAOutput_batch(140).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed HTR % | Rnd')
xlabel('Hit Trial Ratio (%)')
ylabel('QA')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = cData.methodA.mAOutput_batch(141).Q(ptcList);
y2 = cData.methodA.mAOutput_batch(142).Q(ptcList);
y3 = cData.methodA.mAOutput_batch(143).Q(ptcList);
y4 = cData.methodA.mAOutput_batch(144).Q(ptcList);
y5 = cData.methodA.mAOutput_batch(145).Q(ptcList);
y6 = cData.methodA.mAOutput_batch(146).Q(ptcList);
y7 = cData.methodA.mAOutput_batch(147).Q(ptcList);
y8 = cData.methodA.mAOutput_batch(148).Q(ptcList);
y9 = cData.methodA.mAOutput_batch(149).Q(ptcList);
y10 = cData.methodA.mAOutput_batch(150).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Randomized HTR % | Rnd')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QA')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = cData.methodA.mAOutput_batch(141).Q(ocList);
y2 = cData.methodA.mAOutput_batch(142).Q(ocList);
y3 = cData.methodA.mAOutput_batch(143).Q(ocList);
y4 = cData.methodA.mAOutput_batch(144).Q(ocList);
y5 = cData.methodA.mAOutput_batch(145).Q(ocList);
y6 = cData.methodA.mAOutput_batch(146).Q(ocList);
y7 = cData.methodA.mAOutput_batch(147).Q(ocList);
y8 = cData.methodA.mAOutput_batch(148).Q(ocList);
y9 = cData.methodA.mAOutput_batch(149).Q(ocList);
y10 = cData.methodA.mAOutput_batch(150).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Randomized HTR % | Rnd')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QA')

set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QAvsHTR_rnd', '-dpng')

%% METHOD B
% Sequential Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(21).ptcList;
ocList = sdo_batch(21).ocList;

fig5 = figure(5);
set(fig5,'Position',[300,300,1000,1000])

subplot(2,2,1)
y1 = cData.methodB.holyData.mBOutput_batch(21).Q(ptcList);
y2 = cData.methodB.holyData.mBOutput_batch(22).Q(ptcList);
y3 = cData.methodB.holyData.mBOutput_batch(23).Q(ptcList);
y4 = cData.methodB.holyData.mBOutput_batch(24).Q(ptcList);
y5 = cData.methodB.holyData.mBOutput_batch(25).Q(ptcList);
y6 = cData.methodB.holyData.mBOutput_batch(26).Q(ptcList);
y7 = cData.methodB.holyData.mBOutput_batch(27).Q(ptcList);
y8 = cData.methodB.holyData.mBOutput_batch(28).Q(ptcList);
y9 = cData.methodB.holyData.mBOutput_batch(29).Q(ptcList);
y10 = cData.methodB.holyData.mBOutput_batch(30).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed HTR % | Seq')
xlabel('Hit Trial Ratio (%)')
ylabel('QB')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = cData.methodB.holyData.mBOutput_batch(21).Q(ocList);
y2 = cData.methodB.holyData.mBOutput_batch(22).Q(ocList);
y3 = cData.methodB.holyData.mBOutput_batch(23).Q(ocList);
y4 = cData.methodB.holyData.mBOutput_batch(24).Q(ocList);
y5 = cData.methodB.holyData.mBOutput_batch(25).Q(ocList);
y6 = cData.methodB.holyData.mBOutput_batch(26).Q(ocList);
y7 = cData.methodB.holyData.mBOutput_batch(27).Q(ocList);
y8 = cData.methodB.holyData.mBOutput_batch(28).Q(ocList);
y9 = cData.methodB.holyData.mBOutput_batch(29).Q(ocList);
y10 = cData.methodB.holyData.mBOutput_batch(30).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed HTR % | Seq')
xlabel('Hit Trial Ratio (%)')
ylabel('QB')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = cData.methodB.holyData.mBOutput_batch(31).Q(ptcList);
y2 = cData.methodB.holyData.mBOutput_batch(32).Q(ptcList);
y3 = cData.methodB.holyData.mBOutput_batch(33).Q(ptcList);
y4 = cData.methodB.holyData.mBOutput_batch(34).Q(ptcList);
y5 = cData.methodB.holyData.mBOutput_batch(35).Q(ptcList);
y6 = cData.methodB.holyData.mBOutput_batch(36).Q(ptcList);
y7 = cData.methodB.holyData.mBOutput_batch(37).Q(ptcList);
y8 = cData.methodB.holyData.mBOutput_batch(38).Q(ptcList);
y9 = cData.methodB.holyData.mBOutput_batch(39).Q(ptcList);
y10 = cData.methodB.holyData.mBOutput_batch(40).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Randomized HTR % | Seq')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QB')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = cData.methodB.holyData.mBOutput_batch(31).Q(ocList);
y2 = cData.methodB.holyData.mBOutput_batch(32).Q(ocList);
y3 = cData.methodB.holyData.mBOutput_batch(33).Q(ocList);
y4 = cData.methodB.holyData.mBOutput_batch(34).Q(ocList);
y5 = cData.methodB.holyData.mBOutput_batch(35).Q(ocList);
y6 = cData.methodB.holyData.mBOutput_batch(36).Q(ocList);
y7 = cData.methodB.holyData.mBOutput_batch(37).Q(ocList);
y8 = cData.methodB.holyData.mBOutput_batch(38).Q(ocList);
y9 = cData.methodB.holyData.mBOutput_batch(39).Q(ocList);
y10 = cData.methodB.holyData.mBOutput_batch(40).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Randomized HTR % | Seq')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QB')

set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QBvsHTR_seq', '-dpng')

% Random Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(131).ptcList;
ocList = sdo_batch(131).ocList;

fig6 = figure(6);
set(fig6,'Position',[300,300,1000,1000])
subplot(2,2,1)
y1 = cData.methodB.holyData.mBOutput_batch(131).Q(ptcList);
y2 = cData.methodB.holyData.mBOutput_batch(132).Q(ptcList);
y3 = cData.methodB.holyData.mBOutput_batch(133).Q(ptcList);
y4 = cData.methodB.holyData.mBOutput_batch(134).Q(ptcList);
y5 = cData.methodB.holyData.mBOutput_batch(135).Q(ptcList);
y6 = cData.methodB.holyData.mBOutput_batch(136).Q(ptcList);
y7 = cData.methodB.holyData.mBOutput_batch(137).Q(ptcList);
y8 = cData.methodB.holyData.mBOutput_batch(138).Q(ptcList);
y9 = cData.methodB.holyData.mBOutput_batch(139).Q(ptcList);
y10 = cData.methodB.holyData.mBOutput_batch(140).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed HTR % | Rnd')
xlabel('Hit Trial Ratio (%)')
ylabel('QB')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = cData.methodB.holyData.mBOutput_batch(131).Q(ocList);
y2 = cData.methodB.holyData.mBOutput_batch(132).Q(ocList);
y3 = cData.methodB.holyData.mBOutput_batch(133).Q(ocList);
y4 = cData.methodB.holyData.mBOutput_batch(134).Q(ocList);
y5 = cData.methodB.holyData.mBOutput_batch(135).Q(ocList);
y6 = cData.methodB.holyData.mBOutput_batch(136).Q(ocList);
y7 = cData.methodB.holyData.mBOutput_batch(137).Q(ocList);
y8 = cData.methodB.holyData.mBOutput_batch(138).Q(ocList);
y9 = cData.methodB.holyData.mBOutput_batch(139).Q(ocList);
y10 = cData.methodB.holyData.mBOutput_batch(140).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed HTR % | Rnd')
xlabel('Hit Trial Ratio (%)')
ylabel('QB')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = cData.methodB.holyData.mBOutput_batch(141).Q(ptcList);
y2 = cData.methodB.holyData.mBOutput_batch(142).Q(ptcList);
y3 = cData.methodB.holyData.mBOutput_batch(143).Q(ptcList);
y4 = cData.methodB.holyData.mBOutput_batch(144).Q(ptcList);
y5 = cData.methodB.holyData.mBOutput_batch(145).Q(ptcList);
y6 = cData.methodB.holyData.mBOutput_batch(146).Q(ptcList);
y7 = cData.methodB.holyData.mBOutput_batch(147).Q(ptcList);
y8 = cData.methodB.holyData.mBOutput_batch(148).Q(ptcList);
y9 = cData.methodB.holyData.mBOutput_batch(149).Q(ptcList);
y10 = cData.methodB.holyData.mBOutput_batch(150).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Randomized HTR % | Rnd')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QB')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = cData.methodB.holyData.mBOutput_batch(141).Q(ocList);
y2 = cData.methodB.holyData.mBOutput_batch(142).Q(ocList);
y3 = cData.methodB.holyData.mBOutput_batch(143).Q(ocList);
y4 = cData.methodB.holyData.mBOutput_batch(144).Q(ocList);
y5 = cData.methodB.holyData.mBOutput_batch(145).Q(ocList);
y6 = cData.methodB.holyData.mBOutput_batch(146).Q(ocList);
y7 = cData.methodB.holyData.mBOutput_batch(147).Q(ocList);
y8 = cData.methodB.holyData.mBOutput_batch(148).Q(ocList);
y9 = cData.methodB.holyData.mBOutput_batch(149).Q(ocList);
y10 = cData.methodB.holyData.mBOutput_batch(150).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Randomized HTR % | Rnd')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QB')

set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QBvsHTR_rnd', '-dpng')

%% METHOD C
%C1
% Sequential Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(21).ptcList;
ocList = sdo_batch(21).ocList;

fig7 = figure(7);
set(fig7,'Position',[300,300,1000,1000])

subplot(2,2,1)
y1 = cData.methodC.mCOutput_batch(21).Q1(ptcList);
y2 = cData.methodC.mCOutput_batch(22).Q1(ptcList);
y3 = cData.methodC.mCOutput_batch(23).Q1(ptcList);
y4 = cData.methodC.mCOutput_batch(24).Q1(ptcList);
y5 = cData.methodC.mCOutput_batch(25).Q1(ptcList);
y6 = cData.methodC.mCOutput_batch(26).Q1(ptcList);
y7 = cData.methodC.mCOutput_batch(27).Q1(ptcList);
y8 = cData.methodC.mCOutput_batch(28).Q1(ptcList);
y9 = cData.methodC.mCOutput_batch(29).Q1(ptcList);
y10 = cData.methodC.mCOutput_batch(30).Q1(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed HTR % | Seq')
xlabel('Hit Trial Ratio (%)')
ylabel('QC1')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = cData.methodC.mCOutput_batch(21).Q1(ocList);
y2 = cData.methodC.mCOutput_batch(22).Q1(ocList);
y3 = cData.methodC.mCOutput_batch(23).Q1(ocList);
y4 = cData.methodC.mCOutput_batch(24).Q1(ocList);
y5 = cData.methodC.mCOutput_batch(25).Q1(ocList);
y6 = cData.methodC.mCOutput_batch(26).Q1(ocList);
y7 = cData.methodC.mCOutput_batch(27).Q1(ocList);
y8 = cData.methodC.mCOutput_batch(28).Q1(ocList);
y9 = cData.methodC.mCOutput_batch(29).Q1(ocList);
y10 = cData.methodC.mCOutput_batch(30).Q1(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed HTR % | Seq')
xlabel('Hit Trial Ratio (%)')
ylabel('QC1')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = cData.methodC.mCOutput_batch(31).Q1(ptcList);
y2 = cData.methodC.mCOutput_batch(32).Q1(ptcList);
y3 = cData.methodC.mCOutput_batch(33).Q1(ptcList);
y4 = cData.methodC.mCOutput_batch(34).Q1(ptcList);
y5 = cData.methodC.mCOutput_batch(35).Q1(ptcList);
y6 = cData.methodC.mCOutput_batch(36).Q1(ptcList);
y7 = cData.methodC.mCOutput_batch(37).Q1(ptcList);
y8 = cData.methodC.mCOutput_batch(38).Q1(ptcList);
y9 = cData.methodC.mCOutput_batch(39).Q1(ptcList);
y10 = cData.methodC.mCOutput_batch(40).Q1(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Randomized HTR % | Seq')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QC1')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = cData.methodC.mCOutput_batch(31).Q1(ocList);
y2 = cData.methodC.mCOutput_batch(32).Q1(ocList);
y3 = cData.methodC.mCOutput_batch(33).Q1(ocList);
y4 = cData.methodC.mCOutput_batch(34).Q1(ocList);
y5 = cData.methodC.mCOutput_batch(35).Q1(ocList);
y6 = cData.methodC.mCOutput_batch(36).Q1(ocList);
y7 = cData.methodC.mCOutput_batch(37).Q1(ocList);
y8 = cData.methodC.mCOutput_batch(38).Q1(ocList);
y9 = cData.methodC.mCOutput_batch(39).Q1(ocList);
y10 = cData.methodC.mCOutput_batch(40).Q1(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Randomized HTR % | Seq')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QC1')

set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC1vsHTR_seq', '-dpng')

% Random Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(131).ptcList;
ocList = sdo_batch(131).ocList;

fig8 = figure(8);
set(fig8,'Position',[300,300,1000,1000])
subplot(2,2,1)
y1 = cData.methodC.mCOutput_batch(131).Q1(ptcList);
y2 = cData.methodC.mCOutput_batch(132).Q1(ptcList);
y3 = cData.methodC.mCOutput_batch(133).Q1(ptcList);
y4 = cData.methodC.mCOutput_batch(134).Q1(ptcList);
y5 = cData.methodC.mCOutput_batch(135).Q1(ptcList);
y6 = cData.methodC.mCOutput_batch(136).Q1(ptcList);
y7 = cData.methodC.mCOutput_batch(137).Q1(ptcList);
y8 = cData.methodC.mCOutput_batch(138).Q1(ptcList);
y9 = cData.methodC.mCOutput_batch(139).Q1(ptcList);
y10 = cData.methodC.mCOutput_batch(140).Q1(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed HTR % | Rnd')
xlabel('Hit Trial Ratio (%)')
ylabel('QC1')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = cData.methodC.mCOutput_batch(131).Q1(ocList);
y2 = cData.methodC.mCOutput_batch(132).Q1(ocList);
y3 = cData.methodC.mCOutput_batch(133).Q1(ocList);
y4 = cData.methodC.mCOutput_batch(134).Q1(ocList);
y5 = cData.methodC.mCOutput_batch(135).Q1(ocList);
y6 = cData.methodC.mCOutput_batch(136).Q1(ocList);
y7 = cData.methodC.mCOutput_batch(137).Q1(ocList);
y8 = cData.methodC.mCOutput_batch(138).Q1(ocList);
y9 = cData.methodC.mCOutput_batch(139).Q1(ocList);
y10 = cData.methodC.mCOutput_batch(140).Q1(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed HTR % | Rnd')
xlabel('Hit Trial Ratio (%)')
ylabel('QC1')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = cData.methodC.mCOutput_batch(141).Q1(ptcList);
y2 = cData.methodC.mCOutput_batch(142).Q1(ptcList);
y3 = cData.methodC.mCOutput_batch(143).Q1(ptcList);
y4 = cData.methodC.mCOutput_batch(144).Q1(ptcList);
y5 = cData.methodC.mCOutput_batch(145).Q1(ptcList);
y6 = cData.methodC.mCOutput_batch(146).Q1(ptcList);
y7 = cData.methodC.mCOutput_batch(147).Q1(ptcList);
y8 = cData.methodC.mCOutput_batch(148).Q1(ptcList);
y9 = cData.methodC.mCOutput_batch(149).Q1(ptcList);
y10 = cData.methodC.mCOutput_batch(150).Q1(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Randomized HTR % | Rnd')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QC1')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = cData.methodC.mCOutput_batch(141).Q1(ocList);
y2 = cData.methodC.mCOutput_batch(142).Q1(ocList);
y3 = cData.methodC.mCOutput_batch(143).Q1(ocList);
y4 = cData.methodC.mCOutput_batch(144).Q1(ocList);
y5 = cData.methodC.mCOutput_batch(145).Q1(ocList);
y6 = cData.methodC.mCOutput_batch(146).Q1(ocList);
y7 = cData.methodC.mCOutput_batch(147).Q1(ocList);
y8 = cData.methodC.mCOutput_batch(148).Q1(ocList);
y9 = cData.methodC.mCOutput_batch(149).Q1(ocList);
y10 = cData.methodC.mCOutput_batch(150).Q1(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Randomized HTR % | Rnd')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QC1')

set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC1vsHTR_rnd', '-dpng')

%C2
% Sequential Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(21).ptcList;
ocList = sdo_batch(21).ocList;

fig9 = figure(9);
set(fig9,'Position',[300,300,1000,1000])

subplot(2,2,1)
y1 = cData.methodC.mCOutput_batch(21).Q2(ptcList);
y2 = cData.methodC.mCOutput_batch(22).Q2(ptcList);
y3 = cData.methodC.mCOutput_batch(23).Q2(ptcList);
y4 = cData.methodC.mCOutput_batch(24).Q2(ptcList);
y5 = cData.methodC.mCOutput_batch(25).Q2(ptcList);
y6 = cData.methodC.mCOutput_batch(26).Q2(ptcList);
y7 = cData.methodC.mCOutput_batch(27).Q2(ptcList);
y8 = cData.methodC.mCOutput_batch(28).Q2(ptcList);
y9 = cData.methodC.mCOutput_batch(29).Q2(ptcList);
y10 = cData.methodC.mCOutput_batch(30).Q2(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed HTR % | Seq')
xlabel('Hit Trial Ratio (%)')
ylabel('QC2')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = cData.methodC.mCOutput_batch(21).Q2(ocList);
y2 = cData.methodC.mCOutput_batch(22).Q2(ocList);
y3 = cData.methodC.mCOutput_batch(23).Q2(ocList);
y4 = cData.methodC.mCOutput_batch(24).Q2(ocList);
y5 = cData.methodC.mCOutput_batch(25).Q2(ocList);
y6 = cData.methodC.mCOutput_batch(26).Q2(ocList);
y7 = cData.methodC.mCOutput_batch(27).Q2(ocList);
y8 = cData.methodC.mCOutput_batch(28).Q2(ocList);
y9 = cData.methodC.mCOutput_batch(29).Q2(ocList);
y10 = cData.methodC.mCOutput_batch(30).Q2(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed HTR % | Seq')
xlabel('Hit Trial Ratio (%)')
ylabel('QC2')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = cData.methodC.mCOutput_batch(31).Q2(ptcList);
y2 = cData.methodC.mCOutput_batch(32).Q2(ptcList);
y3 = cData.methodC.mCOutput_batch(33).Q2(ptcList);
y4 = cData.methodC.mCOutput_batch(34).Q2(ptcList);
y5 = cData.methodC.mCOutput_batch(35).Q2(ptcList);
y6 = cData.methodC.mCOutput_batch(36).Q2(ptcList);
y7 = cData.methodC.mCOutput_batch(37).Q2(ptcList);
y8 = cData.methodC.mCOutput_batch(38).Q2(ptcList);
y9 = cData.methodC.mCOutput_batch(39).Q2(ptcList);
y10 = cData.methodC.mCOutput_batch(40).Q2(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Randomized HTR % | Seq')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QC2')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = cData.methodC.mCOutput_batch(31).Q2(ocList);
y2 = cData.methodC.mCOutput_batch(32).Q2(ocList);
y3 = cData.methodC.mCOutput_batch(33).Q2(ocList);
y4 = cData.methodC.mCOutput_batch(34).Q2(ocList);
y5 = cData.methodC.mCOutput_batch(35).Q2(ocList);
y6 = cData.methodC.mCOutput_batch(36).Q2(ocList);
y7 = cData.methodC.mCOutput_batch(37).Q2(ocList);
y8 = cData.methodC.mCOutput_batch(38).Q2(ocList);
y9 = cData.methodC.mCOutput_batch(39).Q2(ocList);
y10 = cData.methodC.mCOutput_batch(40).Q2(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Randomized HTR % | Seq')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QC2')

set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC2vsHTR_seq', '-dpng')

% Random Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(131).ptcList;
ocList = sdo_batch(131).ocList;

fig10 = figure(10);
set(fig10,'Position',[300,300,1000,1000])
subplot(2,2,1)
y1 = cData.methodC.mCOutput_batch(131).Q2(ptcList);
y2 = cData.methodC.mCOutput_batch(132).Q2(ptcList);
y3 = cData.methodC.mCOutput_batch(133).Q2(ptcList);
y4 = cData.methodC.mCOutput_batch(134).Q2(ptcList);
y5 = cData.methodC.mCOutput_batch(135).Q2(ptcList);
y6 = cData.methodC.mCOutput_batch(136).Q2(ptcList);
y7 = cData.methodC.mCOutput_batch(137).Q2(ptcList);
y8 = cData.methodC.mCOutput_batch(138).Q2(ptcList);
y9 = cData.methodC.mCOutput_batch(139).Q2(ptcList);
y10 = cData.methodC.mCOutput_batch(140).Q2(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed HTR % | Rnd')
xlabel('Hit Trial Ratio (%)')
ylabel('QC2')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = cData.methodC.mCOutput_batch(131).Q2(ocList);
y2 = cData.methodC.mCOutput_batch(132).Q2(ocList);
y3 = cData.methodC.mCOutput_batch(133).Q2(ocList);
y4 = cData.methodC.mCOutput_batch(134).Q2(ocList);
y5 = cData.methodC.mCOutput_batch(135).Q2(ocList);
y6 = cData.methodC.mCOutput_batch(136).Q2(ocList);
y7 = cData.methodC.mCOutput_batch(137).Q2(ocList);
y8 = cData.methodC.mCOutput_batch(138).Q2(ocList);
y9 = cData.methodC.mCOutput_batch(139).Q2(ocList);
y10 = cData.methodC.mCOutput_batch(140).Q2(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed HTR % | Rnd')
xlabel('Hit Trial Ratio (%)')
ylabel('QC2')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = cData.methodC.mCOutput_batch(141).Q2(ptcList);
y2 = cData.methodC.mCOutput_batch(142).Q2(ptcList);
y3 = cData.methodC.mCOutput_batch(143).Q2(ptcList);
y4 = cData.methodC.mCOutput_batch(144).Q2(ptcList);
y5 = cData.methodC.mCOutput_batch(145).Q2(ptcList);
y6 = cData.methodC.mCOutput_batch(146).Q2(ptcList);
y7 = cData.methodC.mCOutput_batch(147).Q2(ptcList);
y8 = cData.methodC.mCOutput_batch(148).Q2(ptcList);
y9 = cData.methodC.mCOutput_batch(149).Q2(ptcList);
y10 = cData.methodC.mCOutput_batch(150).Q2(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Randomized HTR % | Rnd')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QC2')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = cData.methodC.mCOutput_batch(141).Q2(ocList);
y2 = cData.methodC.mCOutput_batch(142).Q2(ocList);
y3 = cData.methodC.mCOutput_batch(143).Q2(ocList);
y4 = cData.methodC.mCOutput_batch(144).Q2(ocList);
y5 = cData.methodC.mCOutput_batch(145).Q2(ocList);
y6 = cData.methodC.mCOutput_batch(146).Q2(ocList);
y7 = cData.methodC.mCOutput_batch(147).Q2(ocList);
y8 = cData.methodC.mCOutput_batch(148).Q2(ocList);
y9 = cData.methodC.mCOutput_batch(149).Q2(ocList);
y10 = cData.methodC.mCOutput_batch(150).Q2(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Randomized HTR % | Rnd')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QC2')

set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QC2vsHTR_rnd', '-dpng')

%% METHOD D
% Sequential Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(21).ptcList;
ocList = sdo_batch(21).ocList;

fig11 = figure(11);
set(fig11,'Position',[300,300,1000,1000])

subplot(2,2,1)
y1 = cData.methodD.mDOutput_batch(21).Q(ptcList);
y2 = cData.methodD.mDOutput_batch(22).Q(ptcList);
y3 = cData.methodD.mDOutput_batch(23).Q(ptcList);
y4 = cData.methodD.mDOutput_batch(24).Q(ptcList);
y5 = cData.methodD.mDOutput_batch(25).Q(ptcList);
y6 = cData.methodD.mDOutput_batch(26).Q(ptcList);
y7 = cData.methodD.mDOutput_batch(27).Q(ptcList);
y8 = cData.methodD.mDOutput_batch(28).Q(ptcList);
y9 = cData.methodD.mDOutput_batch(29).Q(ptcList);
y10 = cData.methodD.mDOutput_batch(30).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed HTR % | Seq')
xlabel('Hit Trial Ratio (%)')
ylabel('QD')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = cData.methodD.mDOutput_batch(21).Q(ocList);
y2 = cData.methodD.mDOutput_batch(22).Q(ocList);
y3 = cData.methodD.mDOutput_batch(23).Q(ocList);
y4 = cData.methodD.mDOutput_batch(24).Q(ocList);
y5 = cData.methodD.mDOutput_batch(25).Q(ocList);
y6 = cData.methodD.mDOutput_batch(26).Q(ocList);
y7 = cData.methodD.mDOutput_batch(27).Q(ocList);
y8 = cData.methodD.mDOutput_batch(28).Q(ocList);
y9 = cData.methodD.mDOutput_batch(29).Q(ocList);
y10 = cData.methodD.mDOutput_batch(30).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed HTR % | Seq')
xlabel('Hit Trial Ratio (%)')
ylabel('QD')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = cData.methodD.mDOutput_batch(31).Q(ptcList);
y2 = cData.methodD.mDOutput_batch(32).Q(ptcList);
y3 = cData.methodD.mDOutput_batch(33).Q(ptcList);
y4 = cData.methodD.mDOutput_batch(34).Q(ptcList);
y5 = cData.methodD.mDOutput_batch(35).Q(ptcList);
y6 = cData.methodD.mDOutput_batch(36).Q(ptcList);
y7 = cData.methodD.mDOutput_batch(37).Q(ptcList);
y8 = cData.methodD.mDOutput_batch(38).Q(ptcList);
y9 = cData.methodD.mDOutput_batch(39).Q(ptcList);
y10 = cData.methodD.mDOutput_batch(40).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Randomized HTR % | Seq')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QD')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = cData.methodD.mDOutput_batch(31).Q(ocList);
y2 = cData.methodD.mDOutput_batch(32).Q(ocList);
y3 = cData.methodD.mDOutput_batch(33).Q(ocList);
y4 = cData.methodD.mDOutput_batch(34).Q(ocList);
y5 = cData.methodD.mDOutput_batch(35).Q(ocList);
y6 = cData.methodD.mDOutput_batch(36).Q(ocList);
y7 = cData.methodD.mDOutput_batch(37).Q(ocList);
y8 = cData.methodD.mDOutput_batch(38).Q(ocList);
y9 = cData.methodD.mDOutput_batch(39).Q(ocList);
y10 = cData.methodD.mDOutput_batch(40).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Randomized HTR % | Seq')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QD')

set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QDvsHTR_seq', '-dpng')

% Random Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(131).ptcList;
ocList = sdo_batch(131).ocList;

fig12 = figure(12);
set(fig12,'Position',[300,300,1000,1000])
subplot(2,2,1)
y1 = cData.methodD.mDOutput_batch(131).Q(ptcList);
y2 = cData.methodD.mDOutput_batch(132).Q(ptcList);
y3 = cData.methodD.mDOutput_batch(133).Q(ptcList);
y4 = cData.methodD.mDOutput_batch(134).Q(ptcList);
y5 = cData.methodD.mDOutput_batch(135).Q(ptcList);
y6 = cData.methodD.mDOutput_batch(136).Q(ptcList);
y7 = cData.methodD.mDOutput_batch(137).Q(ptcList);
y8 = cData.methodD.mDOutput_batch(138).Q(ptcList);
y9 = cData.methodD.mDOutput_batch(139).Q(ptcList);
y10 = cData.methodD.mDOutput_batch(140).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed HTR % | Rnd')
xlabel('Hit Trial Ratio (%)')
ylabel('QD')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = cData.methodD.mDOutput_batch(131).Q(ocList);
y2 = cData.methodD.mDOutput_batch(132).Q(ocList);
y3 = cData.methodD.mDOutput_batch(133).Q(ocList);
y4 = cData.methodD.mDOutput_batch(134).Q(ocList);
y5 = cData.methodD.mDOutput_batch(135).Q(ocList);
y6 = cData.methodD.mDOutput_batch(136).Q(ocList);
y7 = cData.methodD.mDOutput_batch(137).Q(ocList);
y8 = cData.methodD.mDOutput_batch(138).Q(ocList);
y9 = cData.methodD.mDOutput_batch(139).Q(ocList);
y10 = cData.methodD.mDOutput_batch(140).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed HTR % | Rnd')
xlabel('Hit Trial Ratio (%)')
ylabel('QD')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = cData.methodD.mDOutput_batch(141).Q(ptcList);
y2 = cData.methodD.mDOutput_batch(142).Q(ptcList);
y3 = cData.methodD.mDOutput_batch(143).Q(ptcList);
y4 = cData.methodD.mDOutput_batch(144).Q(ptcList);
y5 = cData.methodD.mDOutput_batch(145).Q(ptcList);
y6 = cData.methodD.mDOutput_batch(146).Q(ptcList);
y7 = cData.methodD.mDOutput_batch(147).Q(ptcList);
y8 = cData.methodD.mDOutput_batch(148).Q(ptcList);
y9 = cData.methodD.mDOutput_batch(149).Q(ptcList);
y10 = cData.methodD.mDOutput_batch(150).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Randomized HTR % | Rnd')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QD')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = cData.methodD.mDOutput_batch(141).Q(ocList);
y2 = cData.methodD.mDOutput_batch(142).Q(ocList);
y3 = cData.methodD.mDOutput_batch(143).Q(ocList);
y4 = cData.methodD.mDOutput_batch(144).Q(ocList);
y5 = cData.methodD.mDOutput_batch(145).Q(ocList);
y6 = cData.methodD.mDOutput_batch(146).Q(ocList);
y7 = cData.methodD.mDOutput_batch(147).Q(ocList);
y8 = cData.methodD.mDOutput_batch(148).Q(ocList);
y9 = cData.methodD.mDOutput_batch(149).Q(ocList);
y10 = cData.methodD.mDOutput_batch(150).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Randomized HTR % | Rnd')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QD')

set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QDvsHTR_rnd', '-dpng')

%% METHOD E
% Sequential Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(21).ptcList;
ocList = sdo_batch(21).ocList;

fig13 = figure(13);
set(fig13,'Position',[300,300,1000,1000])

subplot(2,2,1)
y1 = cData.methodE.holyData.mEOutput_batch(21).Q(ptcList);
y2 = cData.methodE.holyData.mEOutput_batch(22).Q(ptcList);
y3 = cData.methodE.holyData.mEOutput_batch(23).Q(ptcList);
y4 = cData.methodE.holyData.mEOutput_batch(24).Q(ptcList);
y5 = cData.methodE.holyData.mEOutput_batch(25).Q(ptcList);
y6 = cData.methodE.holyData.mEOutput_batch(26).Q(ptcList);
y7 = cData.methodE.holyData.mEOutput_batch(27).Q(ptcList);
y8 = cData.methodE.holyData.mEOutput_batch(28).Q(ptcList);
y9 = cData.methodE.holyData.mEOutput_batch(29).Q(ptcList);
y10 = cData.methodE.holyData.mEOutput_batch(30).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed HTR % | Seq')
xlabel('Hit Trial Ratio (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = cData.methodE.holyData.mEOutput_batch(21).Q(ocList);
y2 = cData.methodE.holyData.mEOutput_batch(22).Q(ocList);
y3 = cData.methodE.holyData.mEOutput_batch(23).Q(ocList);
y4 = cData.methodE.holyData.mEOutput_batch(24).Q(ocList);
y5 = cData.methodE.holyData.mEOutput_batch(25).Q(ocList);
y6 = cData.methodE.holyData.mEOutput_batch(26).Q(ocList);
y7 = cData.methodE.holyData.mEOutput_batch(27).Q(ocList);
y8 = cData.methodE.holyData.mEOutput_batch(28).Q(ocList);
y9 = cData.methodE.holyData.mEOutput_batch(29).Q(ocList);
y10 = cData.methodE.holyData.mEOutput_batch(30).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed HTR % | Seq')
xlabel('Hit Trial Ratio (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = cData.methodE.holyData.mEOutput_batch(31).Q(ptcList);
y2 = cData.methodE.holyData.mEOutput_batch(32).Q(ptcList);
y3 = cData.methodE.holyData.mEOutput_batch(33).Q(ptcList);
y4 = cData.methodE.holyData.mEOutput_batch(34).Q(ptcList);
y5 = cData.methodE.holyData.mEOutput_batch(35).Q(ptcList);
y6 = cData.methodE.holyData.mEOutput_batch(36).Q(ptcList);
y7 = cData.methodE.holyData.mEOutput_batch(37).Q(ptcList);
y8 = cData.methodE.holyData.mEOutput_batch(38).Q(ptcList);
y9 = cData.methodE.holyData.mEOutput_batch(39).Q(ptcList);
y10 = cData.methodE.holyData.mEOutput_batch(40).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Randomized HTR % | Seq')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = cData.methodE.holyData.mEOutput_batch(31).Q(ocList);
y2 = cData.methodE.holyData.mEOutput_batch(32).Q(ocList);
y3 = cData.methodE.holyData.mEOutput_batch(33).Q(ocList);
y4 = cData.methodE.holyData.mEOutput_batch(34).Q(ocList);
y5 = cData.methodE.holyData.mEOutput_batch(35).Q(ocList);
y6 = cData.methodE.holyData.mEOutput_batch(36).Q(ocList);
y7 = cData.methodE.holyData.mEOutput_batch(37).Q(ocList);
y8 = cData.methodE.holyData.mEOutput_batch(38).Q(ocList);
y9 = cData.methodE.holyData.mEOutput_batch(39).Q(ocList);
y10 = cData.methodE.holyData.mEOutput_batch(40).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Randomized HTR % | Seq')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QEvsHTR_seq', '-dpng')

% Random Timing
% Parameter Sensitivity - Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(131).ptcList;
ocList = sdo_batch(131).ocList;

fig14 = figure(14);
set(fig14,'Position',[300,300,1000,1000])
subplot(2,2,1)
y1 = cData.methodE.holyData.mEOutput_batch(131).Q(ptcList);
y2 = cData.methodE.holyData.mEOutput_batch(132).Q(ptcList);
y3 = cData.methodE.holyData.mEOutput_batch(133).Q(ptcList);
y4 = cData.methodE.holyData.mEOutput_batch(134).Q(ptcList);
y5 = cData.methodE.holyData.mEOutput_batch(135).Q(ptcList);
y6 = cData.methodE.holyData.mEOutput_batch(136).Q(ptcList);
y7 = cData.methodE.holyData.mEOutput_batch(137).Q(ptcList);
y8 = cData.methodE.holyData.mEOutput_batch(138).Q(ptcList);
y9 = cData.methodE.holyData.mEOutput_batch(139).Q(ptcList);
y10 = cData.methodE.holyData.mEOutput_batch(140).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Fixed HTR % | Rnd')
xlabel('Hit Trial Ratio (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,2)
y1 = cData.methodE.holyData.mEOutput_batch(131).Q(ocList);
y2 = cData.methodE.holyData.mEOutput_batch(132).Q(ocList);
y3 = cData.methodE.holyData.mEOutput_batch(133).Q(ocList);
y4 = cData.methodE.holyData.mEOutput_batch(134).Q(ocList);
y5 = cData.methodE.holyData.mEOutput_batch(135).Q(ocList);
y6 = cData.methodE.holyData.mEOutput_batch(136).Q(ocList);
y7 = cData.methodE.holyData.mEOutput_batch(137).Q(ocList);
y8 = cData.methodE.holyData.mEOutput_batch(138).Q(ocList);
y9 = cData.methodE.holyData.mEOutput_batch(139).Q(ocList);
y10 = cData.methodE.holyData.mEOutput_batch(140).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Fixed HTR % | Rnd')
xlabel('Hit Trial Ratio (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,3)
y1 = cData.methodE.holyData.mEOutput_batch(141).Q(ptcList);
y2 = cData.methodE.holyData.mEOutput_batch(142).Q(ptcList);
y3 = cData.methodE.holyData.mEOutput_batch(143).Q(ptcList);
y4 = cData.methodE.holyData.mEOutput_batch(144).Q(ptcList);
y5 = cData.methodE.holyData.mEOutput_batch(145).Q(ptcList);
y6 = cData.methodE.holyData.mEOutput_batch(146).Q(ptcList);
y7 = cData.methodE.holyData.mEOutput_batch(147).Q(ptcList);
y8 = cData.methodE.holyData.mEOutput_batch(148).Q(ptcList);
y9 = cData.methodE.holyData.mEOutput_batch(149).Q(ptcList);
y10 = cData.methodE.holyData.mEOutput_batch(150).Q(ptcList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Putative Time Cells - Randomized HTR % | Rnd')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

subplot(2,2,4)
y1 = cData.methodE.holyData.mEOutput_batch(141).Q(ocList);
y2 = cData.methodE.holyData.mEOutput_batch(142).Q(ocList);
y3 = cData.methodE.holyData.mEOutput_batch(143).Q(ocList);
y4 = cData.methodE.holyData.mEOutput_batch(144).Q(ocList);
y5 = cData.methodE.holyData.mEOutput_batch(145).Q(ocList);
y6 = cData.methodE.holyData.mEOutput_batch(146).Q(ocList);
y7 = cData.methodE.holyData.mEOutput_batch(147).Q(ocList);
y8 = cData.methodE.holyData.mEOutput_batch(148).Q(ocList);
y9 = cData.methodE.holyData.mEOutput_batch(149).Q(ocList);
y10 = cData.methodE.holyData.mEOutput_batch(150).Q(ocList);

boxplot([y1, y2, y3, y4, y5, y6, y7, y8, y9, y10], ...
    'Notch','on', ...
    'Labels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
title('Other Cells - Randomized HTR % | Rnd')
xlabel('Max Hit Trial Ratio (%)')
ylabel('QE')

set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QEvsHTR_rnd', '-dpng')