function plotParamSensitivityLinePlot(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)

ptcList = sdo_batch(dIndices(1)).ptcList;
ocList = sdo_batch(dIndices(1)).ocList;

for parami = 1:10
    for method = 1:7
        if method == 1 %orginal method
            yPTC(parami, method, :) = sdo_batch(dIndices(parami)).Q(ptcList);
            yOC(parami, method, :) = sdo_batch(dIndices(parami)).Q(ocList);
        elseif method == 2 %method A
            yPTC(parami, method, :) = cData.methodA.mAOutput_batch(dIndices(parami)).Q(ptcList);
            yOC(parami, method, :) = cData.methodA.mAOutput_batch(dIndices(parami)).Q(ocList);
        elseif method == 3 %method B
            yPTC(parami, method, :) = cData.methodB.holyData.mBOutput_batch(dIndices(parami)).Q(ptcList);
            yOC(parami, method, :) = cData.methodB.holyData.mBOutput_batch(dIndices(parami)).Q(ocList);
        elseif method == 4 %method C1
            yPTC(parami, method, :) = cData.methodC.mCOutput_batch(dIndices(parami)).Q1(ptcList);
            yOC(parami, method, :) = cData.methodC.mCOutput_batch(dIndices(parami)).Q1(ocList);
        elseif method == 5 %method C2
            yPTC(parami, method, :) = cData.methodC.mCOutput_batch(dIndices(parami)).Q2(ptcList);
            yOC(parami, method, :) = cData.methodC.mCOutput_batch(dIndices(parami)).Q2(ocList);
        elseif method == 6 %method D
            yPTC(parami, method, :) = cData.methodD.mDOutput_batch(dIndices(parami)).Q(ptcList);
            yOC(parami, method, :) = cData.methodD.mDOutput_batch(dIndices(parami)).Q(ocList);
        elseif method == 7 %method E
            yPTC(parami, method, :) = mEOutput_batch(dIndices(parami)).Q(ptcList);
            yOC(parami, method, :) = mEOutput_batch(dIndices(parami)).Q(ocList);
        else
            error('Unknown method')
        end
        yPTC_median(parami, method) = nanmedian(yPTC(parami, method, :));
        yOC_median(parami, method) = nanmedian(yOC(parami, method, :));
        
        yPTC_stddev(parami, method) = nanstd(squeeze(yPTC(parami, method, :)));
        yOC_stddev(parami, method) = nanstd(squeeze(yOC(parami, method, :)));
    end
end

