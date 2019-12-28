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
ops0.fig             = 0;
ops0.saveData        = 1;
%ops0.onlyProbeTrials = 0;

if ops0.fig
    figureDetails = compileFigureDetails(20, 2, 10, 0.5, 'hot'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
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
    %{
    [syntheticDATA, putativeTimeCells, requiredEventLength] = syntheticDataMaker(DATA, DATA_2D, eventLibrary_2D, ...
                        timeCellFraction, hitTrialFraction, trialOrder, eventSize, cellOrder, eventTiming)
    %}
    DATA = realProcessedData.dfbf;
    DATA_2D = realProcessedData.dfbf_2D;
    disp('Creating synthetic data ...');
    [syntheticDATA, putativeTimeCells, requiredEventLength] = syntheticDataMaker(DATA, DATA_2D, eventLibrary_2D, ...
        100, 100, 'basic', 'max', 'basic', 'basic');
    disp('... done!')
    
    if ops0.saveData == 1
        save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_eventLibrary_2D.mat'], 'eventLibrary_2D')
        save([saveFolder db(iexp).mouse_name '_' db(iexp).date '_syntheticDATA.mat'], 'syntheticDATA')
    end
    
    if ops0.fig == 1
        figure(1)
    else
    end
end
toc
disp('All done!')