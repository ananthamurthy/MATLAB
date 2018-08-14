% Comparing Probe Trials vs All Trials
fig7 = figure(7);
set(fig7,'Position', [700, 700, 1200, 500]);
subFig1 = subplot(1,2,1);
%plot Sorted data
trialPhase = 'All Trials';
plotSequences(db(iexp), myData.dfbf_sorted_timeCells(:,:,window), trialPhase, 'Frames', 'Unsorted Cells', figureDetails, 0)
colormap('cool')

subFig2 = subplot(1,2,2);
%plot sorted data
trialPhase = 'Probe Trials';
plotSequences(db(iexp), myData.dfbf_sorted_timeCells(:,find(probeTrials),window), trialPhase, 'Frames', 'Sorted Cells', figureDetails, 0)
colormap('cool')
% z = colorbar;
% %cbfreeze(z)
% set(z,'YTick',[0, 100])
% set(z,'YTickLabel',({'0%'; '100%'}))

print(['/Users/ananth/Desktop/timeCells_allProbeTrialsAvg_sorted_' ...
    db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session)],...
    '-djpeg');