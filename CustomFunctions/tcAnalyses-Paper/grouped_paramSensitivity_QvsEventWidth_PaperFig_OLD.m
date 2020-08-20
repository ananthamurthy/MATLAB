close all

% Generated Synthetic Data
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/synthDATA_batch_220.mat')

% Analysed Data
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200615_cRun4_cData.mat')
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200729_gRun2_methodE_batch_1-220.mat')

figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)

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
subplot(1,2,1)

%ORIGINAL METHOD
y(1, 1:lp) = sdo_batch(61).Q(ptcList);
y(1, lp+1:2*lp) = sdo_batch(62).Q(ptcList);
y(1, 3*lp+1: 4*lp) = sdo_batch(63).Q(ptcList);
y(1, 4*lp+1: 5*lp) = sdo_batch(64).Q(ptcList);
y(1, 5*lp+1: 6*lp) = sdo_batch(65).Q(ptcList);
y(1, 6*lp+1: 7*lp) = sdo_batch(66).Q(ptcList);
y(1, 7*lp+1: 8*lp) = sdo_batch(67).Q(ptcList);
y(1, 8*lp+1: 9*lp) = sdo_batch(68).Q(ptcList);
y(1, 9*lp+1: 10*lp) = sdo_batch(69).Q(ptcList);
y(1, 10*lp+1: 11*lp) = sdo_batch(70).Q(ptcList);

%METHOD A
y(2, 1:lp) = cData.methodA.mAOutput_batch(61).Q(ptcList);
y(2, lp+1:2*lp) = cData.methodA.mAOutput_batch(62).Q(ptcList);
y(2, 3*lp+1: 4*lp) = cData.methodA.mAOutput_batch(63).Q(ptcList);
y(2, 4*lp+1: 5*lp) = cData.methodA.mAOutput_batch(64).Q(ptcList);
y(2, 5*lp+1: 6*lp) = cData.methodA.mAOutput_batch(65).Q(ptcList);
y(2, 6*lp+1: 7*lp) = cData.methodA.mAOutput_batch(66).Q(ptcList);
y(2, 7*lp+1: 8*lp) = cData.methodA.mAOutput_batch(67).Q(ptcList);
y(2, 8*lp+1: 9*lp) = cData.methodA.mAOutput_batch(68).Q(ptcList);
y(2, 9*lp+1: 10*lp) = cData.methodA.mAOutput_batch(69).Q(ptcList);
y(2, 10*lp+1: 11*lp) = cData.methodA.mAOutput_batch(70).Q(ptcList);


%METHOD B
y(3, 1:lp) = cData.methodB.holyData.mBOutput_batch(61).Q(ptcList);
y(3, lp+1:2*lp) = cData.methodB.holyData.mBOutput_batch(62).Q(ptcList);
y(3, 3*lp+1: 4*lp) = cData.methodB.holyData.mBOutput_batch(63).Q(ptcList);
y(3, 4*lp+1: 5*lp) = cData.methodB.holyData.mBOutput_batch(64).Q(ptcList);
y(3, 5*lp+1: 6*lp) = cData.methodB.holyData.mBOutput_batch(65).Q(ptcList);
y(3, 6*lp+1: 7*lp) = cData.methodB.holyData.mBOutput_batch(66).Q(ptcList);
y(3, 7*lp+1: 8*lp) = cData.methodB.holyData.mBOutput_batch(67).Q(ptcList);
y(3, 8*lp+1: 9*lp) = cData.methodB.holyData.mBOutput_batch(68).Q(ptcList);
y(3, 9*lp+1: 10*lp) = cData.methodB.holyData.mBOutput_batch(69).Q(ptcList);
y(3, 10*lp+1: 11*lp) = cData.methodB.holyData.mBOutput_batch(70).Q(ptcList);

%METHOD C1
y(4, 1:lp) = cData.methodC.mCOutput_batch(61).Q1(ptcList);
y(4, lp+1:2*lp) = cData.methodC.mCOutput_batch(62).Q1(ptcList);
y(4, 3*lp+1: 4*lp) = cData.methodC.mCOutput_batch(63).Q1(ptcList);
y(4, 4*lp+1: 5*lp) = cData.methodC.mCOutput_batch(64).Q1(ptcList);
y(4, 5*lp+1: 6*lp) = cData.methodC.mCOutput_batch(65).Q1(ptcList);
y(4, 6*lp+1: 7*lp) = cData.methodC.mCOutput_batch(66).Q1(ptcList);
y(4, 7*lp+1: 8*lp) = cData.methodC.mCOutput_batch(67).Q1(ptcList);
y(4, 8*lp+1: 9*lp) = cData.methodC.mCOutput_batch(68).Q1(ptcList);
y(4, 9*lp+1: 10*lp) = cData.methodC.mCOutput_batch(69).Q1(ptcList);
y(4, 10*lp+1: 11*lp) = cData.methodC.mCOutput_batch(70).Q1(ptcList);


