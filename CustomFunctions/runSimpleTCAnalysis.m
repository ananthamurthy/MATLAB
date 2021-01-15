function [stcaOutput] = runSimpleTCAnalysis(DATA, simpleInput)
delta = simpleInput.delta;
skipFrames = simpleInput.skipFrames;
nIterations = simpleInput.nIterations;
threshold = simpleInput.threshold;

%Preallocation
nCells = size(DATA, 1);
nTrials = size(DATA, 2);
%nFrames = size(DATA, 3);
hitTrial = zeros(nCells, nTrials);
hitTrial_rand = nan(nCells, nTrials, nIterations);
Q1 = nan(nCells, 1);
Q1_rand = nan(nCells, nIterations);
Q2 = nan(nCells, 1);
Q2_rand = nan(nCells, nIterations);
peakTimeBin = nan(nCells, 1);
peakTimeBin_rand = nan(nCells, nIterations);
ksstat = nan(nCells, 1);
ksstat_rand = nan(nCells, nIterations);
peakTrialTimeBin = nan(nCells, nTrials);
peakTrialTimeBin_rand = nan(nCells, nTrials, nIterations);
timeCells1 = nan(nCells, 1);
timeCells2 = nan(nCells, 1);

[ETH, trialAUCs, nBins] = getETH(DATA, delta, skipFrames);

%Develop CDF for a uniform distribution
test_cdf = [1:nBins; cdf('Uniform', 1:nBins, 1, nBins)];

for cell = 1:nCells
    % Time Vector
    [~, peakTimeBin(cell)] = max(squeeze(ETH(cell, :)));
    
    for trial = 1:nTrials
        m = mean(squeeze(trialAUCs(cell, trial, :)));
        s = std(squeeze(trialAUCs(cell, trial, :)));
        
        % Check for Hit Trials
        if trialAUCs(cell, trial, peakTimeBin(cell)) >= m + 2*s
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

%Generate circularly shifted randomized data
for i = 1:simpleInput.nIterations
    randDATA = generateRandData(DATA);
    
    [ETH_rand, trialAUCs_rand, ~] = getETH(randDATA, delta, skipFrames);
    
    for cell = 1:nCells
        % Time Vector
        [~, peakTimeBin_rand(cell, i)] = max(squeeze(ETH_rand(cell, :)));
        
        for trial = 1:nTrials
            m = mean(squeeze(trialAUCs_rand(cell, trial, :)));
            s = std(squeeze(trialAUCs_rand(cell, trial, :)));
            
            % Check for Hit Trials
            if trialAUCs(cell, trial, peakTimeBin_rand(cell)) >= m + 2*s
                hitTrial_rand(cell, trial, i) = 1;
            end
            [~, peakTrialTimeBin_rand(cell, trial, i)] = max(trialAUCs(cell, trial, :));
            
            clear m
            clear s
            clear threshold
        end
        
        [~, ~ , ksstat_rand(cell, i), ~] = kstest(peakTrialTimeBin(cell, :), 'CDF', test_cdf');
        
        %Develop Q1
        Q1_rand(cell, i) = (sum(squeeze(hitTrial_rand(cell, :, i)))/nTrials) * ksstat_rand(cell, i); %Q1 = hit trial ratio * ksstat
        
        % Develop Q2
        meanTimedPeak = mean(trialAUCs_rand(cell, :, peakTimeBin_rand(cell, i)));
        stdTimedPeak = std(trialAUCs_rand(cell, :, peakTimeBin_rand(cell, i)));
        Q2_rand(cell, i) = meanTimedPeak/stdTimedPeak;
    end
end

%Classify Time Cells
for cell = 1:nCells
    score1 = (sum(Q1(cell)>Q1_rand(cell, :))/simpleInput.nIterations)*100;
    score2 = (sum(Q2(cell)>Q2_rand(cell, :))/simpleInput.nIterations)*100;
    
    if score1 > simpleInput.threshold
        timeCells1(cell) = 1;
    else
        timeCells1(cell) = 0;
    end
    
    if score2 > simpleInput.threshold
        timeCells2(cell) = 1;
    else
        timeCells2(cell) = 0;
    end
end

%stcaOutput.ETH = ETH;
stcaOutput.Q1 = Q1;
stcaOutput.Q2 = Q2;
stcaOutput.T = peakTimeBin;
stcaOutput.timeCells1 = timeCells1;
stcaOutput.timeCells2 = timeCells2;

end