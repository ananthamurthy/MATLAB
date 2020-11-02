% Function call: "Synthetic Data Generator" by Kambadur Ananthamurthy
% This code uses real dfbf data, eventLibrary_2D, and control parameters to
% generate synthetic datasets.
% Currently uses one session of real data, but can generate synthetic
% datasets in batch.
% gDate: date when data generation occurred
% gRun: run number of data generation (multiple runs could occur on the same date)

function [sdo_batch, sdcp, eventLibrary_2D] = generateSyntheticData(gDate, gRun, workingOnServer)

tic
close all

if workingOnServer
    HOME_DIR = '/home/bhalla/ananthamurthy/';
else
    HOME_DIR = '/Users/ananth/Documents/';
    HOME_DIR2 = '/Users/ananth/Desktop/';
end
addpath(genpath(strcat(HOME_DIR, 'MATLAB/CustomFunctions'))) % my custom functions
addpath(genpath(strcat(HOME_DIR,'MATLAB/ImagingAnalysis'))) % Additional functions
addpath(genpath(strcat(HOME_DIR, 'MATLAB/ImagingAnalysis/Suite2P-ananth')))

%ops0.fig             = 1;
ops0.saveData        = 1;
ops0.diary           = 1;

%figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%ops0.onlyProbeTrials = 0

if ops0.diary
    if workingOnServer
        diary (strcat(HOME_DIR, '/logs/dataGenDiary'))
    else
        diary (strcat(HOME_DIR2, '/logs/dataGenDiary_', num2str(gDate), '_', num2str(gRun)))
    end
    diary on
end

%% Load real dataset details
make_db %Currently only for one session at a time

fprintf('Reference Dataset - %s_%i_%i | Date: %s\n', ...
    db.mouseName, ...
    db.sessionType, ...
    db.session, ...
    db.date)

if workingOnServer
    saveDirec = strcat(HOME_DIR, 'Work/Analysis/Imaging/');
else
    saveDirec = strcat(HOME_DIR2, 'Work/Analysis/Imaging/');
end

saveFolder = strcat(saveDirec, db.mouseName, '/', db.date, '/');

%% Load processed dF/F data for dataset
realProcessedData = load(strcat(saveFolder, db.mouseName, '_', db.date, '.mat'));
nCells = size(realProcessedData.dfbf, 1);
nTrials = size(realProcessedData.dfbf, 2);
nFrames = size(realProcessedData.dfbf, 3);
fprintf('Total cells: %i\n', nCells)

%% Load synthetic dataset control parameters
setupSyntheticDataParams %Loads all options
%setupSyntheticDataParameters_batch
nDatasets = length(sdcp);

%% Organize Library of Calcium Events
%Cell specific curation of the calcium event library
%Check to see if the library exits
if isfile(strcat(saveFolder, db.mouseName, '_', db.date, '_eventLibrary_2D.mat'))
    disp('Loading existing event library ...')
    filepath = strcat(saveFolder, db.mouseName, '_', db.date, '_eventLibrary_2D.mat');
    load(filepath)
    disp('... done!')
else
    %Use real 2D data
    cellMean = zeros(nCells, 1);
    cellStddev = zeros(nCells, 1);
    binaryData = zeros(nCells, 1);
    
    disp('Basic scan for calcium events ...')
    
    %Preallocation
    s.nEvents = 0;
    s.eventStartIndices = [];
    s.eventWidths = [];
    eventLibrary_2D = repmat(s, 1, nCells);
    clear s
    
    for cell = 1:nCells
        sampledCellActivity = squeeze(realProcessedData.dfbf_2D(cell, :));
        cellMean(cell) = mean(sampledCellActivity);
        cellStddev(cell) = std(sampledCellActivity);
        logicalIndices = sampledCellActivity > (cellMean(cell) + 2* cellStddev(cell));
        binaryData(logicalIndices, 1) = 1;
        minNumberOf1s = 3;
        [nEvents, StartIndices, Width] = findConsecutiveOnes(binaryData, minNumberOf1s);
        eventLibrary_2D(cell).nEvents = nEvents;
        eventLibrary_2D(cell).eventStartIndices = StartIndices;
        eventLibrary_2D(cell).eventWidths = Width;
        
        clear binaryData
        clear Events
        clear StartIndices
        clear Lengths
    end
    save(strcat(saveFolder, db.mouseName, '_', db.date, '_eventLibrary_2D.mat'), 'eventLibrary_2D')
    disp('... library curated and saved!')
