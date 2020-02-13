%"Dispatcher" by Kambadur Ananthamurthy
% This code uses actual dfbf curves from my data and analyses it for time
% cells using multiple methods
% Currently this is being tested for single session data. I will test with a
% batch, soon.

tic
clf
clear
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
            '_aE2NTC' num2str(addEvents2NonTimeCells) ...
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
    
    %% Analysis Pipelines
    %I -Mehrab's Reliability Analysis (Bhalla Lab)
    runAdapter4MehrabAnalysis;
    
    DATA = dfbf_sigOnly;
    [reliability_mehrab, timeCells_Mehrab] = runMehrabReliabilityAnalysis(learned_only, ...
        bk_period_control, non_ov_trials, early_only, pk_behav_trial, ...
        dff_data_mat, CS_onset_frame, US_onset_frame, ridge_h_width, ...
        frame_time, r_iters);
    
    %Save Analysis Output from Mehrab's method
    save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_mehrabAnalysis.mat' ], ...
        'reliability_mehrab', 'timeCells_Mehrab')
    
    %II - William Mau's Temporal Information (Eichenbaum Lab)
    %[Isec, Ispk, timeCells_Eichenbaum] = runMauTIAnalysis(DATA);
    [Isec, reliability_william, timeCells_Eichenbaum] = runMauTIAnalysis(DATA);
    %Save Analysis Output from William's method
    save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_williamAnalysis.mat' ], ...
        'Isec', 'timeCells_Eichenbaum')
    
    %% Second Order Stats to compare the outputs
    
    %Normalize the "reliability" vectors ignoring "Inf"
    reliability_mehrab_norm = reliability_mehrab./max(reliability_mehrab(~isinf(reliability_mehrab)));
    reliability_william_norm = reliability_william./max(reliability_william);
    
    % 1 - Dot product
    dotProduct = dot(reliability_mehrab_norm, reliability_william_norm);
    
    % 2 - RMS
    rms_mehrab = rms(reliability_mehrab_norm);
    rms_william = rms(reliability_william_norm);
    
    % 3 - Scatter plot
    if ops0.fig == 1
        figure(1)
        clf
        scatter(reliability_william_norm, reliability_mehrab_norm);
        title(['R2BR vs TI | ', ...
            db(iexp).mouse_name ' ST' num2str(db(iexp).sessionType) ' S' num2str(db(iexp).session) ' | ' ...
            num2str(trialDetails.frameRate) ' Hz'], ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
        xlabel('Temporal Information', ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
        ylabel('Ridge/Background Ratio', ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
        set(gca,'FontSize', figureDetails.fontSize-3)
        
        if ops0.loadSyntheticData
            print(['/Users/ananth/Desktop/figs/multipleTCA/multipleTCA_normScatter_' ...
                db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_synthData'],...
                '-djpeg');
        else
            print(['/Users/ananth/Desktop/figs/multipleTCA/multipleTCA_normScatter_' ...
                db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session)],...
                '-djpeg');
        end
    end
    
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
        figure(2)
        clf
        plot(ones(length(reliability_mehrab)), 'k--')
        hold on
        plot(reliability_mehrab, 'g*')
        hold off
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
        
        if ops0.loadSyntheticData
            print(['/Users/ananth/Desktop/figs/multipleTCA/multipleTCA_mehrab_' ...
                db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_synthData'],...
                '-djpeg');
        else
            print(['/Users/ananth/Desktop/figs/multipleTCA/multipleTCA_mehrab_' ...
                db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session)],...
                '-djpeg');
        end
        
        
        figure(3)
        clf
        plot(reliability_william, 'b*')
        hold on
        plot(Isec, 'r*')
        hold off
        title(['William - Temporal Information | ', ...
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
        
        if ops0.loadSyntheticData
            print(['/Users/ananth/Desktop/figs/multipleTCA/multipleTCA_william_' ...
                db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_synthData'],...
                '-djpeg');
        else
            print(['/Users/ananth/Desktop/figs/multipleTCA/multipleTCA_william_' ...
                db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session)],...
                '-djpeg');
        end
    end
end
toc