%{
AUTHOR - Kambadur Ananthamurthy
TITLE - Area Under the Curve of Data
PROJECT DATE - 20181212

- The answer after the AUC calculation is in 'X'
- 'X' has the format '(cells, trials)
- The input argument 'Data' should be in the format '(cells, trials, frames)'
- The input argument 'percentile' is required to calcium the baseline for
  every trial
%}

function X = doAUC(Data, percentile)
%Preallocation - %nan-ing to avoid confusion;
X = nan(size(Data,1), size(Data,2));
baseline = nan(size(Data,1), size(Data,2));
Data_0 = nan(size(Data));

for cell = 1:size(Data,1)
    for trial = 1:size(Data,2)
        baseline(cell, trial) = prctile(squeeze(squeeze(Data(cell, trial,:))), percentile);
        for frame = 1:size(Data,3)
            % Set baselines to 0
            Data_0(cell, trial, frame) = Data(cell, trial, frame) - baseline(cell, trial);
            % Set negative values to 0
            if Data_0(cell, trial, frame)<0
                Data_0(cell,trial, frame) = 0;
            end
        end
        % Area under curve
        X(cell, trial) = trapz(Data_0(cell, trial, :));
    end
end
end