%METHOD C2
y(5, 1:lp) = cData.methodC.mCOutput_batch(61).Q2(ptcList);
y(5, lp+1:2*lp) = cData.methodC.mCOutput_batch(62).Q2(ptcList);
y(5, 3*lp+1: 4*lp) = cData.methodC.mCOutput_batch(63).Q2(ptcList);
y(5, 4*lp+1: 5*lp) = cData.methodC.mCOutput_batch(64).Q2(ptcList);
y(5, 5*lp+1: 6*lp) = cData.methodC.mCOutput_batch(65).Q2(ptcList);
y(5, 6*lp+1: 7*lp) = cData.methodC.mCOutput_batch(66).Q2(ptcList);
y(5, 7*lp+1: 8*lp) = cData.methodC.mCOutput_batch(67).Q2(ptcList);
y(5, 8*lp+1: 9*lp) = cData.methodC.mCOutput_batch(68).Q2(ptcList);
y(5, 9*lp+1: 10*lp) = cData.methodC.mCOutput_batch(69).Q2(ptcList);
y(5, 10*lp+1: 11*lp) = cData.methodC.mCOutput_batch(70).Q2(ptcList);


%METHOD D
y(6, 1:lp) = cData.methodD.mDOutput_batch(61).Q(ptcList);
y(6, lp+1:2*lp) = cData.methodD.mDOutput_batch(62).Q(ptcList);
y(6, 3*lp+1: 4*lp) = cData.methodD.mDOutput_batch(63).Q(ptcList);
y(6, 4*lp+1: 5*lp) = cData.methodD.mDOutput_batch(64).Q(ptcList);
y(6, 5*lp+1: 6*lp) = cData.methodD.mDOutput_batch(65).Q(ptcList);
y(6, 6*lp+1: 7*lp) = cData.methodD.mDOutput_batch(66).Q(ptcList);
y(6, 7*lp+1: 8*lp) = cData.methodD.mDOutput_batch(67).Q(ptcList);
y(6, 8*lp+1: 9*lp) = cData.methodD.mDOutput_batch(68).Q(ptcList);
y(6, 9*lp+1: 10*lp) = cData.methodD.mDOutput_batch(69).Q(ptcList);
y(6, 10*lp+1: 11*lp) = cData.methodD.mDOutput_batch(70).Q(ptcList);


%METHOD E
y(7, 1:lp) = mEOutput_batch(61).Q(ptcList);
y(7, lp+1:2*lp) = mEOutput_batch(62).Q(ptcList);
y(7, 3*lp+1: 4*lp) = mEOutput_batch(63).Q(ptcList);
y(7, 4*lp+1: 5*lp) = mEOutput_batch(64).Q(ptcList);
y(7, 5*lp+1: 6*lp) = mEOutput_batch(65).Q(ptcList);
y(7, 6*lp+1: 7*lp) = mEOutput_batch(66).Q(ptcList);
y(7, 7*lp+1: 8*lp) = mEOutput_batch(67).Q(ptcList);
y(7, 8*lp+1: 9*lp) = mEOutput_batch(68).Q(ptcList);
y(7, 9*lp+1: 10*lp) = mEOutput_batch(69).Q(ptcList);
y(7, 10*lp+1: 11*lp) = mEOutput_batch(70).Q(ptcList);

% boxplot(y, 'PrimaryLabels', {'Q' 'QA' 'QB' 'QC1' 'QC2' 'QD' 'QE'}, ...
%   'SecondaryLabels',{'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'}, ...
%   'GroupLabelType', 'Vertical')
x = 1:7;
boxplot(y(:,1:lp), x)

boxplot(y(1,:), x, 'Labels', {'Q' 'QA' 'QB' 'QC1' 'QC2' 'QD' 'QE'})
boxplot(y(1,:), x, 'Labels', {'Q' 'QA' 'QB' 'QC1' 'QC2' 'QD' 'QE'})

title('Putative Time Cells - Fixed Event Widths')
xlabel('Event Width Percentile')
ylabel('Quality')
set(gca, 'FontSize', figureDetails.fontSize-2)