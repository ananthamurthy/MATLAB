close all

% Generated Synthetic Data
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/synthDATA_batch_220.mat')

% Analysed Data
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200615_cRun4_cData.mat')
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200729_gRun2_methodE_batch_1-220.mat')

figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)

% % Replace with location of the downloaded folder
% pth = '/Users/ananth/Documents/MATLAB/CustomFunctions/kakearney-boxplot2-pkg-43f3144/boxplot2-pkg/boxplot2';

%addpath(fullfile(pth, 'boxplot2'))
%addpath(fullfile(pth, 'minmax'))

% ORIGINAL METHOD
% Sequential Timing
% Parameter Sensitivity - Q vs Max Percent Noise

%Since the ptcList does not change over the course of this
ptcList = sdo_batch(61).ptcList;
ocList = sdo_batch(61).ocList;

lp = length(ptcList);
lo = length(ocList);

fig1 = figure(1);
set(fig1,'Position',[300,300,1000,500])
%subplot(1,2,1)
%ngroups = 10; %different x axis conditions
%nboxes = 7; %different methods
%y=(ngroups, nboxes, npoints)

%ORIGINAL METHOD
y(1, 1, :) = sdo_batch(61).Q(ptcList);
y(2, 1, :) = sdo_batch(62).Q(ptcList);
y(3, 1, :) = sdo_batch(63).Q(ptcList);
y(4, 1, :) = sdo_batch(64).Q(ptcList);
y(5, 1, :) = sdo_batch(65).Q(ptcList);
y(6, 1, :) = sdo_batch(66).Q(ptcList);
y(7, 1, :) = sdo_batch(67).Q(ptcList);
y(7, 1, :) = sdo_batch(68).Q(ptcList);
y(9, 1, :) = sdo_batch(69).Q(ptcList);
y(10, 1, :) = sdo_batch(70).Q(ptcList);

%METHOD A
y(1, 2, :) = cData.methodA.mAOutput_batch(61).Q(ptcList)/max(cData.methodA.mAOutput_batch(61).Q(ptcList));
y(2, 2, :) = cData.methodA.mAOutput_batch(62).Q(ptcList)/max(cData.methodA.mAOutput_batch(62).Q(ptcList));
y(3, 2, :) = cData.methodA.mAOutput_batch(63).Q(ptcList)/max(cData.methodA.mAOutput_batch(63).Q(ptcList));
y(4, 2, :) = cData.methodA.mAOutput_batch(64).Q(ptcList)/max(cData.methodA.mAOutput_batch(64).Q(ptcList));
y(5, 2, :) = cData.methodA.mAOutput_batch(65).Q(ptcList)/max(cData.methodA.mAOutput_batch(65).Q(ptcList));
y(6, 2, :) = cData.methodA.mAOutput_batch(66).Q(ptcList)/max(cData.methodA.mAOutput_batch(66).Q(ptcList));
y(7, 2, :) = cData.methodA.mAOutput_batch(67).Q(ptcList)/max(cData.methodA.mAOutput_batch(67).Q(ptcList));
y(8, 2, :) = cData.methodA.mAOutput_batch(68).Q(ptcList)/max(cData.methodA.mAOutput_batch(68).Q(ptcList));
y(9, 2, :) = cData.methodA.mAOutput_batch(69).Q(ptcList)/max(cData.methodA.mAOutput_batch(69).Q(ptcList));
y(10, 2, :) = cData.methodA.mAOutput_batch(70).Q(ptcList)/max(cData.methodA.mAOutput_batch(70).Q(ptcList));


