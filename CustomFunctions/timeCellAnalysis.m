% TITLE - Custom code to Identify Time Cell Sequences, if any
% AUTHOR - Kambadur Ananthmurthy

% Requirements - dodFbyF.m
%                getSessionDetails.m
%                findWindow.m
%                plotdFbyF.m
% These may be found in "CustomFunctions"

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
ops0.findTimeCells          = 1;
ops0.useEventFrequency      = 1;
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
        %myData = zeros(size(newIndices,1),size(Fcell{1,1},2));
        %myData = fetchData;
        myData = Fcell{1,1}(newIndices,:);
    else
        myData = Fcell{1,1};
    end
    
    [dfbf, baselines, dfbf_2D] = dodFbyF(db(iexp), myData);
    %     weight = 0.1; %for weighted subtraction
    %     F = Fcell{1,1} - weight * FcellNeu{1,1};
    %     [dfbf, baselines, dfbf_2D] = dodFbyF(db(iexp), F);
    
    if ops0.findTimeCells
        %Significant-Only Traces
        dfbf_sigOnly = findSigOnly(dfbf);
        
        %% Tuning and time field fidelity
        %trialPhase = 'CS-Trace-US'; % Crucial
        %trialPhase = 'Trace-US';
        %         trialPhase = 'wholeTrial';
        %         clear window %for sanity
        %         window = findWindow(trialPhase, trialDetails);
        trialPhase = '';
        window = 100:150;
        skipFrames = 116; %Skip frame 116, viz., the CS frame. Use skipFrames = 0 to avoid skipping
        
        if ops0.useEventFrequency
            %Here, threshold is in terms of number of trials
            %threshold = 2;
            x=0.2; % in%
            threshold = x*(size(dfbf,2)); %threshold is x% of the session trials
            %             window = 116:124;
            %             window = findWindow('Trace-US', trialDetails);
            %NOTE: Make sure to use significant-only traces else a second
            %threshold needs to be passed as an argument
            [cellRastor, cellFrequency, timeLockedCells, importantTrials] = ...
                getFreqBasedTimeCellList(dfbf_sigOnly(:,:,:), threshold, skipFrames);
            
            %Area Under Curve
            AUC = doAUC(dfbf_sigOnly(:,:,window)); %(Data, percentile)
            
        else
            %Estimate based on comparison principle
            nShuffles = 5000;
            threshold = 1;
            timeLockedCells = ...
                getTimeLockedCellList(dfbf_sigOnly, nShuffles, 'AOC' ,'Average', threshold, window, skipFrames);
            %timeLockedCells = getTimeLockedCellList(dfbf, nShuffles, 'Peak' ,'Minima', threshold, window, skipFrames);
        end
        
        %% PSTH
        delta = 3; %for now
        %PSTH = getPSTH(dfbf_sigOnly, delta, skipFrames);
        PSTH = getPSTH(dfbf_sigOnly(find(timeLockedCells),:,:), delta, skipFrames);
        
        %% Sorting
        %         trialPhase = 'wholeTrial';
        %         clear window %for sanity
        %         window = findWindow(trialPhase, trialDetails);
        dfbf_timeLockedCells = dfbf(find(timeLockedCells),:,:);
        dfbf_2D_timeLockedCells = dfbf_2D(find(timeLockedCells),:,:);
        
        if isempty(find(timeLockedCells,1))
            %disp('No time cells found')
        else
            if ops0.useEventFrequency
                %sorting only for identified time cells
                [sortedCells, peakIndices] = sortFrequencyData(cellFrequency(find(timeLockedCells),:));
            else
                [sortedCells, peakIndices] = sortData(dfbf_timeLockedCells(:,:,:), 0);
            end
            dfbf_sorted_timeCells = dfbf_timeLockedCells(sortedCells,:,:);
            dfbf_2D_sorted_timeCells = dfbf_2D_timeLockedCells(sortedCells,:);
        end
        
        [sortedPSTHindices, peakIndicies] = sortPSTH(PSTH);
        PSTH_sorted = PSTH(sortedPSTHindices,:);
        
        %% Data Saving for Custom section
        if ops0.saveData
            disp('Saving data ...')
            if ~isdir(saveFolder)
                mkdir(saveFolder);
            end
            if ops0.multiDayAnalysis
                if ops0.useEventFrequency
                    save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_multiDay.mat' ], ...
                        'dfbf', 'baselines', 'dfbf_2D', ...
                        'dfbf_timeLockedCells', 'dfbf_2D_timeLockedCells', ...
                        'dfbf_sorted_timeCells', 'dfbf_2D_sorted_timeCells', ...
                        'trialPhase', 'window', ...
                        'threshold', ...
                        'cellRastor', 'cellFrequency', 'timeLockedCells', 'importantTrials', ...
                        'PSTH')
                else
                    save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_multiDay.mat' ], ...
                        'dfbf', 'baselines', 'dfbf_2D', ...
                        'window', 'timeLockedCells', ...
                        'trialReliability', 'finalTimeCellList', ...
                        'trialPhase', ...
                        'dfbf_timeLockedCells', 'dfbf_2D_timeLockedCells',...
                        'dfbf_sorted_timeCells', 'dfbf_2D_sorted_timeCells',...
                        'PSTH')
                end
            else
                if ops0.useEventFrequency
                    save([saveFolder db(iexp).mouse_name '_' db(iexp).date '.mat' ], ...
                        'dfbf', 'baselines', 'dfbf_2D', ...
                        'dfbf_timeLockedCells', 'dfbf_2D_timeLockedCells', ...
                        'dfbf_sorted_timeCells', 'dfbf_2D_sorted_timeCells', ...
                        'trialPhase', 'window', ...
                        'threshold', ...
                        'cellRastor', 'cellFrequency', 'timeLockedCells', 'importantTrials', ...
                        'PSTH')
                else
                    save([saveFolder db(iexp).mouse_name '_' db(iexp).date '.mat' ], ...
                        'dfbf', 'baselines', 'dfbf_2D', ...
                        'window', 'timeLockedCells', ...
                        'trialReliability', 'finalTimeCellList', ...
                        'trialPhase', ...
                        'dfbf_timeLockedCells', 'dfbf_2D_timeLockedCells',...
                        'dfbf_sorted_timeCells', 'dfbf_2D_sorted_timeCells',...
                        'PSTH')
                end
            end
            disp('... done!')
        end
        
        if ops0.fig
            disp('Plotting data ...')
            %% Calcium activity for all cells, from all trials
            fig1 = figure(1);
            clf
            set(fig1,'Position',[300,300,1200,500])
            %subFig1 = subplot(2,1,1);
            %plot unsorted data
            plotdFbyF(db(iexp), dfbf_2D, trialDetails, 'Frames', 'Unsorted Cells', figureDetails, 0)
            %subFig2 = subplot(2,1,2);
            %plot sorted data
            %plotdFbyF(db(iexp), dfbf_2D_sorted, trialDetails, 'Frames', 'Sorted Cells', figureDetails, 1)
            colormap(figureDetails.colorMap)
            if ops0.multiDayAnalysis
                print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_2D_allTrials_' ...
                    db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_multiDay'],...
                    '-djpeg');
            else
                print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_2D_allTrials_' ...
                    db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session)],...
                    '-djpeg');
            end
            
            %% PSTH
            fig2 = figure(2);
            clf
            set(fig2,'Position',[300,300,1200,500])
            subFig1 = subplot(1,2,1);
            plotPSTH(db(iexp), PSTH, trialDetails, 'Bin No.', 'Unsorted Cells', figureDetails, 1)
            subFig2 = subplot(1,2,2);
            plotPSTH(db(iexp), PSTH_sorted, trialDetails, 'Bin No.', 'Sorted Cells', figureDetails, 1)
            colormap(figureDetails.colorMap)
            
            if ops0.multiDayAnalysis
                print(['/Users/ananth/Desktop/figs/psth/psth_' ...
                    db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_multiDay'],...
                    '-djpeg');
            else
                print(['/Users/ananth/Desktop/figs/psth/psth_' ...
                    db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session)],...
                    '-djpeg');
            end
            
            %% Sorting based Sequences - plotting
            csFrame = 116;
            xTicks = window;
            %xLabels = strtrim(cellstr(num2str(window'))');
            xLabels = cellstr(num2str(window'))';
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
            fig3 = figure(3);
            set(fig3,'Position', [700, 700, 1200, 500]);
            subFig1 = subplot(1,2,1);
            %plot unsorted data
            if ops0.findTimeCells
                plotSequences(db(iexp), dfbf_timeLockedCells(:,:,window), trialPhase, 'Frames', 'Unsorted Cells', figureDetails, 0)
            else
                plotSequences(db(iexp), myData.dfbf_timeLockedCells(:,:,window), trialPhase, 'Frames', 'Unsorted Cells', figureDetails, 0)
            end
            colormap(figureDetails.colorMap)
            
            subFig2 = subplot(1,2,2);
            %plot sorted data
            if ops0.findTimeCells
                plotSequences(db(iexp), dfbf_sorted_timeCells(:,:,window), trialPhase, 'Frames', ['Sorted Cells (Threshold: ' num2str(threshold) ')'], figureDetails, 0)
            else
                plotSequences(db(iexp), myData.dfbf_sorted_timeCells(:,:,window), trialPhase, 'Frames', ['Sorted Cells (Threshold: ' num2str(threshold) ')'], figureDetails, 0)
            end
            colormap(figureDetails.colorMap)
            
            if ops0.multiDayAnalysis
                print(['/Users/ananth/Desktop/figs/sort/timeCells_allTrialsAvg_sorted_' ...
                    'threshold' num2str(threshold) '_' ...
                    db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_multiDay'],...
                    '-djpeg');
            else
                print(['/Users/ananth/Desktop/figs/sort/timeCells_allTrialsAvg_sorted_' ...
                    'threshold' num2str(threshold) '_' ...
                    db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session)],...
                    '-djpeg');
            end
            %trialPhase = 'CS-Trace-US'; % NOTE: this update to "trialPhase" is only for plots
            %             trialPhase = 'wholeTrial';
            %             clear window %for sanity
            %             window = findWindow(trialPhase, trialDetails);
            
            %% Calcium activity for time-locked cells, from all trials
            fig4 = figure(4);
            clf
            set(fig4,'Position',[300,300,1200,500])
            %plot sorted data
            if ops0.findTimeCells
                plotdFbyF(db(iexp), dfbf_2D_sorted_timeCells, trialDetails, 'Frames', ['Sorted Cells (Threshold: ' num2str(threshold) ')'], figureDetails, 0)
            else
                plotdFbyF(db(iexp), myData.dfbf_2D_sorted_timeCells, trialDetails, 'Frames', ['Sorted Cells (Threshold: ' num2str(threshold) ')'], figureDetails, 0)
            end
            colormap(figureDetails.colorMap)
            
            if ops0.multiDayAnalysis
                print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_2D_allTrials_' ...
                    'threshold' num2str(threshold) '_'...
                    db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_sorted_multiDay'],...
                    '-djpeg');
            else
                print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_2D_allTrials_' ...
                    'threshold' num2str(threshold) '_'...
                    db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_sorted'],...
                    '-djpeg');
            end
            disp('... done!')
        end
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