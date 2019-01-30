trialPhase = 'Whole Trial';
window = 1:245;
AUC = doAUC(Data(:,:,window), 50); %(Data, percentile)
normalizedAUC = AUC/(length(window));

fig1 = figure(1);
set(fig1,'Position', [300, 300, 1000, 600]);
%All cells
%C = squeeze(sum(importantFrames(:,:,window), 3)); %sum of trials, for the window
%imagesc(C)
imagesc(normalizedAUC);
colormap('hot')
title(sprintf('Area Under the Curve - %s', trialPhase), ...
    'FontSize', figureDetails.fontSize)
xlabel('Trials', ...
    'FontSize', figureDetails.fontSize)
ylabel('All Cells', ...
    'FontSize', figureDetails.fontSize)
z = colorbar;
caxis([0 1])
ylabel(z,'AUC (A.U.)', ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize',figureDetails.fontSize-4)
print(sprintf('/Users/ananth/Desktop/AUC_%s_%i_%i_%s', ...
    db(iexp).mouse_name, db(iexp).sessionType, db(iexp).session, trialPhase), ...
    '-djpeg');