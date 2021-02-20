function [peakTimeBin, Q1, Q2] = derivedQAnalysis(DATA, derivedQInput)

nCells = size(DATA, 1);
nTrials = size(DATA, 2);
delta = derivedQInput.delta;
skipFrames = derivedQInput.skipFrames;

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

%NOTE: 'DATA' is organized as (cells, trials, frames)
nCells = size(DATA, 1);
nTrials = size(DATA, 2);
nFrames = size(DATA, 3);
DATA_2D = nan(nCells, nTrials * nFrames);

%2D DATA (cells, all frames)
for cell = 1:nCells
    DATA_2D(cell, :) = reshape(squeeze(DATA(cell, :, :))', 1, []);
end

%Use real 2D data to curate a library
%dbase = derivedQInput.dbase;
%saveFolder = derivedQInput.saveFolder;
eventLibrary_2D = curateLibrary(DATA_2D);

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
    fprintf('1>Cell: %i - Noise1 = %d, NbyS1 = %d\n', cell, noiseVar1, NbyS1(cell))
    
    noiseVar2 = estimatenoise(DATA_2D(cell, :));
    NbyS2(cell) = sqrt(noiseVar2)/maxSignal(cell);
    fprintf('2>Cell: %i - Noise2 = %d, NbyS2 = %d\n', cell, noiseVar2, NbyS2(cell))
    
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

end