end

%% Generate synthetic dataset(s)
%Preallocation
s.syntheticDATA = zeros(nCells, nTrials, nFrames);
s.syntheticDATA_2D = zeros(nCells, nTrials * nFrames);
s.maxSignal = zeros(nCells, 1);
s.ptcList = [];
s.ocList = [];
s.nCells = nCells;
s.actualEventWidth = zeros(nCells, 2);
s.allEventWidths = zeros(nCells, nTrials);
s.hitTrialPercent = zeros(nCells, 1);
s.hitTrials = zeros(nCells, nTrials);
s.frameIndex = zeros(nCells, nTrials);
s.pad = zeros(nCells, nTrials);
s.noiseComponent = zeros(nCells, nTrials, nFrames);
s.scurr = {};
s.endTime = '';
s.Q = zeros(nCells, 1);
s.T = zeros(nCells, 1);
sdo_batch = repmat(s, 1, nDatasets);
clear s

for runi = 1:1:nDatasets
    fprintf('Currently generating dataset: %i\n', runi)
    sdo = syntheticDataMaker(db, realProcessedData.dfbf_2D, eventLibrary_2D, sdcp(runi), runi);
    
    %Run specifics
    scurr = rng;
    sdo.scurr = scurr; %Saves current status of randomseed
    sdo.endTime = datestr(now,'mm-dd-yyyy_HH-MM');
    
    % Develop Quality (Q)
    params4Q.nCells = nCells;
    params4Q.hitTrialPercent = sdo.hitTrialPercent;
    params4Q.noisePercent = sdcp(runi).noisePercent;
    params4Q.eventAmplificationFactor = sdcp(runi).eventAmplificationFactor;
    params4Q.maxSignal = sdo.maxSignal;
    %params4Q.actualEventWidth = sdo.actualEventWidth;
    params4Q.allEventWidths = sdo.allEventWidths;
    params4Q.hitTrials = sdo.hitTrials;
    %params4Q.imprecisionFWHM = sdcp(runi).imprecisionFWHM;
    params4Q.pad = sdo.pad;
    params4Q.stimulusWindow = sdcp(runi).endFrame - sdcp(runi).startFrame;
    params4Q.alpha = 1;
    params4Q.beta = 1;
    params4Q.gamma = 10;
    
    sdo.Q = developQ(params4Q);
    
    %     % Derived Time
    %     delta = 3;
    %     skipFrames = [];
    %     [ETH, ETH_3D, nbins] = getETH(sdo.syntheticDATA, delta, skipFrames);
    %     %[~, derivedT] = max(ETH(sdo.ptcList,:), [], 2); % Actual Time Vector
    %     [~, derivedT] = max(ETH(:,:), [], 2); % Actual Time Vector
    %     sdo.T = derivedT;
    sdo.T = zeros(nCells, 1); %No strict need
    
    sdo_batch(runi) = sdo;
end

%% Save Everything
if ops0.saveData == 1
    disp ('Saving everything ...')
    save(strcat(saveFolder, ...
        'synthDATA_', ...
        num2str(gDate), ...
        '_gRun', num2str(gRun), ...
        '_batch_', ...
        num2str(nDatasets), ...
        '.mat'), ...
        'sdcp', 'sdo_batch', ...
        '-v7.3')
    disp('... done!')
end
elapsedTime = toc;
disp('All done!')
fprintf('Elapsed Time: %.4f seconds\n', elapsedTime)

if ops0.diary
    diary off
end