%METHOD B
y(1, 3, :) = cData.methodB.holyData.mBOutput_batch(61).Q(ptcList)/max(cData.methodB.holyData.mBOutput_batch(61).Q(ptcList));
y(2, 3, :) = cData.methodB.holyData.mBOutput_batch(62).Q(ptcList)/max(cData.methodB.holyData.mBOutput_batch(62).Q(ptcList));
y(3, 3, :) = cData.methodB.holyData.mBOutput_batch(63).Q(ptcList)/max(cData.methodB.holyData.mBOutput_batch(63).Q(ptcList));
y(4, 3, :) = cData.methodB.holyData.mBOutput_batch(64).Q(ptcList)/max(cData.methodB.holyData.mBOutput_batch(64).Q(ptcList));
y(5, 3, :) = cData.methodB.holyData.mBOutput_batch(65).Q(ptcList)/max(cData.methodB.holyData.mBOutput_batch(65).Q(ptcList));
y(6, 3, :) = cData.methodB.holyData.mBOutput_batch(66).Q(ptcList)/max(cData.methodB.holyData.mBOutput_batch(66).Q(ptcList));
y(7, 3, :) = cData.methodB.holyData.mBOutput_batch(67).Q(ptcList)/max(cData.methodB.holyData.mBOutput_batch(67).Q(ptcList));
y(8, 3, :) = cData.methodB.holyData.mBOutput_batch(68).Q(ptcList)/max(cData.methodB.holyData.mBOutput_batch(68).Q(ptcList));
y(9, 3, :) = cData.methodB.holyData.mBOutput_batch(69).Q(ptcList)/max(cData.methodB.holyData.mBOutput_batch(69).Q(ptcList));
y(10, 3, :) = cData.methodB.holyData.mBOutput_batch(70).Q(ptcList)/max(cData.methodB.holyData.mBOutput_batch(70).Q(ptcList));

%METHOD C1
y(1, 4, :) = cData.methodC.mCOutput_batch(61).Q1(ptcList)/max(cData.methodC.mCOutput_batch(61).Q1(ptcList));
y(2, 4, :) = cData.methodC.mCOutput_batch(62).Q1(ptcList)/max(cData.methodC.mCOutput_batch(62).Q1(ptcList));
y(3, 4, :) = cData.methodC.mCOutput_batch(63).Q1(ptcList)/max(cData.methodC.mCOutput_batch(63).Q1(ptcList));
y(4, 4, :) = cData.methodC.mCOutput_batch(64).Q1(ptcList)/max(cData.methodC.mCOutput_batch(64).Q1(ptcList));
y(5, 4, :) = cData.methodC.mCOutput_batch(65).Q1(ptcList)/max(cData.methodC.mCOutput_batch(65).Q1(ptcList));
y(6, 4, :) = cData.methodC.mCOutput_batch(66).Q1(ptcList)/max(cData.methodC.mCOutput_batch(66).Q1(ptcList));
y(7, 4, :) = cData.methodC.mCOutput_batch(67).Q1(ptcList)/max(cData.methodC.mCOutput_batch(67).Q1(ptcList));
y(8, 4, :) = cData.methodC.mCOutput_batch(68).Q1(ptcList)/max(cData.methodC.mCOutput_batch(68).Q1(ptcList));
y(9, 4, :) = cData.methodC.mCOutput_batch(69).Q1(ptcList)/max(cData.methodC.mCOutput_batch(69).Q1(ptcList));
y(10, 4, :) = cData.methodC.mCOutput_batch(70).Q1(ptcList)/max(cData.methodC.mCOutput_batch(70).Q1(ptcList));


%METHOD C2
y(1, 5, :) = cData.methodC.mCOutput_batch(61).Q2(ptcList)/max(cData.methodC.mCOutput_batch(61).Q2(ptcList));
y(2, 5, :) = cData.methodC.mCOutput_batch(62).Q2(ptcList)/max(cData.methodC.mCOutput_batch(62).Q2(ptcList));
y(3, 5, :) = cData.methodC.mCOutput_batch(63).Q2(ptcList)/max(cData.methodC.mCOutput_batch(63).Q2(ptcList));
y(4, 5, :) = cData.methodC.mCOutput_batch(64).Q2(ptcList)/max(cData.methodC.mCOutput_batch(64).Q2(ptcList));
y(5, 5, :) = cData.methodC.mCOutput_batch(65).Q2(ptcList)/max(cData.methodC.mCOutput_batch(65).Q2(ptcList));
y(6, 5, :) = cData.methodC.mCOutput_batch(66).Q2(ptcList)/max(cData.methodC.mCOutput_batch(66).Q2(ptcList));
y(7, 5, :) = cData.methodC.mCOutput_batch(67).Q2(ptcList)/max(cData.methodC.mCOutput_batch(67).Q2(ptcList));
y(8, 5, :) = cData.methodC.mCOutput_batch(68).Q2(ptcList)/max(cData.methodC.mCOutput_batch(68).Q2(ptcList));
y(9, 5, :) = cData.methodC.mCOutput_batch(69).Q2(ptcList)/max(cData.methodC.mCOutput_batch(69).Q2(ptcList));
y(10, 5, :) = cData.methodC.mCOutput_batch(70).Q2(ptcList)/max(cData.methodC.mCOutput_batch(70).Q2(ptcList));


