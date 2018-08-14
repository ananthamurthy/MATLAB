% All trials in groups of of 10 trials
fig7 = figure(7);
set(fig7,'Position', [700, 700, 1200, 500]);
subFig1 = subplot(3,2,1);
%plot sorted data
trialPhase = '1 to 10';
plotSequences(db(iexp), myData.dfbf_sorted_timeCells(:,1:10,window), trialPhase, 'Frames', 'Sorted Cells', figureDetails, 0)
colormap('cool')

subFig2 = subplot(3,2,2);
%plot sorted data
trialPhase = '11 to 20';
plotSequences(db(iexp), myData.dfbf_sorted_timeCells(:,11:20,window), trialPhase, 'Frames', 'Sorted Cells', figureDetails, 0)
colormap('cool')

subFig3 = subplot(3,2,3);
%plot sorted data
trialPhase = '21 to 30';
plotSequences(db(iexp), myData.dfbf_sorted_timeCells(:,21:30,window), trialPhase, 'Frames', 'Sorted Cells', figureDetails, 0)
colormap('cool')

subFig4 = subplot(3,2,4);
%plot sorted data
trialPhase = '31 to 40';
plotSequences(db(iexp), myData.dfbf_sorted_timeCells(31:40,:,window), trialPhase, 'Frames', 'Sorted Cells', figureDetails, 0)
colormap('cool')

subFig5 = subplot(3,2,5);
%plot sorted data
trialPhase = '41 to 50';
plotSequences(db(iexp), myData.dfbf_sorted_timeCells(41:50,:,window), trialPhase, 'Frames', 'Sorted Cells', figureDetails, 0)
colormap('cool')

subFig6 = subplot(3,2,6);
%plot sorted data
trialPhase = '51 to 60';
plotSequences(db(iexp), myData.dfbf_sorted_timeCells(51:60,:,window), trialPhase, 'Frames', 'Sorted Cells', figureDetails, 0)
colormap('cool')