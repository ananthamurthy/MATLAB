% "Synthetic Data Maker" by Kambadur Ananthamurthy
% This code uses actual dfbf curves from my data, populates a library of
% calcium events and then creates synthetic datasets based on the arguments
% passed into 'syntheticDataMaker'
% Currently this is being tested for single session data. I will test with a
% batch, soon.

tic
close all
clear

addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions')) % my custom functions
addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis')) % Additional functions
addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis/Suite2P-ananth'))

%% Dataset
make_db
ops0.fig             = 1;
ops0.saveData        = 1;
%ops0.onlyProbeTrials = 0;

%% Synthetic Data Parameters
setupSyntheticDataParameters

%%
if ops0.fig
    figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'hot'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
end

for iexp = 1:length(db)
    fprintf('Analyzing %s_%i_%i - Date: %s\n', db(iexp).mouse_name, ...
        db(iexp).sessionType, ...
        db(iexp).session, ...
        db(iexp).date)
    saveDirec = '/Users/ananth/Desktop/Work/Analysis/Imaging/';
    saveFolder = [saveDirec db(iexp).mouse_name '/' db(iexp).date '/'];
    
    %Load processed data (processed dfbf for dataset/session)
    realProcessedData = load([saveFolder db(iexp).mouse_name '_' db(iexp).date '.mat']);
    trialDetails = getTrialDetails(db(iexp));
    
    %% Curate Calcium Event Library
    %Cell specific curation of the calcium event library
    %Check to see if the library exits
    if isfile([saveFolder db(iexp).mouse_name '_' db(iexp).date '_eventLibrary_2D.mat'])
        disp('Loading existing event library ...')
        load([saveFolder db(iexp).mouse_name '_' db(iexp).date '_eventLibrary_2D.mat'])
        disp('... done!')
    else
        %Use real 2D data
        baseline = zeros(size(realProcessedData.dfbf_2D,1),1);
        stddev = zeros(size(realProcessedData.dfbf_2D,1),1);
        binaryData = zeros(size(realProcessedData.dfbf_2D,2),1);
        
        %2D
        disp('Basic scan for calcium events ...')
        for cell = 1:size(realProcessedData.dfbf_2D,1)
            B = squeeze(realProcessedData.dfbf_2D(cell,:));
            baseline(cell) = mean(B);
            stddev(cell) = std(B);
            binaryData(find(B > (baseline(cell) + 2*stddev(cell))),1) = 1; %multiplier = 1
            [nEvents, StartIndices, Lengths] = findConsecutiveOnes(binaryData);
            eventLibrary_2D(cell).nEvents = nEvents;
            eventLibrary_2D(cell).eventStartIndices = StartIndices;
            eventLibrary_2D(cell).eventLengths = Lengths;
            % Find a way to optimize memory.
            
            clear binaryData
            clear Events
            clear StartIndices
            clear Lengths
        end
        disp('... calcium event library created!')
    end
    
    %% Make synthetic dataset
    DATA = realProcessedData.dfbf;
    DATA_2D = realProcessedData.dfbf_2D;
    disp('Creating synthetic data ...');
    [syntheticDATA, syntheticDATA_2D, putativeTimeCells, requiredEventLength] = syntheticDataMaker(db(iexp), DATA, DATA_2D, eventLibrary_2D, ...
        percentTimeCells, cellOrder, ...
        maxPercentHitTrials, hitTrialAssignment, trialOrder, ...
        eventWidth, eventAmplificationFactor, eventTiming, startFrame, endFrame, ...
        imprecisionFWHM, imprecisionType, ...
        noise, noisePercent);
    disp('... done!')
    
    if ops0.saveData == 1
        save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_eventLibrary_2D.mat'], 'eventLibrary_2D')
        save([saveFolder ...
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
            '.mat'], ...
            'syntheticDATA', 'syntheticDATA_2D', ...
            'percentTimeCells', 'cellOrder', ...
            'maxPercentHitTrials', 'hitTrialAssignment', 'trialOrder', ...
            'eventWidth', 'eventTiming', ...
            'startFrame', 'endFrame', ...
            'imprecisionFWHM', 'imprecisionType', ...
            'noise', 'noisePercent')
    end
    
    if ops0.fig == 1
        fig1 = figure(1);
        set(fig1,'Position', [300, 300, 1200, 500]);
        %         imagesc(squeeze(mean(syntheticDATA,2)))
        %         title(['Trial-Averaged Synthetic Data | ' ...
        %             db(iexp).mouse_name ...
        %             ' ST' num2str(db(iexp).sessionType) ...
        %             ' S' num2str(db(iexp).session) ...
        %             ' eventSize:' eventSize ...
        %             ' maxImprecision: ' num2str(max(imprecision)) ...
        %             ' noise: ' noise])
        %         xlabel('Frame Number', ...
        %             'FontSize', figureDetails.fontSize,...
        %             'FontWeight', 'bold')
        %         ylabel('Cell Number', ...
        %             'FontSize', figureDetails.fontSize,...
        %             'FontWeight', 'bold')
        %         set(gca,'FontSize', figureDetails.fontSize-2)
        plotdFbyF(db(iexp), syntheticDATA_2D, trialDetails, 'Frame Number', 'Cell Numbers', figureDetails, 0)
        colormap(figureDetails.colorMap)
        %         print(['/Users/ananth/Desktop/figs/syntheticData/synthData_' ...
        %             db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) ...
        %             '_eventWidth_percentile' eventWidth (1) ...
        %             '_eventWidth_width' eventWidth (2) ...
        %             '_eventTiming-' eventTiming ...
        %             '_maxImprecision-' num2str(max(imprecision)) ...
        %             '_noise-' noise], ...
        %             '-djpeg');
        print(['/Users/ananth/Desktop/figs/syntheticData/synthData_' ...
            db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session)], ...
            '-djpeg');
    else
    end
end
toc
disp('All done!')