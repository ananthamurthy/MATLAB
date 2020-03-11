tic
close all
clear

addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions')) % my custom functions
addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis')) % Additional functions
addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis/Suite2P-ananth'))

%ops0.fig             = 1;
ops0.saveData        = 1;

figureDetails = compileFigureDetails(16, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)
%ops0.onlyProbeTrials = 0

%% Load real dataset details
make_db

fprintf('Reference Dataset - %s_%i_%i | Date: %s\n', db.mouseName, ...
    db.sessionType, ...
    db.session, ...
    db.date)

saveDirec = '/Users/ananth/Desktop/Work/Analysis/Imaging/';
saveFolder = [saveDirec db.mouseName '/' db.date '/'];

%% Load processed dF/F data for dataset
realProcessedData = load([saveFolder db.mouseName '_' db.date '.mat']);
nCells = size(realProcessedData.dfbf, 1);
nTrials = size(realProcessedData.dfbf, 2);
nFrames = size(realProcessedData.dfbf, 3);
fprintf('Total cells: %i\n', nCells)

%% Setup synthetic dataset control parameters
setupSyntheticDataParameters_batch

%% Organize Library of Calcium Events
%Cell specific curation of the calcium event library
%Check to see if the library exits
if isfile([saveFolder db.mouseName '_' db.date '_eventLibrary_2D.mat'])
    disp('Loading existing event library ...')
    load([saveFolder db.mouseName '_' db.date '_eventLibrary_2D.mat'])
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
    save([saveFolder db.mouseName '_' db.date '_eventLibrary_2D.mat'], 'eventLibrary_2D')
    disp('... library curated and saved!')
end

%% Generate synthetic dataset(s)
%Preallocation
s.syntheticDATA = zeros(nCells, nTrials, nFrames);
s.syntheticDATA_2D = zeros(nCells, nTrials * nFrames);
s.ptcList = [];
s.ocList = [];
s.nTotalCells = nCells;
s.actualEventWidth = zeros(nCells, 2);
s.hitTrialPercent = zeros(nCells, 1);
s.hitTrials = zeros(nCells, nTrials);
s.frameIndex = zeros(nCells, nTrials);
s.pad = zeros(nCells, nTrials);
s.noiseComponent = zeros(nCells, nTrials, nFrames);
s.scurr = {};
s.endTime = '';
s.Q = zeros(nCells, 1);
s.T = zeros(nCells, 1);
sdo_batch = repmat(s, 1, length(sdcp));
clear s

%sdo = struct();
%Iterating backwards helps preallocate memory for the output "sdo"
%for i = length(sdcp): -1 : 1
for i = length(sdcp):-1:1
    fprintf('Currently running control parameter set: %i\n', i)
    sdo = syntheticDataMaker(db, realProcessedData.dfbf_2D, eventLibrary_2D, sdcp(i));
    
    %Run specifics
    scurr = rng;
    sdo.scurr = scurr; %Saves current status of randomseed
    sdo.endTime = datestr(now,'mm-dd-yyyy_HH-MM');
    
    % Develop Quality (Q)
    params4Q.nTotalCells = sdo.nTotalCells;
    params4Q.hitTrialPercent = sdo.hitTrialPercent;
    params4Q.eventAmplificationFactor = sdcp(i).eventAmplificationFactor;
    params4Q.actualEventWidth = sdo.actualEventWidth;
    params4Q.imprecisionFWHM = sdcp(i).imprecisionFWHM;
    params4Q.noisePercent = sdcp(i).noisePercent;
    
    sdo.Q = developQ(params4Q);
    
    % Derived Time
    delta = 3;
    skipFrames = [];
    [ETH, ETH_3D, nbins] = getETH(sdo.syntheticDATA, delta, skipFrames);
    %[~, derivedT] = max(ETH(sdo.ptcList,:), [], 2); % Actual Time Vector
    [~, derivedT] = max(ETH(:,:), [], 2); % Actual Time Vector
    sdo.T = derivedT;
    
    sdo_batch(i) = sdo;
end

%% Save Everything
if ops0.saveData == 1
    save([saveFolder ...
        'synthDATA' ...
        '-' num2str(i) ...
        '_tCP' num2str(sdcp(i).timeCellPercent) ...
        '_cO' lower(sdcp(i).cellOrder) ...
        '_mHTP' num2str(sdcp(i).maxHitTrialPercent) ...
        '_hTPA' lower(sdcp(i).hitTrialPercentAssignment) ...
        '_tO' lower(sdcp(i).trialOrder) ...
        '_eW' num2str(sdcp(i).eventWidth{1}) ...
        '_eAF' sdcp(i).eventAmplificationFactor ...
        '_eT' lower(sdcp(i).eventTiming) ...
        '_sF' num2str(sdcp(i).startFrame) ...
        '_eF' num2str(sdcp(i).endFrame) ...
        '_iFWHM' num2str(sdcp(i).imprecisionFWHM) ...
        '_iT' lower(sdcp(i).imprecisionType) ...
        '_n' lower(sdcp(i).noise) ...
        '_np' num2str(sdcp(i).noisePercent) ...
        '_batch', ...
        '.mat'], ...
        'sdcp', 'sdo_batch')
end

toc
disp('All done!')
