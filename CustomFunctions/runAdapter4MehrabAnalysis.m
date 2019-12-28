%runAdapter4MehrabAnalysis
%Written by Kambadur Ananthamurthy

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

%Change of hands
% !! Requires further thought; currently just trying to run the code !!
learned = 1;
blink_list = ones(size(realProcessedData.dfbf, 2), 1); %Setting blink_list = 1 for all trials
learned_list = [learned_list; learned]; %!! Handle this better !!
blink_trials = find(blink_list == 1);
%Trial specifics
CS_onset_frame = trialDetails.frameRate*trialDetails.preDuration + 1;
US_onset_frame = floor(trialDetails.frameRate * ...
    (trialDetails.preDuration + ...
    trialDetails.csDuration + ...
    trialDetails.traceDuration)) + 1;
frame_time = 1000/trialDetails.frameRate;