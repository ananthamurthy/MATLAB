function plotSequences(dataset, Data, trialPhase, xtitle, ytitle, figureDetails, normalizeCell2Max)

if size(Data,1)>1
    Data_Avg = squeeze(mean(Data,2)); %Averages across trials
    %Data_Avg = squeeze(mean(Data,1)); %Averages across cells
    if normalizeCell2Max
        for cell = 1:size(Data_Avg,1)
            Data_Avg(cell,:) = Data_Avg(cell,:)/max(Data_Avg(cell,:));
        end
    end
else
    Data_Avg = squeeze(mean(squeeze(Data),1));
end

imagesc(Data_Avg*100)
%plot(Data_Avg'*100)
title([dataset.mouse_name ' ST' ...
    num2str(dataset.sessionType) ' S' ...
    num2str(dataset.session) ' | ', ...
    trialPhase ' | Trial-Averaged'])
colorbar
colormap('jet')
z = colorbar;
if normalizeCell2Max == 1
    ylabel(z,'Trial-Averaged Normalized dF/F (%)', ...
        'FontSize', figureDetails.fontSize, ...
        'FontWeight', 'bold')
else
    ylabel(z,'Trial-Averaged dF/F (%)', ...
        'FontSize', figureDetails.fontSize, ...
        'FontWeight', 'bold')
end
xlabel(xtitle, ...
    'FontSize', figureDetails.fontSize,...
    'FontWeight', 'bold')
if dataset.sessionType == 1
    set(gca,'XTick', [1,2,3,4,5,6])
    set(gca,'XTickLabel', {'CS';''; ''; 'Trace'; ''; 'US'})
    %     set(gca,'XTick', [1,2,3,4,5])
    %     set(gca,'XTickLabel', {'CS'; ''; 'Trace'; ''; 'US'})
elseif dataset.sessionType == 3
    set(gca,'XTick', [1,2,3,4,5,6,7,8,9])
    set(gca,'XTickLabel', {'CS';''; ''; ''; 'Trace'; ''; ''; ''; 'US'})
else
end
ylabel(ytitle, ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize', figureDetails.fontSize-2)