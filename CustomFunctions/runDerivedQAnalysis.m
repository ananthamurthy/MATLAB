function [derivedQOutput] = runDerivedQAnalysis(DATA, derivedQInput)

delta = derivedQInput.delta;
skipFrames = derivedQInput.skipFrames;

nCells = size(DATA, 1);
nTrials = size(DATA, 2);
nFrames = size(DATA, 3);

%Preallocation
hitTrials = zeros(nCells, nTrials);
Q1 = nan(nCells, 1);
Q2 = nan(nCells, 1);
peakTimeBin = nan(nCells, 1);
peakTrialTimeBin = nan(nCells, nTrials);
maxSignal = nan(nCells, 1);
HTR = nan(nCells, 1);
NbyS1 = nan(nCells, 1);
NbyS2 = nan(nCells, 1);
SDbyMEW = nan(nCells, 1);
SDPbySW = nan(nCells, 1);
p = zeros(nCells, nTrials);
timeCells = nan(nCells, 1);

%NOTE: 'DATA' is organized as (cells, trials, frames)
%2D DATA (cells, all frames)
for cell = 1:nCells
    DATA_2D(cell, :) = reshape(squeeze(DATA(cell, :, :))', 1, []);
end

%Use real 2D data to curate a library
%Preallocation - for event library
s.nEvents = 0;
s.eventStartIndices = [];
s.eventWidths = [];
eventLibrary_2D = repmat(s, 1, nCells);
clear s
cellMean = zeros(nCells, 1);
cellStddev = zeros(nCells, 1);
binaryData = zeros(nCells, 1);

disp('Scanning for calcium events ...')
for cell = 1:nCells
    sampledCellActivity = squeeze(DATA_2D(cell, :));
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
disp('... done!')

%Develop Event Time Histogram (ETH) Curves
[ETH, trialAUCs, ~] = getETH(DATA, delta, skipFrames);

for cell = 1:nCells
    %Find ETH Peak
    [~, peakTimeBin(cell)] = max(ETH(cell, :));
    
    for trial = 1:nTrials
        %Find Trial-wise peak time bins
        [~, peakTrialTimeBin(cell, trial)] = max(trialAUCs(cell, trial, :));
        
        %Find Hit Trials
        if peakTrialTimeBin(cell, trial) == peakTimeBin(cell)
            hitTrials(cell, trial) = 1;
        else
            hitTrials(cell, trial) = 0;
        end
    end
    %Find Hit Trial Ratio (HTR)
    HTR(cell) = sum(hitTrials(cell, :))/nTrials;
    
    a = derivedQInput.alpha;
    %Establish Noise by Signal - 2 measures
    maxSignal(cell) = max(DATA_2D(cell, :)); %Should I consider a percentile value?
    
    noiseVar1 = evar(DATA_2D(cell, :));
    NbyS1(cell) = sqrt(noiseVar1)/maxSignal(cell);
    
    noiseVar2 = estimatenoise(DATA_2D(cell, :));
    NbyS2(cell) = sqrt(noiseVar2)/maxSignal(cell);
    
    b = derivedQInput.beta;
    %Find all event widths
    aew = eventLibrary_2D(cell).eventWidths;
    %     sdAEW = nanstd(aew(ht)); %Only Hit Trials
    %     mAEW = nanmean(aew(ht)); %Only Hit Trials
    sdAEW = nanstd(aew); %All events
    mAEW = nanmean(aew); %All events
    SDbyMEW(cell) = sdAEW/mAEW;
    
    g = derivedQInput.gamma;
    %Find Imprecision or Pad (p)
    for trial = 1:nTrials
        p(cell, trial) = peakTimeBin(cell) - peakTrialTimeBin(cell, trial);
    end
    sdp = std(p(cell, :));
    %sw = derivedQInput.stimulusWindow;
    sw = nFrames;
    SDPbySW(cell) = sdp/sw;
    
    Q1(cell) = HTR(cell) * exp(-1 * ((a * NbyS1(cell)) + (b * SDbyMEW(cell)) + (g * SDPbySW(cell))));
    Q2(cell) = HTR(cell) * exp(-1 * ((a * NbyS2(cell)) + (b * SDbyMEW(cell)) + (g * SDPbySW(cell))));
end

derivedQOutput.Q1 = Q1;
derivedQOutput.Q2 = Q2;
derivedQOutput.T = peakTimeBin;
derivedQOutput.timeCells = timeCells;
end