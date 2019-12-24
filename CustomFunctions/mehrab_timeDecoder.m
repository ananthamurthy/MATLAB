%Wrapper by Kambadur Ananthamurthy
%time_decoder.m written by Mehrab Modi (Bhalla Lab)

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
learned_only = 2;        %1 - use only datasets for animals that have learned the task 0 - use all datasets in list, 2 - analyses only non-learner datasets
Ca_width = 250;          %in ms
stimOI = 1;              %stimulus of interest - 1 = tone, 2 = puff (useful with pseudorand datasets)
unique_tr_sets = 1;      %1 - unique lists of trials for kernel calculation and decoder testing. 0 - same set of trials for both
bk_period_control = 0;   %0 - analyses tone-puff period, 1 - analyses background period
vec_sim_measure = 2;     %1 - uses Pearson's correlation coeff to comapre single frame pop vec with kernels, 2 - uses vector dot product, 3 - uses RMS error
saving = 0;              %0 - doesnt write scores to file; 1 - writes scores to file (remember to change filename!)
score_method = 1;        %1 - original scoring, with penalties; 2 - simple scoring, only distance from correct frame

saved_pk_times = [];
saved_scores = [];
saved_scores_i = [];
learned_list = [];
iter = 0;
all_scores = [];
recorded_preds = [];

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
        pre_clip = -3000;
        post_clip = 5000;
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
    
    %using only cells with high rel. scores
    %kernel_width = 4;
    %cell_no_fraction = .5;          %fraction of cell-population to use
    %[cell_lists] = rel_score_cell_frac(dff_data_mat, pk_behav_trial, kernel_width, cell_no_fraction, CS_onset_frame, US_onset_frame, frame_time);
    %cell_list = find(cell_lists(:, 2) == 1);
    
    for cell_noi = 1:length(cell_list)
        cell_no = cell_list(cell_noi);
        traces = squeeze(dff_data_mat(CS_onset_frame:(US_onset_frame-1), cell_no, :));
        pks = nanmax(traces);
        pk_list_t(cell_noi, 1) = mean(pks);
        pk_list_t(cell_noi, 2) = std(pks);
    end
    
    
    %making lists of trials for kernel caluclation and for testing decoder
    if unique_tr_sets == 1
        trial_list_kernel = (pk_behav_trial - 5):2:no_trials;
        trial_list_test = (pk_behav_trial - 4):2:no_trials;
    elseif unique_tr_sets == 0
        trial_list_kernel = (pk_behav_trial - 5):no_trials;
        trial_list_test = (pk_behav_trial - 5):no_trials;
    end
    
    
    %calculating kernels for each cell - with overlapping or non-overlapping trials
    kernels = nanmean(dff_data_mat(CS_onset_frame:US_onset_frame, cell_list, trial_list_kernel), 3);
    
    
    %normalising each kernel and thresholding
    thresh = .7;
    kernels_nt = zeros(size(kernels));
    for cell_no = 1:size(kernels, 2);
        kernels_nt(:, cell_no) = kernels(:, cell_no)./max(kernels(:, cell_no));
        pk_list(1, cell_no) = max(kernels(:, cell_no));
    end
    temp = find(kernels_nt < thresh);
    kernels_nt(temp) = 0;

    %time decoder
    err_mat = zeros(size(kernels, 1), length(trial_list_test)) + nan;
    err_mat_r = zeros(size(kernels, 1), length(trial_list_test)) + nan;
    pred_score_mat = zeros(size(kernels, 1), length(trial_list_test)) + nan;
    pred_score_mat_r = zeros(size(kernels, 1), length(trial_list_test)) + nan;
    saved_scorevec_mat = [];
    for trial_noi = 1:length(trial_list_test)
        trial_no = trial_list_test(trial_noi);          %ensuring ability to use non-overlapping sets of trials for kernel calc. and testing decoder
        for frame_no = 1:size(kernels, 1);
            data = squeeze(dff_data_mat((frame_no + CS_onset_frame - 1 ), cell_list, trial_no));
            
            %normalising to typical pk and thresholding to identify only active cells
            data = data./pk_list_t(:, 1)';                 %normalising
            a = find(data < thresh);                       %thresholding
            data(a) = 0;
            temp = isnan(data);
            temp = find(temp == 1);
            data(temp) = 0;
            
            %calculating correlation coefficient with each frame's
            %kernel representation
            score_vec = zeros(size(kernels, 1), 1);
            for cr_frame_no = 1:size(kernels, 1)
                if vec_sim_measure == 1     %corr-coeff as measure of similarity
                    score_vec(cr_frame_no, 1) = corr(kernels_nt(cr_frame_no, :)', data');
                elseif vec_sim_measure == 2 %normalised vector dot product as measure of similarity
                    score_vec(cr_frame_no, 1) = (kernels_nt(cr_frame_no, :)./norm(kernels_nt(cr_frame_no, :)) )*(data./norm(data))';
                elseif vec_sim_measure == 3 %RMSE as measure of similarity
                    score_vec(cr_frame_no, 1) = sqrt((sum((kernels_nt(cr_frame_no) - data).^2))./length(data));
                    score_vec = max(score_vec) - score_vec;
                else
                end
            end
            
            %saving all score vecs, after normalising them
            score_veci = score_vec./max(score_vec);
            if isempty(saved_scorevec_mat) == 1
                saved_scorevec_mat(:, 1, frame_no) = score_veci;
            elseif trial_no == trial_noi
                saved_scorevec_mat(:, (size(saved_scorevec_mat, 2) ), frame_no) = score_veci;
            elseif trial_no ~= trial_noi
                saved_scorevec_mat(:, (size(saved_scorevec_mat, 2) + 1), frame_no) = score_veci;
            end
            trial_noi = trial_no;
            
            clear diff
         
            %assigning prediction score for each frame proportionate to
            %its correlation value calculated above. the total score
            %given in each trial (prior to weighting by distance from true frame)
            %is the same.
            score_veci = score_vec;
            temp = find(score_vec < 0);
            score_vec(temp) = 0;
            temp = isnan(score_vec);
            temp = find(temp == 1);
            score_vec(temp) = 0;
            tot_score = nansum(score_vec);
            score_vec_norm = score_vec./tot_score;
            
            
            [del, pred_fi] = nanmax(score_vec);
            recorded_preds = [recorded_preds; frame_no, pred_fi];
            
            
            
            %scores for each frame being weighted by distance
            %from actual frame (actual frame's weight is 0)
            dist_vec = zeros(size(kernels, 1), 1);
            for frame_i = 1:size(kernels, 1)
                dist_vec(frame_i, 1) = abs(frame_no - frame_i);
            end
            temp = find(dist_vec < 3);
            dist_vec(temp) = 0;
            dist_vec = dist_vec.*3;
            score_vec_normw = score_vec_norm.*dist_vec;         %weighting scores by distance from correct frame
            
            
            if score_method == 1
                pred_score = score_vec_norm(frame_no).*sum(dist_vec);
                err_score = sum(score_vec_normw);
            elseif score_method == 2
                [scrap, frame_i] = nanmax(score_vec_norm);
                
                if abs(frame_no - frame_i) > 3
                    pred_score = abs(frame_no - frame_i);           %using distance of 'guessed frame' from true frame as an error score
                elseif abs(frame_no - frame_i) < 4
                    pred_score = 0;
                else
                end
                
                err_score = 1;                                  %the main score is itself an error score - this one is forced to 1 so as to have no effect on performance score
            else
            end
            
            pred_score_mat(frame_no, trial_no) = pred_score;
            err_mat(frame_no, trial_no) = err_score;
            
            
            
            %random predictor as control - generated by randomly
            %re-arranging the corr-coeffs obtained
            err_score_r_vec = zeros(1, 500);
            for iter_r = 1:500
                score_vec_norm_r = [randperm(length(score_vec))', score_vec_norm];
                score_vec_norm_r = sortrows(score_vec_norm_r);
                score_vec_norm_r = score_vec_norm_r(:, 2);
                score_vec_normw_r = score_vec_norm_r.*dist_vec;
                
                if score_method == 1
                    err_score_r_vec(1, iter_r) = sum(score_vec_normw_r);
                    pred_score_r_vec(1, iter_r) = score_vec_norm_r(frame_no).*sum(dist_vec);
                elseif score_method == 2
                    [scrap frame_i] = nanmax(score_vec_norm_r);
                    if abs(frame_no - frame_i) > 3
                        pred_score_r_vec(1, iter_r) = abs(frame_no - frame_i);
                    elseif abs(frame_no - frame_i) < 4
                        pred_score_r_vec(1, iter_r)= 0;
                    else
                    end
                    
                    err_score_r_vec(1, iter_r) =  1;
                    
                else
                end
            end
            
            pred_score_mat_r(frame_no, trial_no) = nanmean(pred_score_r_vec);
            err_mat_r(frame_no, trial_no) = nanmean(err_score_r_vec);
            
            
            clear dist_vec
            
        end
    end
    perf_mat = pred_score_mat./err_mat;
    perf_mat_r = pred_score_mat_r./err_mat_r;
    
    temp = isinf(perf_mat);
    temp = find(temp == 1);
    perf_mat(temp) = nan;
    
    temp = isinf(perf_mat_r);
    temp = find(temp == 1);
    perf_mat_r(temp) = nan;
    
    means = [nanmean(reshape(pred_score_mat, 1, [])), nanmean(reshape(pred_score_mat_r, 1, []))];
    
    %       figure(3)
    means = [nanmean(reshape(perf_mat, 1, [])), nanmean(reshape(perf_mat_r, 1, []))];
    no_entries = isnan(perf_mat);
    no_entries = find(no_entries == 0);
    no_entries = length(no_entries);
    ses = [nanstd(reshape(perf_mat, 1, [])), nanstd(reshape(perf_mat_r, 1, []))]./sqrt(no_entries);

    saved_scores = [saved_scores;(means(1)./means(2) ), p, means(1), means(2), ses(1), ses(2), dir_counter ];
    
    all_scores = [all_scores; [reshape(perf_mat, [], 1), reshape(perf_mat_r, [], 1)]];      %saved decoder performance scores, and randomised control scores
    
    clear err_mat
    clear err_mat_r
end
toc
disp('All done!')