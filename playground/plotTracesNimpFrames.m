% %for cell = 1:size(find(timeLockedCells),1)
% Data = dfbf_sigOnly(find(timeLockedCells),:,:);
% cell = 7;
% fig = figure(cell);
% set(fig,'Position',[300,300,1000,300])
% subplot(1,2,1)
% imagesc(squeeze(Data(cell,:,:))*100);
% title(sprintf('Significant only traces for cell %i (dF/F)', cell))
% xlabel('Frames')
% ylabel('Trials')
% colorbar
% subplot(1,2,2)
% imagesc(squeeze(importantFrames(cell,:,:)));
% title(sprintf('importantFrames for cell %i', cell))
% xlabel('Frames')
% ylabel('Trials')
% colorbar
% colormap('cool')
% %keyboard
% %end

%for cell = 1:size(find(timeLockedCells),1)
for cell = 1:10
    subplot(3,10,cell)
    imagesc(squeeze(importantFrames(cell,:,:)));
    title(sprintf('impFrames for cell %i', cell))
    xlabel('Frames')
    ylabel('Trials')
    %colorbar
    colormap('cool')
end

for cell = 11:20
    subplot(3,10,cell)
    imagesc(squeeze(importantFrames(cell,:,:)));
    title(sprintf('impFrames for cell %i', cell))
    xlabel('Frames')
    ylabel('Trials')
    %colorbar
    colormap('cool')
end

for cell = 21:30
    subplot(3,10,cell)
    imagesc(squeeze(importantFrames(cell,:,:)));
    title(sprintf('impFrames for cell %i', cell))
    xlabel('Frames')
    ylabel('Trials')
    %colorbar
    colormap('cool')
end