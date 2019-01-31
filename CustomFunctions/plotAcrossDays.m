% AUTHOR - Kambadur Ananthmurthy
% Plot consistently identified cells across multiple days
clear all
close all

figureDetails = compileFigureDetails(20, 2, 10, 0.5); %(fontSize, lineWidth, markerSize, transparency)

mouseName = 'M16';
sessionA = 1;
dateA = '20171003';
sessionTypeA = 3;
sessionB = 3;
dateB = '20171005';
sessionTypeB = 3;

[datasetA, datasetB] = compileChronicData(mouseName, dateA, dateB, ...
    sessionA, sessionB, sessionTypeA, sessionTypeB);
[datasetA, datasetB] = loadChronicData(datasetA, datasetB); %NOTE: requires _reg.mat file

%% Check for tuning
skipFrames = 116;

%Event Frequency
%1
trialPhase = 'wholeTrial';
clear window %for sanity
window = findWindow(trialPhase, datasetA.trialDetails);
x=0.2; % in%
threshold = x*(size(datasetA.data_sigOnly,2)); %threshold is x% of the session trials
[datasetA.cellRastor, datasetA.cellFrequency, datasetA.timeLockedCells, datasetA.importantTrials] = ...
    getFreqBasedTimeCellList(datasetA.data_sigOnly(:,:,window), threshold, skipFrames);

%2
trialPhase = 'wholeTrial';
clear window %for sanity
window = findWindow(trialPhase, datasetB.trialDetails);
x=0.2; % in%
threshold = x*(size(datasetB.data_sigOnly,2)); %threshold is x% of the session trials
[datasetB.cellRastor, datasetB.cellFrequency, datasetB.timeLockedCells, datasetB.importantTrials] = ...
    getFreqBasedTimeCellList(datasetB.data_sigOnly(:,:,window), threshold, skipFrames);

%%PSTH
%1
trialPhase = 'wholeTrial';
clear window %for sanity
window = findWindow(trialPhase, datasetA.trialDetails);

%2
trialPhase = 'wholeTrial';
clear window %for sanity
window = findWindow(trialPhase, datasetB.trialDetails);
%% Correlation Coefficients
% 
% for cell = 1:size(data1)
% R = corrcoef(A);


%% Plots
disp('Plotting XY ...')

% XY plots - scatter plots for comparing cells across days
X = datasetA.trialAvg(find(datasetA.timeLockedCells),111:130);
Y = datasetB.trialAvg(find(datasetB.timeLockedCells),111:130);

fig1 = figure(1);
set(fig1,'Position',[300,300,2000,2000])
plotmatrix(X, Y)
print(['/Users/ananth/Desktop/figs/plotmatrix_' ...
    datasetA.mouse_name '_' datasetA.date '_' datasetB.date  '_multiDay'],...
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
plotSequences(datasetA, data1, trialPhase, 'Frames', 'Chronically Tracked Cells (Unsorted)', figureDetails, 0)
%A = datasetA.sigOnly(find(datasetA.timeLockedCells),:,:);
%plotSequences(datasetB, A, trialPhase, 'Frames', 'Chronically Tracked Cells (Unsorted)', figureDetails, 0)(datasetA, datasetA.trialAvg, trialPhase, 'Frames', 'Chronically Tracked Tuned Cells', figureDetails, 0)
set(gca,'FontSize',figureDetails.fontSize-4)
%hold on

%2
%trialDetails = getTrialDetails(dataset);
subplot(1,2,2)
trialPhase = 'wholeTrial';
plotSequences(datasetB, data2, trialPhase, 'Frames', 'Chronically Tracked Cells (Unsorted)', figureDetails, 0)
%B = datasetB.sigOnly(find(datasetB.timeLockedCells),:,:);
%plotSequences(datasetB, B, trialPhase, 'Frames', 'Chronically Tracked Tuned Cells', figureDetails, 0)
set(gca,'FontSize',figureDetails.fontSize-4)
colormap('hot')
%print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_trialAvg_' ...
print(['/Users/ananth/Desktop/dfbf_trialAvg_' ...    
    datasetB.mouse_name '_' date1 '_' date2  '_multiDay'],...
    '-djpeg');
disp('... done!')

disp('Plotting 2D activity ...')
%2D
fig3 = figure(3);
set(fig3,'Position',[300,300,2000,500])
%1
subplot(1,2,1)
plotdFbyF(datasetA, datasetA.data_2D, trialDetails_datasetA, 'Frames', 'Unsorted Cells', figureDetails, 0)
set(gca,'FontSize',figureDetails.fontSize-4)
%hold on

%2
subplot(1,2,2)
plotdFbyF(datasetB, datasetB.data_2D, trialDetails_datasetB, 'Frames', 'Unsorted Cells', figureDetails, 0)
set(gca,'FontSize',figureDetails.fontSize-4)
colormap('hot')
%print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_2D_allTrials_' ...
print(['/Users/ananth/Desktop/dfbf_2D_allTrials_' ...
    datasetB.mouse_name '_' date1 '_' date2 '_multiDay'],...
    '-djpeg');
disp('... done!')