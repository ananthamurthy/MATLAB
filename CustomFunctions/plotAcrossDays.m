% AUTHOR - Kambadur Ananthmurthy
% Plot consistently identified cells across multiple days
clear all
close all

%% Figure details
figureDetails.fontSize = 16;
figureDetails.lineWidth = 2;
figureDetails.markerSize = 10;
figureDetails.transparency = 0.5;

%% Plotting
mouseName = 'M16';
date1 = '20171003';
date2 = '20171005';

dataset1.mouse_name = mouseName;
dataset1.date = date1;
dataset1.sessionType   = 3;
dataset1.session       = 1;
dataset1.nFrames       = 246;
dataset1.trialDuration = 17; %in seconds

dataset2.mouse_name = mouseName;
dataset2.date = date2;
dataset2.sessionType   = 3;
dataset2.session       = 3;
dataset2.nFrames       = 246;
dataset2.trialDuration = 17; %in seconds

%2D
fig1 = figure(1);
set(fig1,'Position',[300,300,2000,500])

%1
trialDetails = getTrialDetails(dataset1);
load(sprintf('/Users/ananth/Desktop/Work/Analysis/Imaging/%s/%s/%s_%s_multiDay.mat', ...
    dataset1.mouse_name, dataset1.date, dataset1.mouse_name, dataset1.date))

subplot(1,2,1)
plotdFbyF(dataset1, dfbf_2D, trialDetails, 'Frames', 'Unsorted Cells', figureDetails, 0)
%hold on

%2
trialDetails = getTrialDetails(dataset2);
load(sprintf('/Users/ananth/Desktop/Work/Analysis/Imaging/%s/%s/%s_%s_multiDay.mat', ...
    dataset2.mouse_name, dataset2.date, dataset2.mouse_name, dataset2.date))

subplot(1,2,2)
plotdFbyF(dataset2, dfbf_2D, trialDetails, 'Frames', 'Unsorted Cells', figureDetails, 0)
colormap('cool')
print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_2D_allTrials_' ...
    dataset2.mouse_name '_' date1 '_' date2 '_multiDay'],...
    '-djpeg');

% Trial Averaged
fig2 = figure(2);
set(fig2,'Position',[300,300,2000,500])

%1
%trialDetails = getTrialDetails(dataset);
load(sprintf('/Users/ananth/Desktop/Work/Analysis/Imaging/%s/%s/%s_%s_multiDay.mat', ...
    dataset1.mouse_name, dataset1.date, dataset1.mouse_name, dataset1.date))

subplot(1,2,1)
trialPhase = 'wholeTrial';
plotSequences(dataset1, dfbf, trialPhase, 'Time (ms)', 'Chronically Tracked Cells (Unsorted)', figureDetails, 0)
%hold on

%2
%trialDetails = getTrialDetails(dataset);
load(sprintf('/Users/ananth/Desktop/Work/Analysis/Imaging/%s/%s/%s_%s_multiDay.mat', ...
    dataset2.mouse_name, dataset2.date, dataset2.mouse_name, dataset2.date))

subplot(1,2,2)
trialPhase = 'wholeTrial';
plotSequences(dataset2, dfbf, trialPhase, 'Time (ms)', 'Chronically Tracked Cells (Unsorted)', figureDetails, 0)
colormap('cool')
print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_trialAvg_' ...
    dataset2.mouse_name '_' date1 '_' date2  '_multiDay'],...
    '-djpeg');