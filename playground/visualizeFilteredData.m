% %Trial Averaged Data
% A = squeeze(mean(dfbf_sigOnly,2));
% B = squeeze(mean(dfbf_sigOnly_smooth,2));
% 
% figure(8)
% subplot(1,2,1)
% imagesc(A)
% colormap('hot')
% colorbar
% title('Significant-Only Data')
% xlabel('Frames')
% ylabel('Unsorted Cells')
% set(gca,'FontSize', 20)
% 
% subplot(1,2,2)
% imagesc(B)
% colormap('hot')
% colorbar
% title('Smoothed Data')
% xlabel('Frames')
% ylabel('Unsorted Cells')
% set(gca,'FontSize', 20)

%% Individual cells
cell = 63;
fig9 = figure(9);
clf
set(fig9,'Position',[300,300,1200,1000])
%Raw
subplot(2,2,1)
for trial = 1:size(dfbf_sigOnly,2)
    plot(squeeze(dfbf_sigOnly(cell, trial, :)*100 + 30*(trial-1)), 'b', 'LineWidth', 2)
    hold on
end
xlim([0 260])
title(sprintf('Raw | Cell: %i', cell))
xlabel('Frames')
ylabel('Trials -->')
yticks([])
set(gca,'FontSize', 20)
%Raw - trial avg
subplot(2,2,2)
plot(squeeze(mean(dfbf_sigOnly(cell, :, :)*100, 2)), 'r', 'LineWidth', 2)
xlim([0 260])
title(sprintf('Raw - Trial Avg | Cell: %i', cell))
xlabel('Frames')
ylabel('dF/F')
set(gca,'FontSize', 20)
%Smoothed
subplot(2,2,3)
for trial = 1:size(dfbf_sigOnly,2)
    plot(squeeze(dfbf_sigOnly_smooth(cell, trial, :)*100 + 30*(trial-1)), 'b', 'LineWidth', 2)
    hold on
end
xlim([0 260])
title(sprintf('Smoothed | nSamples: %i | Cell: %i', nSamples, cell))
xlabel('Frames')
ylabel('Trials -->')
yticks([])
set(gca,'FontSize', 20)
%Smoothed - trial avg
subplot(2,2,4)
plot(squeeze(mean(dfbf_sigOnly_smooth(cell, :, :)*100, 2)), 'r', 'LineWidth', 2)
xlim([0 260])
title(sprintf('Smoothed - Trial Avg | nSamples: %i | Cell: %i', nSamples, cell))
xlabel('Frames')
ylabel('dF/F (%)')
set(gca,'FontSize', 20)