%METHOD D
y(1, 6, :) = cData.methodD.mDOutput_batch(61).Q(ptcList)/max(cData.methodD.mDOutput_batch(61).Q(ptcList));
y(2, 6, :) = cData.methodD.mDOutput_batch(62).Q(ptcList)/max(cData.methodD.mDOutput_batch(62).Q(ptcList));
y(3, 6, :) = cData.methodD.mDOutput_batch(63).Q(ptcList)/max(cData.methodD.mDOutput_batch(63).Q(ptcList));
y(4, 6, :) = cData.methodD.mDOutput_batch(64).Q(ptcList)/max(cData.methodD.mDOutput_batch(64).Q(ptcList));
y(5, 6, :) = cData.methodD.mDOutput_batch(65).Q(ptcList)/max(cData.methodD.mDOutput_batch(65).Q(ptcList));
y(6, 6, :) = cData.methodD.mDOutput_batch(66).Q(ptcList)/max(cData.methodD.mDOutput_batch(66).Q(ptcList));
y(7, 6, :) = cData.methodD.mDOutput_batch(67).Q(ptcList)/max(cData.methodD.mDOutput_batch(67).Q(ptcList));
y(8, 6, :) = cData.methodD.mDOutput_batch(68).Q(ptcList)/max(cData.methodD.mDOutput_batch(68).Q(ptcList));
y(9, 6, :) = cData.methodD.mDOutput_batch(69).Q(ptcList)/max(cData.methodD.mDOutput_batch(69).Q(ptcList));
y(10, 6, :) = cData.methodD.mDOutput_batch(70).Q(ptcList)/max(cData.methodD.mDOutput_batch(70).Q(ptcList));


%METHOD E
y(1, 7, :) = mEOutput_batch(61).Q(ptcList)/max(mEOutput_batch(61).Q(ptcList));
y(2, 7, :) = mEOutput_batch(62).Q(ptcList)/max(mEOutput_batch(62).Q(ptcList));
y(3, 7, :) = mEOutput_batch(63).Q(ptcList)/max(mEOutput_batch(63).Q(ptcList));
y(4, 7, :) = mEOutput_batch(64).Q(ptcList)/max(mEOutput_batch(64).Q(ptcList));
y(5, 7, :) = mEOutput_batch(65).Q(ptcList)/max(mEOutput_batch(65).Q(ptcList));
y(6, 7, :) = mEOutput_batch(66).Q(ptcList)/max(mEOutput_batch(66).Q(ptcList));
y(7, 7, :) = mEOutput_batch(67).Q(ptcList)/max(mEOutput_batch(67).Q(ptcList));
y(8, 7, :) = mEOutput_batch(68).Q(ptcList)/max(mEOutput_batch(68).Q(ptcList));
y(9, 7, :) = mEOutput_batch(69).Q(ptcList)/max(mEOutput_batch(69).Q(ptcList));
y(10, 7, :) = mEOutput_batch(70).Q(ptcList)/max(mEOutput_batch(70).Q(ptcList));

x = 1:10;
clf
h = boxplot2(y, x); %'Labels', {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'}

% Alter linestyle and color
cmap = get(0, 'defaultaxescolororder');
for var = 1:7
    structfun(@(x) set(x(var,:), 'color', cmap(var,:), ...
        'markeredgecolor', cmap(var,:)), h);
end
set([h.lwhis h.uwhis], 'linestyle', '-');
set(h.out, 'marker', '.');
xticks([1 2 3 4 5 6 7 8 9 10])
xticklabels({'10','20','30', '40','50','60', '70','80','90', '100'})
title('Putative Time Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('Normalized Quality')
set(gca, 'FontSize', figureDetails.fontSize-2)

%% ANOTHER OPTION
figure(2)
clf
% prepare data
data = cell(10, 7);
for var = 1:size(data, 1)
    Orgc{var} = y(var, 1,  :);
    Ac{var} = y(var, 2, :);
    Bc{var} = y(var, 3, :);
    C1c{var} = y(var, 4, :);
    C2c{var} = y(var, 5, :);
    Dc{var} = y(var, 6, :);
    Ec{var} = y(var, 7, :);
end
data = vertcat(Orgc, Ac, Bc, C1c, C2c, Dc, Ec);

xlab={'10','20','30','40','50','60','70','80','90','100'};

multiple_boxplot(data', xlab, {'Org', 'A', 'B', 'C1', 'D', 'E'})
title('Putative Time Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('Normalized Quality')
set(gca, 'FontSize', figureDetails.fontSize-2)
