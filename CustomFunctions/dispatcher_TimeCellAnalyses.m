%"Dispatcher" by Kambadur Ananthamurthy
% This code uses actual dfbf curves from my data and analyses it for time
% cells using multiple methods
% Currently this is being tested for single session data. I will test with a
% batch, soon.

tic
clf
close all

%% Addpaths
addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions')) % my custom functions
addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis')) % Additional functions
addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis/Suite2P-ananth'))
addpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis/Suite2P-ananth/localCopies')

%% Dataset
make_db
ops0.fig                       = 1;
ops0.saveData                  = 1;
ops0.onlyProbeTrials           = 0;
ops0.loadSyntheticData         = 1;

if ops0.loadSyntheticData
    setupSyntheticDataParameters
end

%% Figure details
if ops0.fig
    figureDetails = compileFigureDetails(20, 2, 10, 0.5, 'hot'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
end

%% Main script
for iexp = 1:length(db)
    fprintf('Analyzing %s_%i_%i - Date: %s\n', db(iexp).mouse_name, ...
        db(iexp).sessionType, ...
        db(iexp).session, ...
        db(iexp).date)
    saveDirec = '/Users/ananth/Desktop/Work/Analysis/Imaging/';
    saveFolder = [saveDirec db(iexp).mouse_name '/' db(iexp).date '/'];
    
    if ops0.loadSyntheticData
        load([saveFolder ...
            'synthDATA' ...
            '_pTC' num2str(percentTimeCells) ...
            '_cO' lower(cellOrder) ...
            '_mPHT' num2str(maxPercentHitTrials) ...
            '_hTA' lower(hitTrialAssignment) ...
            '_tO' lower(trialOrder) ...
            '_eW' num2str(eventWidth{1}) ...
            '_eAF' eventAmplificationFactor ...
            '_eT' lower(eventTiming) ...
            '_sF' num2str(startFrame) ...
            '_eF' num2str(endFrame) ...
            '_iFWHM' num2str(imprecisionFWHM) ...
            '_iT' lower(imprecisionType) ...
            '_n' lower(noise) ...
            '_np' num2str(noisePercent) ...
            '.mat']);
        myData.dfbf = syntheticDATA;
        myData.baselines = zeros(size(syntheticDATA));
        myData.dfbf_2D = syntheticDATA_2D;
    else
        %Load processed data (processed dfbf for dataset/session)
        myData = load([saveFolder db(iexp).mouse_name '_' db(iexp).date '.mat']);
    end
    trialDetails = getTrialDetails(db(iexp));
    
    %Significant-Only Traces
    if ops0.onlyProbeTrials
        disp('Only analysing Probe Trials ...')
        dfbf_sigOnly = findSigOnly(myData.dfbf(:, iProbeTrials, :));
    else
        dfbf_sigOnly = findSigOnly(myData.dfbf);
    end
    
    %I -Mehrab's Reliability Analysis (Bhalla Lab)
    runAdapter4MehrabAnalysis;
    
    DATA = dfbf_sigOnly;
    [rrb_ratio_vec_final, timeCells_Mehrab] = runMehrabReliabilityAnalysis(learned_only, bk_period_control, non_ov_trials, early_only, ...
        DATA, CS_onset_frame, US_onset_frame, frame_time, r_iters);
    
    %Save Analysis Output from Mehrab's method
    save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_mehrabAnalysis.mat' ], ...
        'rrb_ratio_vec_final', 'timeCells_Mehrab')
    
    %II - William Mau's Temporal Information (Eichenbaum Lab)
    [Isec, Ispk, timeCells_Eichenbaum] = runMauTIAnalysis(DATA);
    
    %Save Analysis Output from William's method
    save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_williamAnalysis.mat' ], ...
        'Isec', 'timeCells_Eichenbaum')
    
    %% Things to do
    % 1. NOTE: The list of timeCells has to be populated for each case. I need to design a classifier
    
    % 2. Collator to combine and compare the outputs
    
    %{
    %Combined save
    if ops0.saveData == 1
        save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_multipleAnalysisMethods.mat' ], ...
            'rrb_ratio_vec_final', 'timeCells_Mehrab', ...
            'Isec', 'timeCells_Eichenbaum')
    end
    %}
    %% Figures
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