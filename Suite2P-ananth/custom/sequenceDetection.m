%close all
%%

if sessionType ==1
    %intervals
    preDuration        = 8.0000; %in seconds
    csDuration         = 0.0500; %in seconds
    traceDuration      = 0.2500; %in seconds
    usDuration         = 0.0500; %in seconds
    postDuration       = 8.0000; %in seconds
    
    %frames
    %CS
    csOnFrame = floor(preDuration*frameRate) + 1;
    csOffFrame = csOnFrame + floor(csDuration*frameRate);
    %trace
    traceOnFrame = csOffFrame + 1;
    traceOffFrame = traceOnFrame + floor(traceDuration*frameRate);
    % US
    usOnFrame = traceOffFrame + 1;
    usOffFrame = usOnFrame + floor(usDuration*frameRate);
    
    % CS + Trace + USimagesc(stimWindow_trialAvg)
    stimWindow = csOnFrame:usOffFrame;
end

nCells = size(calbdf,1);
nTrials = size(calbdf,2);

% Trial average
stimWindow_trials = calbdf(:,:,stimWindow);
stimWindow_trialAvg = squeeze(mean(stimWindow_trials,2)); %2nd dimension is trials

% Sorting (based on Trial Averaged data)
% Find peaks

stimWindow_trialAvg_peakIndex = zeros(1:nCells);
%sortedCellIndices = zeros(1:nCells);

for cell = 1:nCells
    [~, stimWindow_trialAvg_peakIndex(cell)] = max(stimWindow_trialAvg(cell,:));
    clear value
end

[peaks, sortedCellIndices] = sort(stimWindow_trialAvg_peakIndex);

fig5 = figure(5);
subFig1 = subplot(1,2,1);
imagesc(stimWindow_trialAvg)
title('CS + Trace + US Window - Trial Averaged')
colorbar
colormap(fig5,'jet')
xlabel('Frames', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
set(gca,'XTick', [1,3,5])
set(gca,'XTickLabel', {'CS'; 'Trace'; 'US'})
ylabel('Unsorted Cells', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize', fontSize-2)


