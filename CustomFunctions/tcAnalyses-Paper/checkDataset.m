% AUTHOR - Kambadur Ananthmurthy
function checkDataset(Data, mainTitle, xtitle, ytitle, figureDetails, normalizeCell2Max)

if normalizeCell2Max
    for cell = 1:size(Data,1)
        Data(cell,:) = Data(cell,:)/max(Data(cell,:));
    end
end

imagesc(Data*100);
colorbar
colormap('jet')
z = colorbar;
if normalizeCell2Max == 1
    ylabel(z,'Normalized dF/F (%)', ...
        'FontSize', figureDetails.fontSize, ...
        'FontWeight', 'bold')
else
    ylabel(z,'dF/F (%)', ...
        'FontSize', figureDetails.fontSize, ...
        'FontWeight', 'bold')
end

title(mainTitle , ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
set(gca,'XTick', [])
set(gca,'FontSize', figureDetails.fontSize-2)
colormap(figureDetails.colorMap)
end

%{
set(gca,'XTick', frameRate*(1:2:17)) %NOTE: Starting 5 frames are skipped
set(gca,'XTickLabel', ({1; 3; 5; 7; 9; 11; 13; 15; 17})) %NOTE: At 14.5 fps

xlabel(xtitle, ...
    'FontSize', figureDetails.fontSize,...
    'FontWeight', 'bold')
%set(gca,'YTick',[10, 20, 30, 40, 50, 60])
%set(gca,'YTickLabel',({10; 20; 30; 40; 50; 60}))
ylabel(ytitle, ...
    'FontSize', figureDetails.fontSize,...
    'FontWeight', 'bold')
%}