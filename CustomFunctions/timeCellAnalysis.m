% TITLE - Custom code to Identify Time Cell Sequences, if any
% AUTHOR - Kambadur Ananthmurthy

% Additional functions may be found in "CustomFunctions"
%profile on
tic
disp('Analyzing for Time Cells ...')
close all
%clear all
clear

%% Addpaths
addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions')) % my custom functions
addpath(genpath('/Users/ananth/Desktop/Work/Analysis/Imaging')) % analysis output
addpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis/Suite2P-ananth/localCopies')
%% Operations
ops0.multiDayAnalysis       = 0; %For chronic tracking experiments; usually set to 0
ops0.fig                    = 1;
ops0.method                 = 'C'; % A: only PSTH; B: PSTH then filter; C: filter then PSTH; use 'C'
ops0.saveData               = 0;
ops0.search4lowFreqEvents   = 0;
ops0.bandpassFilter         = 0;
ops0.loadBehaviourData      = 0;
ops0.onlyProbeTrials        = 0;
%% Dataset
make_db
%% Main script
for iexp = 1:length(db)
    fprintf('Analyzing %s_%i_%i - Date: %s\n', db(iexp).mouse_name, ...
        db(iexp).sessionType, ...
        db(iexp).session, ...
        db(iexp).date)
    
    saveDirec = '/Users/ananth/Desktop/Work/Analysis/Imaging/';
    saveFolder = [saveDirec db(iexp).mouse_name '/' db(iexp).date '/'];
    
    %Load Fluorescence Data
    load(sprintf('/Users/ananth/Desktop/Work/Analysis/Imaging/%s/%s/%i/F_%s_%s_plane%i.mat', ...
        db(iexp).mouse_name, db(iexp).date, db(iexp).expts, ...
        db(iexp).mouse_name, db(iexp).date, db(iexp).nplanes))
    
    %Registration Options
    load(sprintf('/Users/ananth/Desktop/Work/Analysis/Imaging/%s/%s/%i/regops_%s_%s.mat', ...
        db(iexp).mouse_name, db(iexp).date, db(iexp).expts, ...
        db(iexp).mouse_name, db(iexp).date))
    
    %Load Behaviour Data
    if ops0.loadBehaviourData == 1
        load(sprintf('/Users/ananth/Desktop/Work/Analysis/Behaviour/FEC/%s/%s_%i_%i/fec.mat', ...
            db(iexp).mouse_name, db(iexp).mouse_name, db(iexp).sessionType, db(iexp).session))
        iProbeTrials = find(probeTrials);
    end
    
    if ops0.fig
        figureDetails = compileFigureDetails(20, 2, 10, 0.5, 'hot'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
    end
    
    trialDetails = getTrialDetails(db(iexp)); %test
    
    if ops0.multiDayAnalysis
        [overlaps] = cat_overlap();
        if db(iexp).isDayOne
            newIndices = overlaps.rois.idcs(:,1);
        else
            newIndices = overlaps.rois.idcs(:,2);
        end
        myData = Fcell{1,1}(newIndices,:);
    else
        myData = Fcell{1,1};
    end
    fprintf('Total cells: %i\n', size(myData,1))
    [dfbf, baselines, dfbf_2D] = dodFbyF(db(iexp), myData);
    
    %Significant-Only Traces
    if ops0.onlyProbeTrials
        disp('Only analysing Probe Trials ...')
        dfbf_sigOnly = findSigOnly(dfbf(:,iProbeTrials,:));
    else
        dfbf_sigOnly = findSigOnly(dfbf);
    end
    
    %Search for low frequency events
    if ops0.search4lowFreqEvents
        nSamples = 10; %for Gaussian Kernel
        [dfbf_sigOnly_smooth, gaussianKernel] = doGaussianSmoothing(dfbf_sigOnly, nSamples);
%         cell = 15;
%         figure(20)
%         subplot(1,2,1)
%         surf(squeeze(dfbf_sigOnly(cell,:,:))*100)
%         title('Data | Cell 15')
%         xlabel('Frames')
%         ylabel('Trials')
%         zlabel('dF/F (%)')
%         set(gca, 'FontSize', 20)
%         
%         subplot(1,2,2)
%         surf(squeeze(dfbf_sigOnly_smooth(cell,:,:))*100)
%         title('Smoothed Data | Cell 15')
%         xlabel('Frames')
%         ylabel('Trials')
%         zlabel('dF/F (%)')
%         set(gca, 'FontSize', 20)
%         colormap summer
        %Visualize filter
        %wvtool(gaussianKernel)
        myData = dfbf_sigOnly_smooth;
    end
    
    if ops0.bandpassFilter
        sampleRate = 14.5; % Hz
        lowEnd = 3; % Hz
        highEnd = 7; % Hz
        filterOrder = 2; % Filter order (e.g., 2 for a second-order Butterworth filter). Try other values too
        [b, a] = butter(filterOrder, [lowEnd highEnd]/(sampleRate/2)); % Generate filter coefficients
        filteredData = zeros(size(dfbf_sigOnly));
        for cell = 1:size(dfbf_sigOnly,1)
            for trial = 1:size(dfbf_sigOnly,2)
                filteredData(cell,trial,:) = filtfilt(b, a, squeeze(dfbf_sigOnly(cell,trial,:))); % Apply filter to data using zero-phase filtering
            end
        end
        myData = filteredData;
    end
    
    %% Tuning and time field fidelity using PSTH
    %Area Under Curve
    %AUC = doAUC(myData(:,:,window)); %(Data, percentile)
    trialPhase = 'wholeTrial';
    window = findWindow(trialPhase, trialDetails);
    %window = 100:150;
    %skipFrames = 116; %Skip frame 116, viz., the CS frame. Use skipFrames = 0 to avoid skipping
    %skipFrames = trialDetails.preDuration * db(iexp).samplingDate;
    skipFrames = 81;
    
    %NOTE: Make sure to use significant-only traces else a second
    %threshold needs to be passed as an argument
    % PSTH based identification of tuning curves
    % Including further criteria defining time-locked cells
    % timeLockedCells is subject to modifications
    % 1. The cell should be active in more than 25% trials
    delta = 3; %for now; works out to 207 ms if sampling at 14.5 Hz
    if ops0.method == 'A' %No filtering for % of trials active
        disp('Only PSTH; not filtering for percentage of trials with activity ...')
        freqThreshold = 0; %meaningless
        [PSTH, PSTH_3D] = getPSTH(myData, delta, skipFrames);
        [timeLockedCells, TI] = getTimeLockedCells(PSTH_3D, 1000, 99);
        [cellRastor, cellFrequency, importantTrials] = getCellRastors(myData, skipFrames);
        iTimeCells = find(timeLockedCells);
    elseif ops0.method == 'B' %PSTH then filtering for % of trials active
        disp('First PSTH, then filtering for percentage of trials with activity ...')
        [PSTH, PSTH_3D] = getPSTH(myData, delta, skipFrames);
        [timeLockedCells_temp, TI] = getTimeLockedCells(PSTH_3D, 1000, 99);
        freqThreshold = 0.25 * (size(dfbf,2)); %threshold is 25% of the session trials
        [cellRastor, cellFrequency, timeLockedCells, importantTrials] = ...
            getFreqBasedTimeCellList(myData(find(timeLockedCells_temp),:,:), freqThreshold, skipFrames);
        iTimeCells = find(timeLockedCells);
        fprintf('%i time-locked cells found\n', length(iTimeCells))
    elseif ops0.method == 'C' %Filter for % trials active then PSTH
        disp('First filtering for percentage of trials with activity, then PSTH ...')
        freqThreshold = 0.25 * (size(dfbf,2)); %threshold is 25% of the session trials
        [cellRastor, cellFrequency, timeLockedCells_temp, importantTrials] = ...
            getFreqBasedTimeCellList(myData, freqThreshold, skipFrames);
        %Develop PSTH only for cells passing >25% activity
        [PSTH, PSTH_3D] = getPSTH(myData(find(timeLockedCells_temp),:,:), delta, skipFrames);
        %Finally, identifying true time-locked cells, using the TI metric
        [timeLockedCells, TI] = getTimeLockedCells(PSTH_3D, 1000, 99);
        iTimeCells = find(timeLockedCells);
        dfbf_timeLockedCells = myData(iTimeCells,:,:);
        fprintf('%i time-locked cells found\n', length(iTimeCells))
    else
    end
    %2. There should be at least two consecutive bins with significant
    %values for PSTH. TBA
    
    % Sorting
    if isempty(find(timeLockedCells,1))
        %disp('No time cells found')
        %[sortedPSTHindices, peakIndicies] = [0, 0];
        sortedPSTHindices = [];
        peakIndicies = [];
        PSTH_sorted = [];
        dfbf_sorted_timeLockedCells = [];
    else
        [sortedPSTHindices, peakIndicies] = sortPSTH(PSTH(iTimeCells,:));
        PSTH_timeLocked = PSTH(iTimeCells,:);
        PSTH_sorted = PSTH_timeLocked(sortedPSTHindices,:);
        dfbf_sorted_timeLockedCells = dfbf_timeLockedCells(sortedPSTHindices,:,:);
        %dfbf_2D_sorted_timeCells = dfbf_2D_timeLockedCells(sortedPSTHindices,:);
    end
    
    %% Data Saving for Custom section
    if ops0.saveData
        disp('Saving data ...')
        if ~isdir(saveFolder)
            mkdir(saveFolder);
        end
        if ops0.multiDayAnalysis
            save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_' ops0.method '_multiDay.mat' ], ...
                'dfbf', 'baselines', 'dfbf_2D', ...
                'dfbf_timeLockedCells', ...
                'dfbf_sorted_timeLockedCells', ...
                'trialPhase', 'window', ...
                'threshold', ...
                'cellRastor', 'cellFrequency', 'timeLockedCells', 'importantTrials', ...
                'PSTH')
        else
            save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_' ops0.method '.mat' ], ...
                'dfbf', 'baselines', 'dfbf_2D', ...
                'dfbf_timeLockedCells', ...
                'dfbf_sorted_timeLockedCells', ...
                'trialPhase', 'window', ...
                'threshold', ...
                'cellRastor', 'cellFrequency', 'timeLockedCells', 'importantTrials', ...
                'PSTH')
        end
        disp('... done!')
    end
    
    %% Plots
    if ops0.fig
        disp('Plotting data ...')
        
        % PSTH
        fig1 = figure(1);
        clf
        set(fig1,'Position',[300,300,1200,500])
        subFig1 = subplot(1,2,1);
        plotPSTH(db(iexp), PSTH(iTimeCells,:,:), trialDetails, 'Bin No.', 'Unsorted Cells', figureDetails, 1)
        subFig2 = subplot(1,2,2);
        plotPSTH(db(iexp), PSTH_sorted, trialDetails, 'Bin No.', 'Sorted Cells', figureDetails, 1)
        colormap(figureDetails.colorMap)
        
        if ops0.multiDayAnalysis
            print(['/Users/ananth/Desktop/figs/psth/psth_' ...
                db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method '_multiDay'],...
                '-djpeg');
        else
            print(['/Users/ananth/Desktop/figs/psth/psth_' ...
                db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method],...
                '-djpeg');
        end
        
        % Sorting based Sequences - plotting
        %         csFrame = 116;
        %         xTicks = window;
        %         %xLabels = strtrim(cellstr(num2str(window'))');
        %         xLabels = cellstr(num2str(window'))';
        %             clear window %for sanity
        %             window = 80:160;
        %             xTicks = [0 18 36 54 72];
        %             %xTicks = 0:4:window(1);
        %             %automate x label generation
        %             %actualXlabels = ((window(1):4:window(end))-csFrame)*69; %Since the frame rate is 14.5 Hz (each frame = 69 ms)
        %             %temp = cellfun(@num2str,num2cell(actualXlabels(:)),'uniformoutput',false);
        %             %temp2 = strjoin(arrayfun(@(actualXlabels) num2str(actualXlabels),n,'UniformOutput',false),',');
        %             %xLabels = {'-2484', '-2208', '-1932', '-1656', '-1380', '-1104', '-828', '-552', '-276', '0', '276', '552', '828', '1104','1380', '1656', '1932', '2208', '2484', '2760', '3036'};
        %             xLabels = {'-2484', '-1242', '0', '1242', '2484' };
        %         fig2 = figure(2);
        %         set(fig2,'Position', [300, 300, 1200, 500]);
        %         subplot(1,2,1);
        %         %plot unsorted data
        %         plotSequences(db(iexp), dfbf_timeLockedCells, trialPhase, 'Frames', 'Unsorted Cells', figureDetails, 1)
        %         colormap(figureDetails.colorMap)
        %
        %         subplot(1,2,2);
        %         %plot sorted data
        %         plotSequences(db(iexp), dfbf_sorted_timeLockedCells, trialPhase, 'Frames', ['Sorted Cells (Threshold: ' num2str(threshold) ')'], figureDetails, 1)
        %         colormap(figureDetails.colorMap)
        %
        %         if ops0.multiDayAnalysis
        %             print(['/Users/ananth/Desktop/figs/sort/timeCells_allTrialsAvg_sorted_' ...
        %                 'threshold' num2str(threshold) '_' ...
        %                 db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method '_multiDay'],...
        %                 '-djpeg');
        %         else
        %             print(['/Users/ananth/Desktop/figs/sort/timeCells_allTrialsAvg_sorted_' ...
        %                 'threshold' num2str(threshold) '_' ...
        %                 db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method],...
        %                 '-djpeg');
        %         end
        
        % Calcium activity for time-locked cells, from all trials
        %         fig3 = figure(3);
        %         clf
        %         set(fig3,'Position',[300,300,1200,500])
        %         subplot(2,1,1);
        %         %plot unsorted data
        %         plotdFbyF(db(iexp), dfbf_2D, trialDetails, 'Frames', 'Unsorted Cells', figureDetails, 0)
        %         %plot sorted data
        %         subplot(2,1,2);
        %         plotdFbyF(db(iexp), dfbf_2D_sorted_timeCells, trialDetails, 'Frames', ['Sorted Cells (Threshold: ' num2str(threshold) ')'], figureDetails, 0)
        %         colormap(figureDetails.colorMap)
        %
        %         if ops0.multiDayAnalysis
        %             print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_2D_allTrials_' ...
        %                 'threshold' num2str(threshold) '_'...
        %                 db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method '_sorted_multiDay'],...
        %                 '-djpeg');
        %         else
        %             print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_2D_allTrials_' ...
        %                 'threshold' num2str(threshold) '_'...
        %                 db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method '_sorted'],...
        %                 '-djpeg');
        %         end
        
        % Temporal Information
