function [stcaOutput] = runSimpleTCAnalysis(DATA, delta, skipFrames)

[ETH, ETH_3D, ~] = getETH(DATA, delta, skipFrames);

nCells = size(ETH_3D, 1);
nTrials = size(ETH_3D, 2);
%nBins = size(ETH_3D, 3);

%Preallocation
meanETH = zeros(size(ETH, 1));
medianETH = zeros(size(ETH, 1));
zeroSkewCase = zeros(size(ETH, 1));
%unimodalCase = zeros(size(ETH, 1));
%event = zeros(size(ETH_3D));
hitTrial = zeros(size(DATA,1), size(DATA,2));
Q = zeros(size(DATA, 1), 1);
time = zeros(size(DATA, 1), 1);

for cell = 1:nCells
    % Skewness to check for time cells
    meanETH(cell) = mean(squeeze(ETH(cell, :)));
    medianETH(cell) = prctile(ETH(cell, :), 50);
    
    % Time Vector
    [~, time(cell)] = max(squeeze(ETH(cell, :)));
    
    if meanETH(cell) == medianETH(cell)
        zeroSkewCase(cell) = 1;
    end
    
    for trial = 1:nTrials
        m = mean(squeeze(ETH_3D(cell, trial, :)));
        s = std(squeeze(ETH_3D(cell, trial, :)));
        
        threshold = m + 2*s;
        
        % Check for Hit Trials
        if ETH_3D(cell, trial, time(cell)) >= threshold
            hitTrial(cell, trial) = 1;
        end
        
%         % Check for Events
%         for bin = 1:size(ETH_3D,3)
%             if ETH_3D(cell, trial, bin) > threshold
%                 event(cell, trial, bin) = 1;
%             end
%         end
    end
    
    %Develop Q
    Q(cell) = sum(squeeze(hitTrial(cell, :)))/nTrials;
end

timeCells = [];

stcaOutput.ETH = ETH;
stcaOutput.Q = Q;
stcaOutput.T = time;
stcaOutput.timeCells = timeCells;

end