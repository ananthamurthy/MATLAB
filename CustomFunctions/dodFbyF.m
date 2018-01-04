%Dataset is "db". This has all the information about the dataset
%Data has the raw fluorescence traces

function [dfbf, baselines, dfbf_2D] = dodFbyF(dataset, Data)

disp('Performing dF/F calculation ...')

[nCells, ~] = size(Data);

baselines = nan(nCells, dataset.nTrials);
dfbf = nan(nCells, dataset.nTrials, dataset.nFrames);
dfbf_2D = nan(nCells,dataset.nTrials*dataset.nFrames);

raw = nan(nCells, dataset.nTrials, dataset.nFrames);
for cell = 1:nCells
    for trial = 1:dataset.nTrials
        count = trial-1;
        
        %First, separate out the trials, to do a proper dF/F
        raw(cell, trial, :) = Data(cell,((count*dataset.nFrames)+1:(count*dataset.nFrames)+dataset.nFrames));
        
        %* 10 percentile value correction
        baselines(cell,trial) = prctile(squeeze(raw(cell, trial, :)), 10);
        dfbf(cell, trial, :) = ((raw(cell, trial, :) - baselines(cell,trial))/baselines(cell,trial)); % Change in Fluorescence relative to baseline
        
        % All trials
        dfbf_2D(cell,(((count*dataset.nFrames)+1):(count*dataset.nFrames)+dataset.nFrames))=dfbf(cell,trial,:);
    end  % calbdf
end
disp('... done!')