addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions'))

% Generated Synthetic Data
%load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/synthDATA_batch_220.mat')
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/synthDATA_20200820_gRun1_batch_220.mat')

normalize = 1;
figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet');
nFrames = 246;

for di = 21:1:30
    fig1 = figure(1);
    set(fig1,'Position',[100, 100, 1500, 200])
    clf
    checkDataset(sdo_batch(di).syntheticDATA_2D(:, :), ...
        sprintf('All Trials | Dataset: %i', di), 'Frame Number', 'Cell Number', figureDetails, 0)
    print(sprintf('/Users/ananth/Desktop/figs/checkDataset/%i_check', di), '-dpng')
end