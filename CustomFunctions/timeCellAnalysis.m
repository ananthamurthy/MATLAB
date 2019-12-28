% TITLE - Custom code to Identify Time Cell Sequences, if any
% AUTHOR - Kambadur Ananthamurthy

% Additional functions may be found in "CustomFunctions"
%profile on
tic
close all
%clear all
clear

%% Addpaths
addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions')) % my custom functions
addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis')) % Additional functions
addpath(genpath('/Users/ananth/Desktop/Work/Analysis/Imaging')) % analysis output
addpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis/Suite2P-ananth/localCopies')
%% Operations
ops0.multiDayAnalysis       = 0; %For chronic tracking experiments; usually set to 0
ops0.fig                    = 1;
ops0.method                 = 'C'; % A: only PSTH; B: PSTH then filter; C: filter then PSTH; use 'C'
ops0.useLOTO                = 0;
ops0.gaussianSmoothing      = 0;
ops0.bandpassFilter         = 0;
ops0.loadBehaviourData      = 0;
ops0.loadSyntheticData      = 1;
ops0.onlyProbeTrials        = 0;
ops0.findTimeCells          = 1;
ops0.saveData               = 1;
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
        myRawData = Fcell{1,1}(newIndices,:);
    else
        myRawData = Fcell{1,1};
    end
    fprintf('Total cells: %i\n', size(myRawData,1))
    [dfbf, baselines, dfbf_2D] = dodFbyF(db(iexp), myRawData);
    
    %Significant-Only Traces
    if ops0.onlyProbeTrials
        disp('Only analysing Probe Trials ...')
        dfbf_sigOnly = findSigOnly(dfbf(:,iProbeTrials,:));
    else
        dfbf_sigOnly = findSigOnly(dfbf);
    end
    
    %Search for low frequency events
    if ops0.gaussianSmoothing
        nSamples = 3; %for Gaussian Kernel
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
    elseif ops0.bandpassFilter
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
    else
        myData = dfbf_sigOnly; % crucial
    end
    
    if ops0.loadSyntheticData == 1
        myData = load([saveFolder db(iexp).mouse_name '_' db(iexp).date '_syntheticDATA.mat']);
    end
    
    %% Tuning and time field fidelity using PSTH
    if ops0.findTimeCells
        %Area Under Curve
        %AUC = doAUC(myData(:,:,window)); %(Data, percentile)
        trialPhase = 'wholeTrial';
        window = findWindow(trialPhase, trialDetails);
        %window = 100:150;
        %skipFrames = 116; %Skip frame 116, viz., the CS frame. Use skipFrames = 0 to avoid skipping
        %skipFrames = trialDetails.preDuration * db(iexp).samplingDate;
        skipFrames = 81;
        %NOTE: Make sure to use significant-only traces else a second
        %freqThreshold needs to be passed as an argument
        % PSTH based identification of tuning curves
        freqThreshold = floor(0.00 * (size(dfbf,2))); %freqThreshold is 25% of the session trials
        delta = 3; %for now; works out to 207 ms if sampling at 14.5 Hz
        allCells = ones(size(myData,1),1); %for indexing only
        if ops0.method == 'A' %No filtering for % of trials active
            disp('Only PSTH; not filtering for percentage of trials with activity ...')
            freqThreshold = 0; %meaningless
            [PSTH, PSTH_3D, nbins] = getPSTH(myData, delta, skipFrames);
            [timeLockedCells, TI] = getTimeLockedCells(PSTH_3D, allCells, 1000, 99, delta);
            [cellRastor, cellFrequency, importantTrials] = getCellRastors(myData, skipFrames);
            iTimeCells = find(timeLockedCells);
        elseif ops0.method == 'B' %PSTH then filtering for % of trials active
            disp('First PSTH, then filtering for percentage of trials with activity ...')
            [PSTH, PSTH_3D, nbins] = getPSTH(myData, delta, skipFrames);
            [timeLockedCells_temp, TI] = getTimeLockedCells(PSTH_3D, allCells, 1000, 99);
            %iTimeCells_temp = find(timeLockedCells_temp);
            [cellRastor, cellFrequency, timeLockedCells, importantTrials] = ...
                getFreqBasedTimeCellList(myData, timeLockedCells_temp, freqThreshold, skipFrames, delta);
            iTimeCells = find(timeLockedCells); %Absolute indexing
            fprintf('%i time-locked cells found\n', length(iTimeCells))
        elseif ops0.method == 'C' %Filter for % trials active then PSTH
            disp('First filtering for percentage of trials with activity, then PSTH ...')
            [cellRastor, cellFrequency, timeLockedCells_temp, importantTrials] = ...
                getFreqBasedTimeCellList(myData, allCells, freqThreshold, skipFrames, delta);
            %iTimeCells_temp = find(selectedIndices);
            %Develop PSTH only for cells passing >25% activity
            [PSTH, PSTH_3D, nbins] = getPSTH(myData, delta, skipFrames);
            %Finally, identifying true time-locked cells, using the TI metric
            [timeLockedCells, TI] = getTimeLockedCells(PSTH_3D, timeLockedCells_temp, 1000, 99);
            iTimeCells = find(timeLockedCells); %Absolute indexing
            dfbf_timeLockedCells = myData(iTimeCells,:,:);
            fprintf('%i time-locked cells found\n', length(iTimeCells))
        else
        end
        %PSTH_probeTrials = sum(PSTH_3D(:,iProbeTrials,:),2);
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
            dfbf_2D_sorted_timeCells = [];
        else
            [sortedPSTHindices, peakIndicies] = sortPSTH(PSTH(iTimeCells,:));
            %%%
            %Add a section to use the median time onset delay
            %maybe use PSTH_3D
            %%%
            PSTH_timeLocked = PSTH(iTimeCells,:);
            PSTH_sorted = PSTH_timeLocked(sortedPSTHindices,:);
            dfbf_sorted_timeLockedCells = dfbf_timeLockedCells(sortedPSTHindices,:,:);
            %dfbf_2D_sorted_timeCells = dfbf_2D_timeLockedCells(sortedPSTHindices,:);
        end
    else
        %Populate library for simulated data
        realProcessedData = load([saveFolder db(iexp).mouse_name '_' db(iexp).date '_' ops0.method '.mat']);
    end
    %Cell specific
    %Use real 2D data
    baseline = zeros(size(dfbf_2D,1),1);
    stddev = zeros(size(dfbf_2D,1),1);
    binaryData = zeros(size(dfbf_2D,2),1);
    
    %2D
    disp('Basic scan for calcium events ...')
    for cell = 1:size(dfbf_2D,1)
        B = squeeze(dfbf_2D(cell,:));
        baseline(cell) = mean(B);
        stddev(cell) = std(B);
        binaryData(find(B > (baseline(cell) + 2*stddev(cell))),1) = 1; %multiplier = 1
        [Events, StartIndices, Lengths] = findConsecutiveOnes(binaryData);
        eventLibrary_2D(cell).nEvents = Events;
        eventLibrary_2D(cell).eventStartIndices = StartIndices;
        eventLibrary_2D(cell).eventLengths = Lengths;
        % Find a way to optimize memory.
        
        clear binaryData
        clear Events
        clear StartIndices
        clear Lengths
    end
    disp('... calcium activity library updated!')
