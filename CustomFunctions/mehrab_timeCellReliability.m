%Wrapper by Kambadur Ananthamurthy
%rel_score_cal.m written by Mehrab Modi (Bhalla Lab)

tic
addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions')) % my custom functions
addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis')) % Additional functions
addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis/Suite2P-ananth'))

%% Dataset
make_db
ops0.method   = 'C'; % A: only PSTH; B: PSTH then filter; C: filter then PSTH; use 'C'
ops0.fig      = 1;
if ops0.fig
    figureDetails = compileFigureDetails(20, 2, 10, 0.5, 'hot'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
end

% Method specifics from Mehrab's code
pretr_control = 1;         %0 - analyses control no puff datasets, 1 - analyses training (trace or pseudo) datasets
learned_only = 0;        %1 - use only datasets for animals that have learned the task 0 - use all datasets in list, 2 - analyses only non-learner datasets
Ca_width = 250;          %in ms
stimOI = 1;              %stimulus of interest - 1 = tone, 2 = puff (useful with pseudorand datasets)
bk_period_control = 0;   %0 - analyses tone-puff period, 1 - analyses background period
r_iters = 5000;           %number of iterations of randomisation used to find averaged r-shifted rb ratio - might have to go as high as 3000.
non_ov_trials = 1;       %1 - non-overlapping trial sets used for kernel estimation and rb ratio calculation, 0 - all trials used for both
early_only = 0;          %0 - uses all trials; 1 - uses only the first 5 trials of the session

learned_list   = [];
saved_scores   = [];
all_scores     = [];
saved_pk_times = [];
for iexp = 1:length(db)
    fprintf('Analyzing %s_%i_%i - Date: %s\n', db(iexp).mouse_name, ...
        db(iexp).sessionType, ...
        db(iexp).session, ...
        db(iexp).date)
    saveDirec = '/Users/ananth/Desktop/Work/Analysis/Imaging/';
    saveFolder = [saveDirec db(iexp).mouse_name '/' db(iexp).date '/'];
    
    %Load processed data (processed dfbf for dataset/session)
    realProcessedData = load([saveFolder db(iexp).mouse_name '_' db(iexp).date '_' ops0.method '.mat']);
    trialDetails = getTrialDetails(db(iexp));
    
    %Change of hands
    % !! Requires further thought; currently just trying to run the code !!
    learned = 1;
    blink_list = ones(size(realProcessedData.dfbf,2),1); %Setting blink_list = 1 for all trials
    learned_list = [learned_list; learned];
    blink_trials = find(blink_list == 1);
    
    %condition to use only animals that learned the task
    if learned_only == 1 %operation
        if learned == 0 %data dependent
            continue
        elseif learned == 1
            
        end
    elseif learned_only == 0 %opeartion: analyses all trials
    elseif learned_only == 2
        if learned == 1
            continue
        elseif learned == 0
        end
    elseif learned_only == 4            %used to make a list of learners
        if learned == 1
            learned_listi = [learned_listi; dir_counter];
        else
        end
        continue
    end
    
    %CLIPPING data near point of interest (tone or puff)
    if bk_period_control == 0
        pre_clip = 2000; %2 seconds, I think; change to 8?
        post_clip = 2000; %2 seconds, I think; change to 8?
    elseif bk_period_control == 1
        pre_clip = -4000;
        post_clip = 6000;
    end
    
    % Skipping this section since I already have my dfbf data ready
    %     [raw_data_mat no_frames CS_onset_frame US_onset_frame] = rand_raw_data_clipper(raw_data_mat, set_type,...
    %         stimOI, rand_times_list, pre_clip, post_clip, frame_time, CS_onset_frame, US_onset_frame, CS_US_delay, bk_period_control);
    %     %calculating dF/F and suppressing peaks of width lesser than Ca_width
    %     [dff_data_mat dffdata_peaks] = dff_maker(raw_data_mat, frame_time, Ca_width);
    %     %sanitising data based on no. of infs/nans
    %     [dff_data_mat dff_data_mat_orig dffdata_peaks dffdata_peaks_orig trial_type_vec bad_cellsi] = imaging_data_sanitiser(dff_data_mat, dffdata_peaks, trial_type_vec);
    %     sanit_ratio = ((size(dff_data_mat, 1).* size(dff_data_mat, 2).* size(dff_data_mat, 1))./(size(dff_data_mat_orig, 1).* size(dff_data_mat_orig, 2).* size(dff_data_mat_orig, 1)));
    %     no_cells = size(dff_data_mat, 2);
    %     no_trials_orig = no_trials;
    %     no_trials = size(dff_data_mat, 3);
    %     if no_cells < 5
    %         continue
    %     elseif no_trials_orig - no_trials > (no_trials_orig./2.5)
    %         %if no_trials_orig - no_trials > (no_trials_orig./5)
    %         continue
    %     else
    %     end
    
    %list of learning trials for learners - mean used for other
    %datasets
    %     if pretr_control == 1 && learned_only == 1
    %         iter = iter + 1;
    %         pk_list = [22, 23, 27, 29, 22, 23];
    %         pk_behav_trial = pk_list(1, iter);
    %     elseif pretr_control == 0 && learned_only == 1
    %         pk_behav_trial = mean([22, 23, 27, 29, 22, 23]);
    %     elseif learned_only == 0 || learned_only == 2
    %         pk_behav_trial = mean([22, 23, 27, 29, 22, 23]);
    %     end
    
    no_cells = size(realProcessedData.dfbf,1);
    no_trials = size(realProcessedData.dfbf,2);
    cell_list = 1:1:no_cells;       %using all cells
    %establishing typical response size for each cell
    pk_list_t = zeros(length(cell_list), 2);
    dff_data_mat = permute(realProcessedData.dfbf, [3 1 2]);
    pk_behav_trial = 1; %Short-circuit. !! Have to verify if logic is sound !!
    %Trial specifics
    CS_onset_frame = trialDetails.frameRate*trialDetails.preDuration + 1;
    US_onset_frame = floor(trialDetails.frameRate * ...
        (trialDetails.preDuration + ...
        trialDetails.csDuration + ...
        trialDetails.traceDuration)) + 1;
    frame_time = 1000/trialDetails.frameRate;
    
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
        t_tr_list = (pk_behav_trial + 1):2:no_trials;
        
        kernels = nanmean(dff_data_mat(:, cell_list, k_tr_list), 3);
        dff_data_mat(:, :, k_tr_list) = nan;    %making sure kernel estimation trials not used for rb ratio calculation
    else
    end
    
    kernels_nt = kernels;
    kernels_e = nanmean(dff_data_mat(:, cell_list, 1:5), 3);  %for early trials only
    
    %finding peaks of activity for each cell
    if early_only == 0
        [pks, pki] = nanmax(kernels_nt(CS_onset_frame:(US_onset_frame + floor(200./frame_time)), :), [], 1);
    elseif early_only == 1
        [pks, pki] = nanmax(kernels_e(CS_onset_frame:(US_onset_frame + floor(200./frame_time)), :), [], 1);
    else
    end
    
    ridge_h_width = 100;    %in ms
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
            [pk pkf] = nanmax(s_trace_av);
            pkf = pkf(1, 1);
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
        
        if (mod(cell_noi, 10) == 0) && cell_noi ~= size(realProcessedData.dfbf,1)
            fprintf('... %i cells examined ...\n', cell_noi)
        end
        
    end
    saveDirec = '/Users/ananth/Desktop/Work/Analysis/Imaging/';
    saveFolder = [saveDirec 'M26/20180514/'];
    save([saveFolder 'M26_20180514_comparingTIwithR2B.mat'], 'rrb_ratio_vec_final')
    
    %     means = [nanmean(reshape(rb_ratio_vec, [], 1)), nanmean(reshape(rrb_ratio_vec_final, [], 1))];
    %     ses = [nanstd(reshape(rb_ratio_vec, [], 1)), nanstd(reshape(rrb_ratio_vec_final, [], 1))];
    %
    %     n_list = isnan(rb_ratio_vec);
    %     n_list = find(n_list == 0);
    %     ses(1, 1) = ses(1, 1)./sqrt(length(n_list));
    %
    %     n_list = isnan(rrb_ratio_vec_final);
    %     n_list = find(n_list == 0);
    %     ses(1, 2) = ses(1, 2)./sqrt(length(n_list));
    %
    %
    %     saved_scores = [saved_scores; [means(1, 1), means(1, 2), ses(1, 1), ses( 1, 2), p, h] ];
    %
    %     all_scores = [all_scores, [rb_ratio_vec; rrb_ratio_vec_final] ];        %matrix containing ridge to background ratios
    %
    %     %list of pk times - to plot distributions
    %     pk_times = pki.*frame_time;
    %     saved_pk_times = [saved_pk_times, pk_times];
    
    figure(1)
    plot(rrb_ratio_vec_final, 'g*')
    title(['Ridge/Background Ratios | ', ...
        db(iexp).mouse_name ' ST' num2str(db(iexp).sessionType) ' S' num2str(db(iexp).session) ' | ' ...
        num2str(trialDetails.frameRate) ' Hz'], ...
        'FontSize', figureDetails.fontSize, ...
        'FontWeight', 'bold')
    xlabel('Cells', ...
        'FontSize', figureDetails.fontSize,...
        'FontWeight', 'bold')
    %set(gca,'YTick',[10, 20, 30, 40, 50, 60])
    %set(gca,'YTickLabel',({10; 20; 30; 40; 50; 60}))
    ylabel('Ridge/Background Ratio', ...
        'FontSize', figureDetails.fontSize,...
        'FontWeight', 'bold')
    set(gca,'FontSize', figureDetails.fontSize-3)
end
toc
disp('All done!')