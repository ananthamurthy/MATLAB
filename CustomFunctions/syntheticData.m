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
ops0.method          = 'C'; % A: only PSTH; B: PSTH then filter; C: filter then PSTH; use 'C'
ops0.fig             = 1;
ops0.saveData        = 1;
%ops0.onlyProbeTrials = 0;

%% Synthetic Data Parameters
timeCellFraction = 50; %in %
cellOrder = 'basic'; %basic or random
maxHitTrialFraction = 100;
trialOrder = 'basic'; %basic
eventWidth = {25, 'stddev'}; % {location, width}; e.g. - {percentile, stddev}; string array
eventAmplificationFactor = 10;
eventTiming = 'sequence'; %sequence or random
startFrame = 20;
endFrame = db(1).nFrames;
imprecisionFWHM = 8; %Will be divided by 2 for positive and negative "width" around the centre
imprecisionType = 'normal'; %Uniform, Normal, or None
noise = 'gaussian'; %Gaussian (as noisePercent) or None (makes noisePercent irrelevant)
noisePercent = '20'; %How much percent of noise to add

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
    realProcessedData = load([saveFolder db(iexp).mouse_name '_' db(iexp).date '_' ops0.method '.mat']);
    trialDetails = getTrialDetails(db(iexp));
    
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
        disp('... calcium event library created!')
    end
    %Make synthetic dataset
    DATA = realProcessedData.dfbf;
    DATA_2D = realProcessedData.dfbf_2D;
    disp('Creating synthetic data ...');
    [syntheticDATA, syntheticDATA_2D, putativeTimeCells, requiredEventLength] = syntheticDataMaker(db(iexp), DATA, DATA_2D, eventLibrary_2D, ...
        timeCellFraction, cellOrder, ...
        maxHitTrialFraction, trialOrder, ...
        eventWidth, eventAmplificationFactor, eventTiming, startFrame, endFrame, ...
        imprecisionFWHM, imprecisionType, noise);
    disp('... done!')
    
    if ops0.saveData == 1
        save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_eventLibrary_2D.mat'], 'eventLibrary_2D')
        save([saveFolder ...
            'synthDATA' ...
            '_tCF' num2str(timeCellFraction) ...
            '_cO' cellOrder(1) ...
            '_mHTF' num2str(maxHitTrialFraction) ...
            '_tO' trialOrder(1) ...
            '_eW' num2str(eventWidth{1}) ...
            '_eAF' eventAmplificationFactor ...
            '_eT' eventTiming(1) ...
            '_sF' num2str(startFrame) ...
            '_eF' num2str(endFrame) ...
            '_iFWHM' num2str(imprecisionFWHM) ...
            '_iT' imprecisionType ...
            '_n' noise ...
            '_np' num2str(noisePercent) ...
            '.mat'], ...
            'syntheticDATA', 'syntheticDATA_2D', ...
            'timeCellFraction', 'cellOrder', ...
            'maxHitTrialFraction', 'trialOrder', ...
            'eventWidth', 'eventTiming', ...
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