end
%     if ~ops0.onlyProbeTrials
%         % Sort PSTHs for only Probe Trials
%         [sortedPSTHindices_probeTrials, peakIndicies_probeTrials] = sortPSTH(PSTH_probeTrials(iTimeCells,:));
%         PSTH_timeLocked_probeTrials = PSTH(iTimeCells,:);
%         PSTH_sorted_probeTrials = PSTH_timeLocked_probeTrials(sortedPSTHindices,:);
%     end

if ops0.useLOTO
    [consolidated_iTimeCells_loto, diff_nTimeCells, consolidated_TI_loto, diff_TI] ...
        = runLOTO(myData, ops0.method, freqThreshold, delta, allCells, skipFrames);
end
disp('... done!')
%% Search for large Calcium events
largeEvents = detectLargeEvents(myData);
%% Data Saving for Custom section
if ops0.saveData
    if ops0.findTimeCells
        percentTimeCells = (length(iTimeCells)/size(dfbf,1))*100;
        fprintf('[INFO] %0.4f %% of cells were time-locked\n', percentTimeCells)
        if ~isdir(saveFolder)
            mkdir(saveFolder);
        end
        if ops0.useLOTO
            if ops0.multiDayAnalysis
                disp('Saving multi-day data after LOTO ...')
                save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_' ops0.method '_multiDay.mat' ], ...
                    'dfbf', 'baselines', 'dfbf_2D', ...
                    'dfbf_timeLockedCells', ...
                    'dfbf_sorted_timeLockedCells', ...
                    'trialPhase', 'window', ...
                    'freqThreshold', ...
                    'cellRastor', 'cellFrequency', 'timeLockedCells', 'importantTrials', ...
                    'delta', ...
                    'PSTH', 'iTimeCells', 'consolidated_iTimeCells_loto', 'TI', 'consolidated_TI_loto', ...
                    'largeEvents')
            else
                disp('Saving single session data after LOTO ...')
                save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_' ops0.method '.mat' ], ...
                    'dfbf', 'baselines', 'dfbf_2D', ...
                    'dfbf_timeLockedCells', ...
                    'dfbf_sorted_timeLockedCells', ...
                    'trialPhase', 'window', ...
                    'freqThreshold', ...
                    'cellRastor', 'cellFrequency', 'timeLockedCells', 'importantTrials', ...
                    'delta', ...
                    'PSTH', 'iTimeCells', 'consolidated_iTimeCells_loto', 'TI', 'consolidated_TI_loto', ...
                    'largeEvents')
            end
        else %Not using LOTO
            if ops0.multiDayAnalysis
                disp('Saving multi-day data ...')
                save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_' ops0.method '_multiDay.mat' ], ...
                    'dfbf', 'baselines', 'dfbf_2D', ...
                    'dfbf_timeLockedCells', ...
                    'dfbf_sorted_timeLockedCells', ...
                    'trialPhase', 'window', ...
                    'freqThreshold', ...
                    'cellRastor', 'cellFrequency', 'timeLockedCells', 'importantTrials', ...
                    'delta', ...
                    'PSTH', 'iTimeCells', 'TI', ...
                    'largeEvents')
            else
                disp('Saving single session data ...')
                save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_' ops0.method '.mat' ], ...
                    'dfbf', 'baselines', 'dfbf_2D', ...
                    'dfbf_timeLockedCells', ...
                    'dfbf_sorted_timeLockedCells', ...
                    'trialPhase', 'window', ...
                    'freqThreshold', ...
                    'cellRastor', 'cellFrequency', 'timeLockedCells', 'importantTrials', ...
                    'delta', ...
                    'PSTH', 'iTimeCells', 'TI', ...
                    'largeEvents')
            end
        end
        disp('... done!')
    else
        %Saving library for simulated data
        disp('Saving the library of events ...')
        save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_' ops0.method '_eventLibrary_2D.mat'], 'eventLibrary_2D')
        disp('... done!')
    end
