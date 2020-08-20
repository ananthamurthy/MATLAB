%{
Plot various parameter sensitivity analyses across methods.
Input arguments:
dIndices
normalize
labels
%}

function plotParamSensitivity(dIndices, normalize, labels, figureDetails, sdo_batch, cData, mEOutput_batch)

% close all

% % Generated Synthetic Data
% load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/synthDATA_batch_220.mat')
% 
% % Analysed Data
% load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200615_cRun4_cData.mat')
% load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_synthDataAnalysis_20200729_gRun2_methodE_batch_1-220.mat')

ptcList = sdo_batch(dIndices(1)).ptcList;
ocList = sdo_batch(dIndices(1)).ocList;

for xi = 1:10
    for method = 1:7
        if method == 1 %orginal method
            yPTC(xi, method, :) = sdo_batch(dIndices(xi)).Q(ptcList);
            yOC(xi, method, :) = sdo_batch(dIndices(xi)).Q(ocList);
        elseif method == 2 %method A
            yPTC(xi, method, :) = cData.methodA.mAOutput_batch(dIndices(xi)).Q(ptcList);
            yOC(xi, method, :) = cData.methodA.mAOutput_batch(dIndices(xi)).Q(ocList);
        elseif method == 3 %method B
            yPTC(xi, method, :) = cData.methodB.holyData.mBOutput_batch(dIndices(xi)).Q(ptcList);
            yOC(xi, method, :) = cData.methodB.holyData.mBOutput_batch(dIndices(xi)).Q(ocList);
        elseif method == 4 %method C1
            yPTC(xi, method, :) = cData.methodC.mCOutput_batch(dIndices(xi)).Q1(ptcList);
            yOC(xi, method, :) = cData.methodC.mCOutput_batch(dIndices(xi)).Q1(ocList);
        elseif method == 5 %method C2
            yPTC(xi, method, :) = cData.methodC.mCOutput_batch(dIndices(xi)).Q2(ptcList);
            yOC(xi, method, :) = cData.methodC.mCOutput_batch(dIndices(xi)).Q2(ocList);
        elseif method == 6 %method D
            yPTC(xi, method, :) = cData.methodD.mDOutput_batch(dIndices(xi)).Q(ptcList);
            yOC(xi, method, :) = cData.methodD.mDOutput_batch(dIndices(xi)).Q(ocList);
        elseif method == 7 %method E
            yPTC(xi, method, :) = mEOutput_batch(dIndices(xi)).Q(ptcList);
            yOC(xi, method, :) = mEOutput_batch(dIndices(xi)).Q(ocList);
        else
            error('Unknown method')
        end
    end
end

%Normalize
if normalize
%     disp('Normalizing ...')
    for method = 1:7
        normValPTC = max(max(yPTC(:, method, :)));
        yPTC_norm(:, method, :) = yPTC(:, method, :)/normValPTC;
        normValOC = max(max(yOC(:, method, :)));
        yOC_norm(:, method, :) = yOC(:, method, :)/normValOC;
    end
    x = 1:10;
    fig1 = figure(1);
    set(fig1,'Position',[300,300,2000,500])
    clf
    h = boxplot2(yPTC_norm, x); %'Labels', {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'}
    % Alter linestyle and color
    cmap = get(0, 'defaultaxescolororder');
    for var = 1:7
        structfun(@(x) set(x(var,:), 'color', cmap(var,:), ...
            'markeredgecolor', cmap(var,:)), h);
    end
    set([h.lwhis h.uwhis], 'linestyle', '-');
    set(h.out, 'marker', '.');
    xticks([1 2 3 4 5 6 7 8 9 10])
    xticklabels(labels.xtickscell)
    title(labels.titlePTC)
    xlabel(labels.xtitle)
    ylabel(labels.ytitle)
    legend('Org', 'A', 'B', 'C1', 'C2', 'D', 'E')
    set(gca, 'FontSize', figureDetails.fontSize-2)
    print(strcat('/Users/ananth/Desktop/figs/tcAnalysisPaper/Qvs', ...
        labels.xtitle(~isspace(labels.xtitle)), ...
        labels.titlePTC(~isspace(labels.titlePTC))), ...
        '-dpng')
    
    
    fig2 = figure(2);
    set(fig2,'Position',[300,300,2000,500])
    clf
    h = boxplot2(yOC_norm, x); %'Labels', {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'}
    % Alter linestyle and color
    cmap = get(0, 'defaultaxescolororder');
    for var = 1:7
        structfun(@(x) set(x(var,:), 'color', cmap(var,:), ...
            'markeredgecolor', cmap(var,:)), h);
    end
    set([h.lwhis h.uwhis], 'linestyle', '-');
    set(h.out, 'marker', '.');
    xticks([1 2 3 4 5 6 7 8 9 10])
    xticklabels(labels.xtickscell)
    title(labels.titleOC)
    xlabel(labels.xtitle)
    ylabel(labels.ytitle)
    legend('Org', 'A', 'B', 'C1', 'C2', 'D', 'E')
    set(gca, 'FontSize', figureDetails.fontSize-2)
    print(strcat('/Users/ananth/Desktop/figs/tcAnalysisPaper/Qvs', ...
        labels.xtitle(~isspace(labels.xtitle)), ...
        labels.titleOC(~isspace(labels.titleOC))), ...
        '-dpng')
else
    x = 1:10;
    fig1 = figure(1);
    set(fig1,'Position',[300,300,2000,500])
    clf
    h = boxplot2(yPTC, x); %'Labels', {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'}
    
    % Alter linestyle and color
    cmap = get(0, 'defaultaxescolororder');
    for var = 1:7
        structfun(@(x) set(x(var,:), 'color', cmap(var,:), ...
            'markeredgecolor', cmap(var,:)), h);
    end
    set([h.lwhis h.uwhis], 'linestyle', '-');
    set(h.out, 'marker', '.');
    xticks([1 2 3 4 5 6 7 8 9 10])
    xticklabels(labels.xtickscell)
    title(labels.titlePTC)
    xlabel(labels.xtitle)
    ylabel(labels.ytitle)
    legend('Org', 'A', 'B', 'C1', 'C2', 'D', 'E')
    set(gca, 'FontSize', figureDetails.fontSize-2)
    print(strcat('/Users/ananth/Desktop/figs/tcAnalysisPaper/Qvs', ...
        labels.xtitle(~isspace(labels.xtitle)), ...
        labels.titlePTC(~isspace(labels.titlePTC))), ...
        '-dpng')
    
    fig2 = figure(2);
    set(fig2,'Position',[300,300,2000,500])
    clf
    h = boxplot2(yOC, x); %'Labels', {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'}
    
    % Alter linestyle and color
    cmap = get(0, 'defaultaxescolororder');
    for var = 1:7
        structfun(@(x) set(x(var,:), 'color', cmap(var,:), ...
            'markeredgecolor', cmap(var,:)), h);
    end
    set([h.lwhis h.uwhis], 'linestyle', '-');
    set(h.out, 'marker', '.');
    xticklabels(labels.xtickscell)
    title(labels.titleOC)
    xlabel(labels.xtitle)
    ylabel(labels.ytitle)
    legend('Org', 'A', 'B', 'C1', 'C2', 'D', 'E')
    set(gca, 'FontSize', figureDetails.fontSize-2)
    print(strcat('/Users/ananth/Desktop/figs/tcAnalysisPaper/Qvs', ...
        labels.xtitle(~isspace(labels.xtitle)), ...
        labels.titleOC(~isspace(labels.titleOC))), ...
        '-dpng')
end

end