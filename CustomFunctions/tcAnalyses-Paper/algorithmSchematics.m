% Schematics for different time cell detection algorithms
% Make sure to have the dataset accessible
close all
% Schematic for Method A - Mehrab's method
%{
i = i + 1;
sdcp(i).timeCellPercent = 50; %in %
sdcp(i).cellOrder = 'basic'; %basic or random
sdcp(i).maxHitTrialPercent = 100; %in %
sdcp(i).hitTrialPercentAssignment = 'random'; %fixed or random
sdcp(i).trialOrder = 'random'; %basic or random
sdcp(i).eventWidth = {50, 'stddev'}; %{location, width}; e.g. - {percentile, stddev}
sdcp(i).eventAmplificationFactor = 1;
sdcp(i).eventTiming = 'sequential'; %sequential or random
sdcp(i).startFrame = 116;
sdcp(i).endFrame = 123;
sdcp(i).imprecisionFWHM = 8; %Will be divided by 2 for positive and negative "width" around the centre
sdcp(i).imprecisionType = 'none'; %Uniform, Normal, or None
sdcp(i).noise = 'gaussian'; %Gaussian (as noisePercent) or None (renders noisePercent irrelevant)
sdcp(i).noisePercent = 25; %How much percent of noise to add
sdcp(i).comment = 'basic cell order, random hit trial assignment, large events, no imprecision, 25% gaussian noise';
%}
%Method A - Mehrab's Reliability Analysis (Bhalla Lab)
DATA = sdo.syntheticDATA;
iexp = 1;
trialDetails = getTrialDetails(db(iexp));

mAInput.cellList = 1:1:size(DATA,1); %using all cells
mAInput.onFrame = sdcp.startFrame;
mAInput.offFrame = sdcp.endFrame;
mAInput.ridgeHalfWidth = 100; %in ms
mAInput.nIterations = 5000; %number of iterations of randomisation used to find averaged r-shifted rb ratio - might have to go as high as 3000.
mAInput.selectNonOverlappingTrials = 1; %1 - non-overlapping trial sets used for kernel estimation and rb ratio calculation, 0 - all trials used for both
mAInput.earlyOnly = 0; %0 - uses all trials; 1 - uses only the first 5 trials of the session
mAInput.startTrial = 1; %the analysis begins with this trial number (e.g. - 1: analysis on all trials)

mehrabInput = mAInput;
cell_list = mehrabInput.cellList;
CS_onset_frame = mehrabInput.onFrame;
US_onset_frame = mehrabInput.offFrame;
ridge_h_width = mehrabInput.ridgeHalfWidth;
%r_iters = mehrabInput.nIterations;
r_iters = 1;
non_ov_trials = mehrabInput.selectNonOverlappingTrials;
early_only = mehrabInput.earlyOnly;
pk_behav_trial = mehrabInput.startTrial;

%Preallocation
timeCells = nan(size(DATA, 1), 1); %Will change to 'nCells' at some point

%Trial specifics
frame_time = 1000/trialDetails.frameRate;
ridge_h_width_f = floor(ridge_h_width/frame_time); %in frames
dff_data_mat = permute(DATA, [3 1 2]);
no_trials = size(dff_data_mat, 3);

%establishing typical response size for each cell
pk_list_t = zeros(length(cell_list), 2);

cell_noi = 50;
cell_no = cell_list(cell_noi);
traces = squeeze(dff_data_mat(CS_onset_frame:(US_onset_frame-1), cell_no, :));
pks = nanmax(traces);
pk_list_t(cell_noi, 1) = mean(pks);
pk_list_t(cell_noi, 2) = std(pks);

if non_ov_trials == 0
    kernels = nanmean(dff_data_mat(:, cell_list, pk_behav_trial:no_trials), 3);
    
elseif non_ov_trials == 1
    k_tr_list = pk_behav_trial:2:no_trials;
    
    kernels = nanmean(dff_data_mat(:, cell_list, k_tr_list), 3); %2D matrix: (values, cells)
    dff_data_mat(:, :, k_tr_list) = nan;    %making sure kernel estimation trials not used for rb ratio calculation
else
end

kernels_nt = kernels;
kernels_e = nanmean(dff_data_mat(:, cell_list, 1:5), 3);  %for early trials only; 2D matrix: (values, cells)

%finding indices of the trial-averaged peaks of activity for each cell
if early_only == 0
    [~, pki] = nanmax(kernels(CS_onset_frame:(US_onset_frame + floor(200./frame_time)), :), [], 1);
elseif early_only == 1
    [~, pki] = nanmax(kernels_e(CS_onset_frame:(US_onset_frame + floor(200./frame_time)), :), [], 1);
else
end
%disp(pki)

%calculating ridge to background ratio for each cell -loops to calculate ridge to background ratios on a per cell basis - with a separate loop for randomised calculations
disp('Now calculating Ridge to Background Ratios ...')
rb_ratio_vec = zeros(1, length(cell_list));
rrb_ratio_vec_final = zeros(1, length(cell_list));

