% AUTHOR - Kambadur Ananthmurthy
% Plot consistently identified cells across multiple days
clear all
close all

%% Figure details
figureDetails.fontSize = 20;
figureDetails.lineWidth = 2;
figureDetails.markerSize = 10;
figureDetails.transparency = 0.5;

%% General
mouseName = 'M16';
date1 = '20171003';
dataset1.mouse_name = mouseName;
dataset1.date = date1;
dataset1.sessionType   = 3;
dataset1.session       = 1;
dataset1.nFrames       = 246;
dataset1.trialDuration = 17; %in seconds

date2 = '20171005';
dataset2.mouse_name = mouseName;
dataset2.date = date2;
dataset2.sessionType   = 3;
dataset2.session       = 3;
dataset2.nFrames       = 246;
dataset2.trialDuration = 17; %in seconds

regDataset = sprintf('Users/ananth/Desktop/Work/Analysis/Imaging/%s/%s_%s_plane1_%s_%s_plane1_reg.mat', ...
    mouseName, mouseName, dataset1.date, mouseName, dataset2.date);
disp(regDataset)

%Daisy-chain
[overlaps] = cat_overlap();
%[overlaps] = cat_overlap(regDataset);
set1 = overlaps.rois.idcs(:,1);
set2 = overlaps.rois.idcs(:,2);

if length(set1) ~= length(set2)
    error("Indices do not match")
end
%% Get datasets
disp('Getting datasets ...')
trialDetails_dataset1 = getTrialDetails(dataset1);
load(sprintf('/Users/ananth/Desktop/Work/Analysis/Imaging/%s/%s/%s_%s.mat', ...
    dataset1.mouse_name, dataset1.date, dataset1.mouse_name, dataset1.date))
data1 = dfbf(set1,:,:);
data1_2D = dfbf_2D(set1,:);

trialDetails_dataset2 = getTrialDetails(dataset2);
load(sprintf('/Users/ananth/Desktop/Work/Analysis/Imaging/%s/%s/%s_%s.mat', ...
    dataset2.mouse_name, dataset2.date, dataset2.mouse_name, dataset2.date))
data2 = dfbf(set2,:,:);
data2_2D = dfbf_2D(set2,:);
disp('... done!')

%% Check for tuning
data1_sigOnly = findSigOnly(data1);
data2_sigOnly = findSigOnly(data2);
skipFrames = 116;

%1
trialPhase = 'wholeTrial';
clear window %for sanity
window = findWindow(trialPhase, trialDetails_dataset1);
x=0.2; % in%
threshold = x*(size(data1_sigOnly,2)); %threshold is x% of the session trials
[data1_cellRastor, data1_cellFrequency, data1_timeLockedCells, data1_importantTrials] = ...
    getFreqBasedTimeCellList(data1_sigOnly(:,:,window), threshold, skipFrames);

%2
trialPhase = 'wholeTrial';
clear window %for sanity
window = findWindow(trialPhase, trialDetails_dataset2);
x=0.2; % in%
threshold = x*(size(data2_sigOnly,2)); %threshold is x% of the session trials
[data2_cellRastor, data2_cellFrequency, data2_timeLockedCells, data2_importantTrials] = ...
    getFreqBasedTimeCellList(data2_sigOnly(:,:,window), threshold, skipFrames);

%% Correlation Coefficients
% 
% for cell = 1:size(data1)
% R = corrcoef(A);


%% Plots
disp('Plotting XY ...')
data1_trialAvg = squeeze(mean(data1,2));
data2_trialAvg = squeeze(mean(data2,2));

% XY plots - scatter plots for comparing cells across days
X = data1_trialAvg(find(data1_timeLockedCells),111:130);
Y = data2_trialAvg(find(data2_timeLockedCells),111:130);

fig1 = figure(1);
set(fig1,'Position',[300,300,2000,2000])
plotmatrix(X, Y)
print(['/Users/ananth/Desktop/figs/plotmatrix_' ...
    dataset2.mouse_name '_' date1 '_' date2  '_multiDay'],...
    '-djpeg');
disp('... done!')

disp('Plotting Trial-Averaged activity ...')

% Trial Averaged
fig2 = figure(2);
set(fig2,'Position',[300,300,2000,500])
%1
%trialDetails = getTrialDetails(dataset);
subplot(1,2,1)
trialPhase = 'wholeTrial';
plotSequences(dataset1, data1, trialPhase, 'Frames', 'Chronically Tracked Cells (Unsorted)', figureDetails, 0)
%A = data1_sigOnly(find(data1_timeLockedCells),:,:);
%plotSequences(dataset2, A, trialPhase, 'Frames', 'Chronically Tracked Cells (Unsorted)', figureDetails, 0)(dataset1, data1_trialAvg, trialPhase, 'Frames', 'Chronically Tracked Tuned Cells', figureDetails, 0)
set(gca,'FontSize',figureDetails.fontSize-4)
%hold on

%2
%trialDetails = getTrialDetails(dataset);
subplot(1,2,2)
trialPhase = 'wholeTrial';
plotSequences(dataset2, data2, trialPhase, 'Frames', 'Chronically Tracked Cells (Unsorted)', figureDetails, 0)
%B = data2_sigOnly(find(data2_timeLockedCells),:,:);
%plotSequences(dataset2, B, trialPhase, 'Frames', 'Chronically Tracked Tuned Cells', figureDetails, 0)
set(gca,'FontSize',figureDetails.fontSize-4)
colormap('hot')
%print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_trialAvg_' ...
print(['/Users/ananth/Desktop/dfbf_trialAvg_' ...    
    dataset2.mouse_name '_' date1 '_' date2  '_multiDay'],...
    '-djpeg');
disp('... done!')

disp('Plotting 2D activity ...')
%2D
fig3 = figure(3);
set(fig3,'Position',[300,300,2000,500])
%1
subplot(1,2,1)
plotdFbyF(dataset1, data1_2D, trialDetails_dataset1, 'Frames', 'Unsorted Cells', figureDetails, 0)
set(gca,'FontSize',figureDetails.fontSize-4)
%hold on

%2
subplot(1,2,2)
plotdFbyF(dataset2, data2_2D, trialDetails_dataset2, 'Frames', 'Unsorted Cells', figureDetails, 0)
set(gca,'FontSize',figureDetails.fontSize-4)
colormap('hot')
%print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_2D_allTrials_' ...
print(['/Users/ananth/Desktop/dfbf_2D_allTrials_' ...
    dataset2.mouse_name '_' date1 '_' date2 '_multiDay'],...
    '-djpeg');
disp('... done!')