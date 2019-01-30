close all
figureDetails.fontSize = 20;
figureDetails.lineWidth = 2;
figureDetails.markerSize = 10;
figureDetails.transparency = 0.5;
Data = dfbf_sigOnly;

trialPhase = 'Post-US';
if strcmp(trialPhase, 'Pre-CS')
    window = 1:116;
elseif strcmp(trialPhase, 'ISI')
    window = 116:123;
elseif strcmp(trialPhase, 'Post-US')
    window = 125:246;
else
    error('Unable to identify trial phase')
end

%importantFrames = identifySequenceFragments(Data, skipFrames);
AUC = doAUC(Data(:,:,window), 50); %(Data, percentile)
normalizedAUC = AUC/(length(window));

fig2 = figure(2);
set(fig2,'Position', [300, 300, 900, 500]);
%All cells
subplot(5,1,1:2)
%C = squeeze(sum(importantFrames(:,:,window), 3)); %sum of trials, for the window
%imagesc(C)
imagesc(normalizedAUC);
title(sprintf('All Cells - AUC (A.U.) - %s', trialPhase), ...
    'FontSize', figureDetails.fontSize)
%xlabel('Trials')
ylabel('Cell#', ...
    'FontSize', figureDetails.fontSize)
z = colorbar;
caxis([0 1])
ylabel(z,'AUC (A.U.)', ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize',figureDetails.fontSize-4)
%Not Time-locked cells
subplot(5,1,3:4)
%D = C(find(~timeLockedCells),:);
%imagesc(D)
imagesc(normalizedAUC(find(~timeLockedCells),:))
%colormap('hot')
title(sprintf('Not Tuned Cells - AUC (A.U.) - %s', trialPhase), ...
    'FontSize', figureDetails.fontSize)
%xlabel('Trials')
ylabel('Cell#', ...
    'FontSize', figureDetails.fontSize)
z = colorbar;
caxis([0 1])
ylabel(z,'AUC (A.U.)', ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize',figureDetails.fontSize-4)
%Time-locked cells
subplot(5,1,5)
%E = C(find(timeLockedCells),:);
%imagesc(E)
imagesc(normalizedAUC(find(timeLockedCells),:))
title(sprintf('Tuned Cells - AUC (A.U.) - %s', trialPhase), ...
    'FontSize', figureDetails.fontSize)
colormap('hot')
xlabel('Trials', ...
    'FontSize', figureDetails.fontSize)
ylabel('Cell#', ...
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

fig3 = figure(3);
set(fig3,'Position', [300, 300, 900, 500]);
%All cells
subplot(3,1,1)
%C = squeeze(sum(importantFrames(:,:,window), 3)); %sum of trials, for the window (no puff frame)
plot(sum(normalizedAUC,1), 'blue', 'LineWidth', 2)
hold on
m = mean(sum(normalizedAUC,1));
x = 1:60;
plot(x,m, 'r*')
title(sprintf('Pooling All Cells - %s', trialPhase), ...
    'FontSize', figureDetails.fontSize)
%xlabel('Trials')
ylabel('AUC (A.U.)', ...
    'FontSize', figureDetails.fontSize)
legend({'Sum'; 'Mean'})
set(gca,'FontSize',figureDetails.fontSize-4)
%Not Time-locked cells
subplot(3,1,2)
%D = C(find(~timeLockedCells),:);
normalizedAUC_notTuned = normalizedAUC(find(~timeLockedCells),:);
plot(sum(normalizedAUC_notTuned,1), 'blue', 'LineWidth', 2)
hold on
m = mean(sum(normalizedAUC_notTuned,1));
x = 1:60;
plot(x,m, 'r*')
title(sprintf('Pooling Not Tuned Cells - %s', trialPhase), ...
    'FontSize', figureDetails.fontSize)
%colormap('hot')
xlabel('Trials')
ylabel('AUC (A.U.)', ...
    'FontSize', figureDetails.fontSize)
legend({'Sum'; 'Mean'})
set(gca,'FontSize',figureDetails.fontSize-4)
%Time-locked cells
subplot(3,1,3)
normalizedAUC_Tuned = normalizedAUC(find(timeLockedCells),:);
plot(sum(normalizedAUC_Tuned,1), 'blue', 'LineWidth', 2)
hold on
m = mean(sum(normalizedAUC_Tuned,1));x = 1:60;
plot(x,m, 'r*')
title(sprintf('Pooling Tuned Cells - %s', trialPhase), ...
    'FontSize', figureDetails.fontSize)
%colormap('hot')
ylabel('AUC (A.U.)')
legend({'Sum'; 'Mean'})
set(gca,'FontSize',figureDetails.fontSize-4)
print(sprintf('/Users/ananth/Desktop/AUC_line_%s_%i_%i_%s', ...
    db(iexp).mouse_name, db(iexp).sessionType, db(iexp).session, trialPhase), ...
    '-djpeg');
%% Legacy
% fig1 = figure(1);
% set(fig1,'Position', [300, 300, 2000, 600]);
%
% %All cells
% subplot(2,2,1)
% A = squeeze(sum(importantFrames, 3)); %sum along frames
% imagesc(A)
% title('Sum of Significant Frames - Whole Trial')
% xlabel('Trials')
% ylabel('All Cells')
% %Time-locked cells
% subplot(2,2,3)
% B = A(find(timeLockedCells),:);
% imagesc(B)
% title('Sum of Significant Frames - Whole Trial')
% colormap('hot')
% xlabel('Trials')
% ylabel('Time-Locked Cells')
%
% %All cells
% subplot(2,2,2)
% C = squeeze(sum(importantFrames(:,:,101:120), 3)); %sum of trials, for the stimulus window
% imagesc(C)
% title('Sum of Significant Frames - Stimulus Window (CS: 116)')
% xlabel('Trials')
% ylabel('All Cells')
% %Time-locked cells
% subplot(2,2,4)
% D = C(find(timeLockedCells),:);
% imagesc(D)
% colormap('hot')
% xlabel('Trials')
% ylabel('Time-Locked Cells')

