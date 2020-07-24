%% Figures for paper - Kambadur Ananthamurthy
close all

% Generated Synthetic Data
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/synthDATA_batch_220.mat')

% Analysed Data
%load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200615_cRun4_cData.mat')

figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)

%% Parameter Sensitivity
% Q vs Hit Trial Ratio - fixed hit trial ratio assignemnt


%Since the ptcList does not change over the course of this
ptcList = sdo_batch(21).ptcList;
ocList = sdo_batch(21).ocList;

fig1 = figure(1);
set(fig1,'Position',[300,300,1000,500])
x = sdo_batch(21).hitTrialPercent(ptcList);
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
title('Q vs Hit Trial Ratio - Fixed')
xlabel('Hit Trial Ratio (%)')
ylabel('Q (all putative time cells)')
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
title('Q vs Hit Trial Ratio - Fixed')
xlabel('Hit Trial Ratio (%)')
ylabel('Q (all other cells)')
set(gca, 'FontSize', figureDetails.fontSize-2)

x = sdo_batch(31).hitTrialPercent(ptcList);
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
title('Q vs Hit Trial Ratio - Random')
xlabel('Max Hit Trial Ratio (%)')
ylabel('Q (all putative time cells)')
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
title('Q vs Hit Trial Ratio')
xlabel('Max Hit Trial Ratio (%)')
ylabel('Q (all other cells)')
set(gca, 'FontSize', figureDetails.fontSize-2)

print('/Users/ananth/Desktop/figs/tcAnalysisPaper/QvsHTR', '-dpng')