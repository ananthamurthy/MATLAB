%"Dispatcher" by Kambadur Ananthamurthy
% This code uses actual dfbf curves from my data and analyses it for time
% cells using multiple methods
% Current this is being tested for single session data. I will test with a
% batch, soon.

tic
addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions')) % my custom functions
addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis')) % Additional functions
addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis/Suite2P-ananth'))

%% Dataset
make_db
%ops0.method   = 'C'; % A: only PSTH; B: PSTH then filter; C: filter then PSTH; use 'C'
ops0.fig      = 1;
ops0.saveData = 1;

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
    
    %Mehrab's Reliability Analysis
    %Change of hands
    % !! Requires further thought; currently just trying to run the code !!
    learned = 1;
    blink_list = ones(size(realProcessedData.dfbf,2),1); %Setting blink_list = 1 for all trials
    learned_list = [learned_list; learned]; %!! Handle this better !!
    blink_trials = find(blink_list == 1);
    
    [rrb_ratio_vec_final, timeCells_Mehrab] = runMehrabReliabilityAnalysis(learned_only, bk_period_control, realProcessedData);
    
    %William Mau's Temporal Information (Eichenbaum)
    [Ispk, timeCells_Eichenbaum] = runMauTIAnalysis(db, ops0, realProcessedData);
    
    if ops0.save == 1
        save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_multipleAnalysisMethods.mat' ], ...
            'rrb_ratio_vec_final', 'timeCells_Mehrab', ...
            'Ispk', 'timeCells_Eichenbaum')
    end
end