x = 1:10;
%Normalize
if normalize
    %     disp('Normalizing ...')
    for method = 1:7
        normValPTC = nanmax(nanmax(yPTC(:, method, :)));
        yPTC_norm(:, method, :) = yPTC(:, method, :)/normValPTC;
        
        normValOC = nanmax(nanmax(yOC(:, method, :)));
        yOC_norm(:, method, :) = yOC(:, method, :)/normValOC;
    end
    
    for parami = 1:10
        for method = 1:7
            yPTC_norm_median(parami, method) = nanmedian(squeeze(yPTC_norm(parami, method, :)));
            yOC_norm_median(parami, method) = nanmedian(squeeze(yOC_norm(parami, method, :)));
            
            yPTC_norm_stddev(parami, method) = nanstd(squeeze(yPTC_norm(parami, method, :)));
            yOC_norm_stddev(parami, method) = nanstd(squeeze(yOC_norm(parami, method, :)));
        end
    end
    
    %fig1 = figure(1);
    figure
    %set(fig1,'Position',[300,300,2000,500])
    clf
    for method = 1:7
        if method == 1
            errorbar(yPTC_norm_median(:, method), yPTC_norm_stddev(:, method), 'blue', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 2
            errorbar(yPTC_norm_median(:, method), yPTC_norm_stddev(:, method), 'green', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 3
            errorbar(yPTC_norm_median(:, method), yPTC_norm_stddev(:, method), 'red', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 4
            errorbar(yPTC_norm_median(:, method), yPTC_norm_stddev(:, method), 'cyan', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 5
            errorbar(yPTC_norm_median(:, method), yPTC_norm_stddev(:, method), 'magenta', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 6
            errorbar(yPTC_norm_median(:, method), yPTC_norm_stddev(:, method), 'yellow', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 7
            errorbar(yPTC_norm_median(:, method), yPTC_norm_stddev(:, method), 'black', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        end
    end
    xticks([1 2 3 4 5 6 7 8 9 10])
    xticklabels(labels.xtickscell)
    title(labels.titlePTC)
    xlabel(labels.xtitle)
    ylabel(labels.ytitle)
    legend('Org', 'A', 'B', 'C1', 'C2', 'D', 'E')
    set(gca, 'FontSize', figureDetails.fontSize-2)
    print(strcat('/Users/ananth/Desktop/figs/tcAnalysisPaper/norm_linePlots_Qvs', ...
        labels.xtitle(~isspace(labels.xtitle)), ...
        labels.titlePTC(~isspace(labels.titlePTC))), ...
        '-dpng')
    
    %fig2 = figure(2);
    figure
    %set(fig2,'Position',[300,300,2000,500])
    clf
    for method = 1:7
        if method == 1
            errorbar(yOC_norm_median(:, method), yOC_norm_stddev(:, method), 'blue', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 2
            errorbar(yOC_norm_median(:, method), yOC_norm_stddev(:, method), 'green', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 3
            errorbar(yOC_norm_median(:, method), yOC_norm_stddev(:, method), 'red', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 4
            errorbar(yOC_norm_median(:, method), yOC_norm_stddev(:, method), 'cyan', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 5
            errorbar(yOC_norm_median(:, method), yOC_norm_stddev(:, method), 'magenta', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 6
            errorbar(yOC_norm_median(:, method), yOC_norm_stddev(:, method), 'yellow', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 7
            errorbar(yOC_norm_median(:, method), yOC_norm_stddev(:, method), 'black', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        end
    end
    xticks([1 2 3 4 5 6 7 8 9 10])
    xticklabels(labels.xtickscell)
    title(labels.titleOC)
    xlabel(labels.xtitle)
    ylabel(labels.ytitle)
    legend('Org', 'A', 'B', 'C1', 'C2', 'D', 'E')
    set(gca, 'FontSize', figureDetails.fontSize-2)
    print(strcat('/Users/ananth/Desktop/figs/tcAnalysisPaper/norm_linePlots_Qvs', ...
        labels.xtitle(~isspace(labels.xtitle)), ...
        labels.titleOC(~isspace(labels.titleOC))), ...
        '-dpng')
    
else
    %fig1 = figure(1);
    figure
    %set(fig1,'Position',[300,300,2000,500])
    clf
    for method = 1:7
        if method == 1
            errorbar(yPTC_median(:, method), yPTC_stddev(:, method), 'blue', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 2
            errorbar(yPTC_median(:, method), yPTC_stddev(:, method), 'green', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 3
            errorbar(yPTC_median(:, method), yPTC_stddev(:, method), 'red', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 4
            errorbar(yPTC_median(:, method), yPTC_stddev(:, method), 'cyan', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 5
            errorbar(yPTC_median(:, method), yPTC_stddev(:, method), 'magenta', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 6
            errorbar(yPTC_median(:, method), yPTC_stddev(:, method), 'yellow', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 7
            errorbar(yPTC_median(:, method), yPTC_stddev(:, method), 'black', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        end
    end
    xticks([1 2 3 4 5 6 7 8 9 10])
    xticklabels(labels.xtickscell)
    title(labels.titlePTC)
    xlabel(labels.xtitle)
    ylabel(labels.ytitle)
    legend('Org', 'A', 'B', 'C1', 'C2', 'D', 'E')
    set(gca, 'FontSize', figureDetails.fontSize-2)
    print(strcat('/Users/ananth/Desktop/figs/tcAnalysisPaper/linePlots_Qvs', ...
        labels.xtitle(~isspace(labels.xtitle)), ...
        labels.titlePTC(~isspace(labels.titlePTC))), ...
        '-dpng')
    
    %fig2 = figure(2);
    figure
    %set(fig2,'Position',[300,300,2000,500])
    clf
    for method = 1:7
        if method == 1
            errorbar(yOC_median(:, method), yOC_stddev(:, method), 'blue', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 2
            errorbar(yOC_median(:, method), yOC_stddev(:, method), 'green', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 3
            errorbar(yOC_median(:, method), yOC_stddev(:, method), 'red', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 4
            errorbar(yOC_median(:, method), yOC_stddev(:, method), 'cyan', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 5
            errorbar(yOC_median(:, method), yOC_stddev(:, method), 'magenta', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 6
            errorbar(yOC_median(:, method), yOC_stddev(:, method), 'yellow', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        elseif method == 7
            errorbar(yOC_median(:, method), yOC_stddev(:, method), 'black', 'LineWidth', figureDetails.lineWidth, 'MarkerSize', figureDetails.markerSize);
            hold on
        end
    end
    xticks([1 2 3 4 5 6 7 8 9 10])
    xticklabels(labels.xtickscell)
    title(labels.titleOC)
    xlabel(labels.xtitle)
    ylabel(labels.ytitle)
    legend('Org', 'A', 'B', 'C1', 'C2', 'D', 'E')
    set(gca, 'FontSize', figureDetails.fontSize-2)
    print(strcat('/Users/ananth/Desktop/figs/tcAnalysisPaper/linePlots_Qvs', ...
        labels.xtitle(~isspace(labels.xtitle)), ...
        labels.titleOC(~isspace(labels.titleOC))), ...
        '-dpng')
end
end