%         fig4 = figure(4);
%         clf
%         set(fig4,'Position',[300,300,800,400])
%         %TI_all_sorted = TI(sortedPSTHindices,:);
%         plot(TI, 'b*', ...
%             'LineWidth', figureDetails.lineWidth, ...
%             'MarkerSize', figureDetails.markerSize)
%         hold on
%         TI_onlyTimeLockedCells = nan(size(TI));
%         TI_onlyTimeLockedCells(iTimeCells) = TI(iTimeCells);
%         plot(TI_onlyTimeLockedCells, 'ro', ...
%             'MarkerSize', figureDetails.markerSize)
%         axis([0 size(TI,1) 0.5 2.5])
%         title(sprintf('Temporal Information (Method: %s)', ops0.method), ...
%             'FontSize', figureDetails.fontSize, ...
%             'FontWeight', 'bold')
%         xlabel('Cell Number', ...
%             'FontSize', figureDetails.fontSize, ...
%             'FontWeight', 'bold')
%         ylabel('Temporal Information (bits)', ...
%             'FontSize', figureDetails.fontSize, ...
%             'FontWeight', 'bold')
%         legend({'All Cells', 'Time-Locked Cells'})
%         set(gca,'FontSize', figureDetails.fontSize-2)
%         
%         if ops0.multiDayAnalysis
%             print(['/Users/ananth/Desktop/figs/psth/ti_' ...
%                 db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method '_multiDay'],...
%                 '-djpeg');
%         else
%             print(['/Users/ananth/Desktop/figs/psth/ti_' ...
%                 db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method],...
%                 '-djpeg');
%         end
        
        % Trends in Temporal Information
        TI_timeLockedCells = TI(iTimeCells,:);
        TI_sorted = TI_timeLockedCells(sortedPSTHindices,:);
        fig5 = figure(5);
        clf
        set(fig5,'Position',[300,300,800,400])
        plot(TI_sorted, 'b*', ...
            'MarkerSize', figureDetails.markerSize)
        axis([0 size(TI_sorted,1) 0.2 2])
        %         title(sprintf('Trends in Temporal Information (Method: %s)', ops0.method), ...
        %             'FontSize', figureDetails.fontSize, ...
        %             'FontWeight', 'bold')
        xlabel('Sorted Time-Locked Cell Number', ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
        ylabel('Temporal Information (bits)', ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
        %legend({'All Cells', 'Time-Locked Cells'})
        set(gca,'FontSize', figureDetails.fontSize-2)
        if ops0.multiDayAnalysis
            print(['/Users/ananth/Desktop/figs/psth/ti_sorted_' ...
                db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method '_multiDay'],...
                '-djpeg');
        else
            print(['/Users/ananth/Desktop/figs/psth/ti_sorted_' ...
                db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method],...
                '-djpeg');
        end
        
        disp('... done!')
    end
    percentTimeCells = (length(iTimeCells)/size(dfbf,1))*100;
    fprintf('[INFO] %0.4f %% of cells were time-locked\n', percentTimeCells)
end
toc
disp('All done!')
% plotCell_Analysis(cell, trialPhase, cellRastor, myData, cellFrequency, AUC, MAX_value, MAX_index, importantTrials, fontSize, lineWidth)
% figure(11)
% plot(mean(squeeze(dfbf(23,:,:)),1)*100);
% title('Comparing between different weights for neuropil subtraction');
% xlabel('Time (ms)');
% ylabel('Trial-averaged dF/F (%)')
% hold on
%profile viewer