end

%% Plots
if ops0.findTimeCells
    if ops0.fig
        disp('Plotting data ...')
        
        % PSTH
        fig1 = figure(1);
        clf
        set(fig1,'Position',[300,300,1200,500])
        subFig1 = subplot(1,2,1);
        plotPSTH(db(iexp), PSTH(iTimeCells,:), trialDetails, 'Bin No.', 'Unsorted Cells', figureDetails, 1)
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
        %         plotSequences(db(iexp), dfbf_sorted_timeLockedCells, trialPhase, 'Frames', ['Sorted Cells (Threshold: ' num2str(freqThreshold) ')'], figureDetails, 1)
        %         colormap(figureDetails.colorMap)
        %
        %         if ops0.multiDayAnalysis
        %             print(['/Users/ananth/Desktop/figs/sort/timeCells_allTrialsAvg_sorted_' ...
        %                 'freqThreshold' num2str(freqThreshold) '_' ...
        %                 db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method '_multiDay'],...
        %                 '-djpeg');
        %         else
        %             print(['/Users/ananth/Desktop/figs/sort/timeCells_allTrialsAvg_sorted_' ...
        %                 'freqThreshold' num2str(freqThreshold) '_' ...
        %                 db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method],...
        %                 '-djpeg');
        %         end
        
        % Calcium activity for time-locked cells, from all trials
        %         fig3 = figure(3);
        %         clf
        %         set(fig3,'Position',[300,300,1200,500])
        %         if ~isempty(iTimeCells)
        %             subplot(2,1,1);
        %             %plot unsorted data
        %             plotdFbyF(db(iexp), dfbf_2D, trialDetails, 'Frames', 'Unsorted Cells', figureDetails, 0)
        %             %plot sorted data
        %             subplot(2,1,2);
        %             plotdFbyF(db(iexp), dfbf_2D_sorted_timeCells, trialDetails, 'Frames', ['Sorted Cells (Threshold: ' num2str(freqThreshold) ')'], figureDetails, 0)
        %             colormap(figureDetails.colorMap)
        %         else
        %             plotdFbyF(db(iexp), dfbf_2D, trialDetails, 'Frames', 'Unsorted Cells', figureDetails, 0)
        %         end
        %
        %         if ops0.multiDayAnalysis
        %             print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_2D_allTrials_' ...
        %                 'freqThreshold' num2str(freqThreshold) '_'...
        %                 db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method '_sorted_multiDay'],...
        %                 '-djpeg');
        %         else
        %             print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_2D_allTrials_' ...
        %                 'freqThreshold' num2str(freqThreshold) '_'...
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
                TI_onlyTimeLockedCells(iTimeCells) = TI(iTimeCells);
                plot(TI_onlyTimeLockedCells, 'ro', ...
                    'MarkerSize', figureDetails.markerSize)
                axis([0 size(TI,1) 0.5 2.5])
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
        if ~isempty(TI_sorted)
            axis([0 size(TI_sorted,1) 0.2 2])
        end
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
        
        %Differences observed using LOTO
        if ops0.useLOTO
            %Number of classified time cells
            fig6 = figure(6);
            clf
            set(fig6,'Position',[300,300,800,400])
            stem(diff_nTimeCells, '-red*', ...
                'MarkerSize', figureDetails.markerSize)
            title(['LOTO - Numbers | ', ...
                db(iexp).mouse_name ' ST' num2str(db(iexp).sessionType) ' S' num2str(db(iexp).session)], ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
            xlabel('Excluded Trial No.', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
            ylabel('Difference in classified time cells', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
            set(gca,'FontSize', figureDetails.fontSize-2)
            if ops0.multiDayAnalysis
                print(['/Users/ananth/Desktop/figs/importantTrials/diff_nTimeCells_' ...
                    db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method '_multiDay'],...
                    '-djpeg');
            else
                print(['/Users/ananth/Desktop/figs/importantTrials/diff_nTimeCells_' ...
                    db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method],...
                    '-djpeg');
            end
            
            %TI values
            nanLine = nan(size(myData,1),1);
            nanLine(iTimeCells) = 1;
            fig7 = figure(7);
            clf
            set(fig7,'Position',[300,300,1500,1500])
            %             for trial = 1:size(myData,2)
            %                 hold on;
            %                 plot(diff_TI(trial,:), '-bo', ...
            %                     'MarkerSize', figureDetails.markerSize)
            %             end
            subplot(3,1,1:2)
            surf(diff_TI, 'FaceAlpha', 0.4);
            colormap autumn
            title(['LOTO - TI | ', ...
                db(iexp).mouse_name ' ST' num2str(db(iexp).sessionType) ' S' num2str(db(iexp).session)], ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
            xlabel('Cell No.', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
            ylabel('Excluded Trial No.', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
            zlabel('Difference in TI (bits)', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
            set(gca,'FontSize', figureDetails.fontSize-2)
            subplot(3,1,3)
            plot(nanLine, 'b*', 'MarkerSize', figureDetails.markerSize)
            xlim([1 size(myData,1)])
            ylim([0 2])
            set(gca, 'YTick', [])
            %             title(['Classified Time Cells | ', ...
            %                 db.mouse_name ' ST' num2str(db.sessionType) ' S' num2str(db.session)], ...
            title('Classified Time Cells', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
            xlabel('Cell No.', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
            ylabel('Is time cell?', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
            set(gca,'FontSize', figureDetails.fontSize-2)
            if ops0.multiDayAnalysis
                print(['/Users/ananth/Desktop/figs/importantTrials/diff_TI_' ...
                    db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method '_multiDay'],...
                    '-djpeg');
            else
                print(['/Users/ananth/Desktop/figs/importantTrials/diff_TI_' ...
                    db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_' ops0.method],...
                    '-djpeg');
            end
            
        end
        disp('... done!')
    end
end
toc
disp('All done!')
%profile viewer