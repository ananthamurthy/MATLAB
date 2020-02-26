function [stcaOutput] = runSimpleTCAnalysis(DATA, delta, skipFrames, ~)

%Use some 'tcellThreshold' to determine time cells.

[ETH, trialAUCs, ~] = getETH(Data, delta, skipFrames);

nCells = size(DATA, 1);
nTrials = size(DATA, 2);

%Preallocation
meanETH = zeros(size(ETH, 1));
medianETH = zeros(size(ETH, 1));

%unimodalCase = zeros(size(ETH, 1));
%event = zeros(size(trialAUCs));
hitTrial = zeros(nCells, nTrials);
Q = zeros(nCells, 1);
time = zeros(nCells, 1);
timeCells = zeros(nCells, 1);
k = zeros(nCells, 1);
peakBin = zeros(nCells, nTrials);

for cell = 1:nCells
    % Skewness to check for time cells
    meanETH(cell) = mean(squeeze(ETH(cell, :)));
    medianETH(cell) = prctile(ETH(cell, :), 50);
    
    % Time Vector
    [~, time(cell)] = max(squeeze(ETH(cell, :)));
    
    for trial = 1:nTrials
        m = mean(squeeze(trialAUCs(cell, trial, :)));
        s = std(squeeze(trialAUCs(cell, trial, :)));
        
        threshold = m + 2*s;
        
        % Check for Hit Trials
        if trialAUCs(cell, trial, time(cell)) >= threshold
            hitTrial(cell, trial) = 1;
        end
        [~, peakBin(cell, trial)] = max(trialAUCs(cell, trial, :));
    end
    
    k(cell) = kurtosis(peakBin(cell, :));
    
    %Develop Q
    Q(cell) = (sum(squeeze(hitTrial(cell, :)))/nTrials) * k(cell);
end

timeCells = [];

stcaOutput.ETH = ETH;
stcaOutput.Q = Q;
stcaOutput.T = time;
stcaOutput.timeCells = timeCells;

end