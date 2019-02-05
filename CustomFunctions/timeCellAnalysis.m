% TITLE - Custom code to Identify Time Cell Sequences, if any
% AUTHOR - Kambadur Ananthmurthy

% Additional functions may be found in "CustomFunctions"

tic
disp('Analyzing for Time Cells ...')
close all
%clear all
clear

addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions')) % my custom functions
addpath(genpath('/Users/ananth/Desktop/Work/Analysis/Imaging')) % analysis output

%% Operations
ops0.multiDayAnalysis       = 0; %For chronic tracking experiments; usually set to 0
ops0.fig                    = 1;
ops0.method                 = 'C'; % A: only PSTH; B: PSTH then filter; C: filter then PSTH; use 'C'
ops0.saveData               = 1;

%Identify Dataset
addpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis/Suite2P-ananth/localCopies')
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
    load(['Users/ananth/Desktop/Work/Analysis/Imaging/' ...
        db(iexp).mouse_name '/' db(iexp).date '/' num2str(db(iexp).expts) ...
        '/F_' db(iexp).mouse_name '_' db(iexp).date '_plane' num2str(db(iexp).nplanes) '.mat'])
    
    %Registration Options
    load(['Users/ananth/Desktop/Work/Analysis/Imaging/' ...
        db(iexp).mouse_name '/' db(iexp).date '/' num2str(db(iexp).expts) ...
        '/regops_' db(iexp).mouse_name '_' db(iexp).date '.mat'])
    
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
    dfbf_sigOnly = findSigOnly(dfbf);
    
    %% Tuning and time field fidelity using PSTH
    %Area Under Curve
    %AUC = doAUC(dfbf_sigOnly(:,:,window)); %(Data, percentile)
    trialPhase = 'wholeTrial';
    window = findWindow(trialPhase, trialDetails);
    %window = 100:150;
    %skipFrames = 116; %Skip frame 116, viz., the CS frame. Use skipFrames = 0 to avoid skipping
    %skipFrames = trialDetails.preDuration * db(iexp).samplingDate;
    skipFrames = 81;
    %Here, threshold is in terms of number of trials
    %threshold = 2;
    
    %NOTE: Make sure to use significant-only traces else a second
    %threshold needs to be passed as an argument
    % PSTH based identification of tuning curves
    % Including further criteria defining time-locked cells
    % timeLockedCells is subject to modifications
    % 1. The cell should be active in more than 25% trials
    delta = 3; %for now; works out to 207 ms if sampling at 14.5 Hz
    if ops0.method == 'A' %No filtering for % of trials active
        disp('Only PSTH; not filtering for percentage of trials with activity ...')
        threshold = 0; %meaningless
        [PSTH, PSTH_3D] = getPSTH(dfbf_sigOnly, delta, skipFrames);
        [timeLockedCells, TI] = getTimeLockedCells(PSTH_3D, 1000, 99);
        [cellRastor, cellFrequency, importantTrials] = getCellRastors(dfbf_sigOnly, skipFrames);
    elseif ops0.method == 'B' %PSTH then filtering for % of trials active
        disp('First PSTH, then filtering for percentage of trials with activity ...')
        [PSTH, PSTH_3D] = getPSTH(dfbf_sigOnly, delta, skipFrames);
        [timeLockedCells_temp, TI] = getTimeLockedCells(PSTH_3D, 1000, 99);
        threshold = 0.25 * (size(dfbf,2)); %threshold is 25% of the session trials
        [cellRastor, cellFrequency, timeLockedCells, importantTrials] = ...
            getFreqBasedTimeCellList(dfbf_sigOnly(find(timeLockedCells_temp),:,:), threshold, skipFrames);
        fprintf('%i time-locked cells found\n', length(find(timeLockedCells)))
    elseif ops0.method == 'C' %Filter for % trials active then PSTH
        disp('First filtering for percentage of trials with activity, then PSTH ...')
        threshold = 0.25 * (size(dfbf,2)); %threshold is 25% of the session trials
        [cellRastor, cellFrequency, timeLockedCells_temp, importantTrials] = ...
            getFreqBasedTimeCellList(dfbf_sigOnly, threshold, skipFrames);
        [PSTH, PSTH_3D] = getPSTH(dfbf_sigOnly(find(timeLockedCells_temp),:,:), delta, skipFrames);
        [timeLockedCells, TI] = getTimeLockedCells(PSTH_3D, 1000, 99);
        fprintf('%i time-locked cells found\n', length(find(timeLockedCells)))
    else
    end
    %2. There should be at least two consecutive bins with significant
    %values for PSTH.
    
    % Unsorted
    dfbf_timeLockedCells = dfbf_sigOnly(find(timeLockedCells),:,:);
    %dfbf_2D_timeLockedCells = dfbf_2D(find(timeLockedCells),:,:);
    
    % Sorting
    if isempty(find(timeLockedCells,1))
        %disp('No time cells found')
        %[sortedPSTHindices, peakIndicies] = [0, 0];
        sortedPSTHindices = [];
        peakIndicies = [];
        PSTH_sorted = [];
        dfbf_sorted_timeLockedCells = [];
    else
        [sortedPSTHindices, peakIndicies] = sortPSTH(PSTH(find(timeLockedCells),:));
        PSTH_timeLocked = PSTH(find(timeLockedCells),:);
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
        plotPSTH(db(iexp), PSTH(find(timeLockedCells),:,:), trialDetails, 'Bin No.', 'Unsorted Cells', figureDetails, 1)
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
        fig4 = figure(4);
        clf
        set(fig4,'Position',[300,300,800,400])
        %TI_all_sorted = TI(sortedPSTHindices,:);
        plot(TI, 'b*', ...
            'LineWidth', figureDetails.lineWidth, ...
            'MarkerSize', figureDetails.markerSize)
        hold on
        TI_onlyTimeLockedCells = nan(size(TI));
        TI_onlyTimeLockedCells(find(timeLockedCells)) = TI(find(timeLockedCells));
        plot(TI_onlyTimeLockedCells, 'ro', ...
            'MarkerSize', figureDetails.markerSize)
        title(sprintf('Temporal Information (Method: %s)', ops0.method), ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
        xlabel('Cell Number', ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
        ylabel('Temporal Information (bits)', ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
        legend({'All Cells', 'Time-Locked Cells'})
        set(gca,'FontSize', figureDetails.fontSize-2)
        
        if ops0.multiDayAnalysis
            print(['/Users/ananth/Desktop/figs/psth/ti_' ...
                db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method '_multiDay'],...
                '-djpeg');
        else
            print(['/Users/ananth/Desktop/figs/psth/ti_' ...
                db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method],...
                '-djpeg');
        end
        
        % Trends in Temporal Information
        TI_timeLockedCells = TI(find(timeLockedCells),:);
        TI_sorted = TI_timeLockedCells(sortedPSTHindices,:);
        fig5 = figure(5);
        clf
        set(fig5,'Position',[300,300,800,400])
        plot(TI_sorted, 'r*', ...
            'MarkerSize', figureDetails.markerSize)
        title(sprintf('Trends in Temporal Information (Method: %s)', ops0.method), ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
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
end
toc
disp('All done!')
% plotCell_Analysis(cell, trialPhase, cellRastor, dfbf_sigOnly, cellFrequency, AUC, MAX_value, MAX_index, importantTrials, fontSize, lineWidth)
% figure(11)
% plot(mean(squeeze(dfbf(23,:,:)),1)*100);
% title('Comparing between different weights for neuropil subtraction');
% xlabel('Time (ms)');
% ylabel('Trial-averaged dF/F (%)')
% hold on