%%Temp
for trial = 1:60
    pause(0.1)
    imagesc(squeeze(realProcessedData.cellRastor(:,trial,:)))
    title(['Trial:' num2str(trial)])
    xlabel('Frame Number')
    ylabel('Cells')
    z = colorbar;
    set(z,'YTick',[0, 1])
    set(z,'YTickLabel',({'0', '1'}))
    colormap('gray')
end