cell_no = cell_list(cell_noi); %looking up cell in cell_list
pk_f = pki(cell_noi) + ridge_h_width_f;
trace = kernels_nt((CS_onset_frame - ridge_h_width_f):(US_onset_frame + round(200./frame_time) + ridge_h_width_f), cell_noi);

%loop for randomly shuffled calculation
no_frames = length(trace);

%loop for multiple random shuffles followed by finding mean value
for iter_r = 1:r_iters
    s_trace_av_mat = zeros(length(trace), no_trials) + nan;
    
    init_trial = pk_behav_trial;
    
    r_shift_vec = floor(rand(no_trials, 1).*(no_frames - 1) + 1 );
    for trial_no = init_trial:no_trials
        r_shift = r_shift_vec(trial_no, 1);
        trace = dff_data_mat((CS_onset_frame - ridge_h_width_f):(US_onset_frame + round(200./frame_time) + ridge_h_width_f), cell_no, trial_no);
        %trace = dff_data_mat((CS_onset_frame - ridge_h_width_f):(US_onset_frame + ridge_h_width_f), cell_no, trial_no);
        trace_shifted = zeros(1, length(trace));
        trace_shifted(1, 1:(no_frames - r_shift) ) = trace((r_shift + 1):no_frames, 1)';
        trace_shifted(1, (no_frames - r_shift + 1):no_frames) = trace(1:(r_shift), 1);
        trace_shifted = trace_shifted';
        s_trace_av_mat(:, trial_no) = trace_shifted;
    end
    s_trace_av = nanmean(s_trace_av_mat, 2);
    %clear s_trace_av_mat
end

for trial = 1:4
    figure(trial)
    plot(squeeze(DATA(cell_noi, trial, :))*100, ...
        'LineWidth', 2)
    xlabel('Frame Number', ...
        'FontSize', 20,...
        'FontWeight', 'bold')
    ylabel('dF/F (%)', ...
        'FontSize', 20,...
        'FontWeight', 'bold')
    text(25, 500, sprintf('Cell: %i, Trial: %i', cell_noi, trial), 'FontSize', 16)
    set(gca,'FontSize', 20-3)
    print(['/Users/ananth/Desktop/figs/tcAnalysisPaper/mehrabAlgorithm_Cell' num2str(cell_noi) '_Trial' num2str(trial)], ...
        '-dpng')
end

figure(5)
plot(trace*100, 'b', ...
    'LineWidth', 5)
hold on
plot(s_trace_av*100, 'r', ...
    'LineWidth', 5)
% hold on
% ridgeInterval = zeros(13, 350);
% for i = 5:8
%     ridgeInterval(i, :) = 350;
% end
% plot(ridgeInterval, '--k*')
hold off
xlabel('Frame Number', ...
    'FontSize', 20,...
    'FontWeight', 'bold')
ylabel('Trial Averaged dF/F (%)', ...
    'FontSize', 20,...
    'FontWeight', 'bold')
legend({'Normal', 'Random Offset'})
set(gca,'FontSize', 20-3)
print(['/Users/ananth/Desktop/figs/tcAnalysisPaper/mehrabAlgorithm_Cell' num2str(cell_noi) ...
    '_normalVsRandom'], ...
    '-dpng')
disp('Done!')

%% Method B - William's Method
delta = 3;
skipFrames = [];
[cellETH, ~, nBins] = getETH(DATA(cell_noi, :, :), delta, skipFrames);
figure(6)
plot(cellETH, 'LineWidth', 5)
xlim([0 nBins])
title(['Event Time Histogram (ETH) - Cell: ' num2str(cell_noi)], ...
    'FontSize', 20,...
    'FontWeight', 'bold')
xlabel('Bin Number', ...
    'FontSize', 20,...
    'FontWeight', 'bold')
ylabel('Area Under Curve', ...
    'FontSize', 20,...
    'FontWeight', 'bold')
set(gca,'FontSize', 20-3)
print(['/Users/ananth/Desktop/figs/tcAnalysisPaper/williamAlgorithm_Cell' num2str(cell_noi) ...
    '_ETH'], ...
    '-dpng')

%% Method C - Simple Analysis
delta = 3;
skipFrames = [];
[~, trialAUCs, nBins] = getETH(DATA(cell_noi, :, :), delta, skipFrames);
for trial = 1:4
    figure(trial)
    plot(squeeze(trialAUCs(1, trial, :)), ...
        'LineWidth', 5)
    xlim([0 nBins])
    text(25, 500, sprintf('Cell: %i, Trial: %i', cell_noi, trial), 'FontSize', 16)
    xlabel('Bin Number', ...
        'FontSize', 20,...
        'FontWeight', 'bold')
    ylabel('Counts', ...
        'FontSize', 20,...
        'FontWeight', 'bold')
    text(25, 500, sprintf('Cell: %i, Trial: %i', cell_noi, trial), 'FontSize', 16)
    set(gca,'FontSize', 20-3)
    print(['/Users/ananth/Desktop/figs/tcAnalysisPaper/simpleAlgorithm_Cell' num2str(cell_noi) '_Trial' num2str(trial)], ...
        '-dpng')
end