function [stcaOutput] = runSimpleTCAnalysis(DATA, simpleInput)
delta = simpleInput.delta;
skipFrames = simpleInput.skipFrames;
%trialThreshold = simpleInput.trialThreshold;

%{
THINGS TO DO:
Use some 'tcellThreshold' to determine time cells.
%}

[ETH, trialAUCs, nBins] = getETH(DATA, delta, skipFrames);

nCells = size(DATA, 1);
nTrials = size(DATA, 2);

%Preallocation
hitTrial = zeros(nCells, nTrials);
Q1 = nan(nCells, 1);
Q2 = nan(nCells, 1);
peakTimeBin = nan(nCells, 1);
timeCells = nan(nCells, 1);
ksstat = nan(nCells, 1);
peakTrialTimeBin = nan(nCells, nTrials);

%Develop CDF for a uniform distribution
test_cdf = [1:nBins; cdf('Uniform', 1:nBins, 1, nBins)];

for cell = 1:nCells
    % Time Vector
    [~, peakTimeBin(cell)] = max(squeeze(ETH(cell, :)));
    
    for trial = 1:nTrials
        m = mean(squeeze(trialAUCs(cell, trial, :)));
        s = std(squeeze(trialAUCs(cell, trial, :)));
        
        threshold = m + 2*s;
        
        % Check for Hit Trials
        if trialAUCs(cell, trial, peakTimeBin(cell)) >= threshold
            hitTrial(cell, trial) = 1;
        end
        [~, peakTrialTimeBin(cell, trial)] = max(trialAUCs(cell, trial, :));
        
        clear m
        clear s
        clear threshold
    end
    
    [~, ~ , ksstat(cell), ~] = kstest(peakTrialTimeBin(cell, :), 'CDF', test_cdf');
    
    %Develop Q1
    Q1(cell) = (sum(squeeze(hitTrial(cell, :)))/nTrials) * ksstat(cell); %Q1 = hit trial ratio * ksstat
    
    % Develop Q2
    meanTimedPeak = mean(trialAUCs(cell, :, peakTimeBin(cell)));
    stdTimedPeak = std(trialAUCs(cell, :, peakTimeBin(cell)));
    Q2(cell) = meanTimedPeak/stdTimedPeak;
end

%stcaOutput.ETH = ETH;
stcaOutput.Q1 = Q1;
stcaOutput.Q2 = Q2;
stcaOutput.T = peakTimeBin;
stcaOutput.timeCells = timeCells;

end