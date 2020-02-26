function [mehrabOutput] = runMehrabR2BAnalysis(DATA)

% learned_list   = [];
% saved_scores   = [];
% all_scores     = [];
% saved_pk_times = [];

%Change of hands
% !! Requires further thought; currently just trying to run the code !!
%learned = 1;
blink_list = ones(size(myData.dfbf, 2), 1); %Setting blink_list = 1 for all trials
%learned_list = [learned_list; learned]; %!! Handle this better !!
blink_trials = find(blink_list == 1);
%Trial specifics
CS_onset_frame = trialDetails.frameRate*trialDetails.preDuration;
US_onset_frame = floor(trialDetails.frameRate * ...
    (trialDetails.preDuration + ...
    trialDetails.csDuration + ...
    trialDetails.traceDuration));
frame_time = 1000/trialDetails.frameRate;
dff_data_mat = permute(DATA, [3 1 2]);
pk_behav_trial = 1; %Short-circuit to analyse all trials, instead of just the last few.

no_cells = size(dff_data_mat,2);
no_trials = size(dff_data_mat,3);
cell_list = 1:1:no_cells;       %using all cells
%establishing typical response size for each cell
pk_list_t = zeros(length(cell_list), 2);

for cell_noi = 1:length(cell_list)
    cell_no = cell_list(cell_noi);
    traces = squeeze(dff_data_mat(CS_onset_frame:(US_onset_frame-1), cell_no, :));
    pks = nanmax(traces);
    pk_list_t(cell_noi, 1) = mean(pks);
    pk_list_t(cell_noi, 2) = std(pks);
end

if non_ov_trials == 0
    kernels = nanmean(dff_data_mat(:, cell_list, pk_behav_trial:no_trials), 3);
    
elseif non_ov_trials == 1
    k_tr_list = pk_behav_trial:2:no_trials;
    %t_tr_list = (pk_behav_trial + 1):2:no_trials; %appears to be unused; commenting out for now
    
    kernels = nanmean(dff_data_mat(:, cell_list, k_tr_list), 3);
    dff_data_mat(:, :, k_tr_list) = nan;    %making sure kernel estimation trials not used for rb ratio calculation
else
end

kernels_nt = kernels;
kernels_e = nanmean(dff_data_mat(:, cell_list, 1:5), 3);  %for early trials only

%finding peaks of activity for each cell
if early_only == 0
    %[pks, pki] = nanmax(kernels_nt(CS_onset_frame:(US_onset_frame + floor(200./frame_time)), :), [], 1);
    [~, pki] = nanmax(kernels_nt(CS_onset_frame:(US_onset_frame + floor(200./frame_time)), :), [], 1);
elseif early_only == 1
    %[pks, pki] = nanmax(kernels_e(CS_onset_frame:(US_onset_frame + floor(200./frame_time)), :), [], 1);
    [~, pki] = nanmax(kernels_e(CS_onset_frame:(US_onset_frame + floor(200./frame_time)), :), [], 1);
else
end

ridge_h_width_f = floor(ridge_h_width./frame_time);
%calculating ridge to background ratio for each cell

%loops to calculate ridge to background ratios on a per cell basis - with a separate loop for randomised calculations
disp('Now calculating ridge/background ratio ...')
rb_ratio_vec = zeros(1, length(cell_list));
rrb_ratio_vec_final = zeros(1, length(cell_list));
for cell_noi = 1:length(cell_list)
    cell_no = cell_list(cell_noi);                              %looking up cell_no in cell_list
    pk_f = pki(cell_noi) + ridge_h_width_f;
    trace = kernels_nt((CS_onset_frame - ridge_h_width_f):(US_onset_frame + round(200./frame_time) + ridge_h_width_f), cell_noi);
    ridge_int = (nansum(trace( (pk_f - ridge_h_width_f):(pk_f + ridge_h_width_f) )));
    ridge_int = ridge_int./(2.*ridge_h_width_f + 1);                                    %normalising by number of points considered
    trace_x = trace;
    trace_x((pk_f - ridge_h_width_f):(pk_f + ridge_h_width_f)) = [];
    bk_int = nansum(trace_x);
    temp = isnan(trace_x);                                  %entirety of the rest of the trace used as background
    bk_int = bk_int./(length(trace_x) - sum(temp));         %normalising by number of points considered
    rb_ratio_vec(1, cell_noi) = ridge_int./abs(bk_int);
    
    %loop for randomly shuffled calculation
    
    rrb_ratio_vec = zeros(1, r_iters);
    no_frames = length(trace);
    
    %loop for multiple random shuffles followed by finding mean value
    for iter_r = 1:r_iters
        s_trace_av_mat = zeros(length(trace), no_trials) + nan;
        
        init_trial = pk_behav_trial;
        
        r_shift_vec = floor(rand(no_trials, 1).*(no_frames - 1) + 1 );
        for trial_no = init_trial:no_trials
            r_shift = r_shift_vec(trial_no, 1);
            trace = dff_data_mat((CS_onset_frame - ridge_h_width_f):(US_onset_frame + round(200./frame_time) + ridge_h_width_f), cell_no, trial_no);
            trace_shifted = zeros(1, length(trace));
            trace_shifted(1, 1:(no_frames - r_shift) ) = trace((r_shift + 1):no_frames, 1)';
            trace_shifted(1, (no_frames - r_shift + 1):no_frames) = trace(1:(r_shift), 1);
            trace_shifted = trace_shifted';
            s_trace_av_mat(:, trial_no) = trace_shifted;
        end
        s_trace_av = nanmean(s_trace_av_mat, 2);
        clear s_trace_av_mat
        
        %finding peak in shuf-averaged trace and calculating rb ratio
        %[pk, pkf] = nanmax(s_trace_av);
        %pkf = pkf(1, 1); % appears to be unused; commenting out for now
        ridge_int = (nansum(s_trace_av( (pk_f - ridge_h_width_f):(pk_f + ridge_h_width_f) )));
        ridge_int = ridge_int./(2.*ridge_h_width_f + 1);                                    %normalising by number of points considered
        trace_x = s_trace_av;
        trace_x((pk_f - ridge_h_width_f):(pk_f + ridge_h_width_f)) = [];
        bk_int = nansum(trace_x);
        temp = isnan(trace_x);                                  %entirety of the rest of the trace used as background
        bk_int = bk_int./(length(trace_x) - sum(temp));         %normalising by number of points considered
        rrb_ratio_vec(1, iter_r) = ridge_int./abs(bk_int);
        
    end
    rrb_ratio_vec_final(1, cell_noi) = nanmean(rrb_ratio_vec);
    
    timeCells = []; % Have to populate
    
    if (mod(cell_noi, 10) == 0) && cell_noi ~= size(dff_data_mat,1)
        fprintf('... %i cells examined ...\n', cell_noi)
    end
    
end
time = [];
mehrabOutput.Q = rrb_ratio_vec_final;
mehrabOutput.T = time;
mehrabOutput.timeCells = timeCells;
end