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
ops0.method          = 'C'; % A: only PSTH; B: PSTH then filter; C: filter then PSTH; use 'C'
ops0.fig             = 1;
ops0.saveData        = 1;
ops0.onlyProbeTrials = 0;

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
    
    %Significant-Only Traces
    if ops0.onlyProbeTrials
        disp('Only analysing Probe Trials ...')
        dfbf_sigOnly = findSigOnly(realProcessedData.dfbf(:, iProbeTrials, :));
    else
        dfbf_sigOnly = findSigOnly(realProcessedData.dfbf);
    end
    
    %Mehrab's Reliability Analysis (Bhalla)
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
    
    DATA = dfbf_sigOnly;
    [rrb_ratio_vec_final, timeCells_Mehrab] = runMehrabReliabilityAnalysis(learned_only, bk_period_control, non_ov_trials, early_only, ...
        DATA, CS_onset_frame, US_onset_frame, frame_time, r_iters);
    
    %William Mau's Temporal Information (Eichenbaum)
    [Isec, timeCells_Eichenbaum] = runMauTIAnalysis(DATA);
    
    if ops0.save == 1
        save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_multipleAnalysisMethods.mat' ], ...
            'rrb_ratio_vec_final', 'timeCells_Mehrab', ...
            'Ispk', 'timeCells_Eichenbaum')
    end
    
    if ops0.fig == 1
        figure(1)
        plot(rrb_ratio_vec_final, 'g*')
        title(['Mehrab - Ridge/Background Ratios | ', ...
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
        
        figure(2)
        plot(Ispk, 'b*')
        hold on
        plot(Isec, 'ro')
        title(['Eichenbaum - Temporal Information | ', ...
            db(iexp).mouse_name ' ST' num2str(db(iexp).sessionType) ' S' num2str(db(iexp).session) ' | '...
            num2str(trialDetails.frameRate) ' Hz | '...
            '3 frames/bin'] , ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
        xlabel('Cells', ...
            'FontSize', figureDetails.fontSize,...
            'FontWeight', 'bold')
        %set(gca,'YTick',[10, 20, 30, 40, 50, 60])
        %set(gca,'YTickLabel',({10; 20; 30; 40; 50; 60}))
        ylabel('Information - blue: bits/spike | red: bits/sec)', ...
            'FontSize', figureDetails.fontSize,...
            'FontWeight', 'bold')
        set(gca,'FontSize', figureDetails.fontSize-3)
    end
end
toc