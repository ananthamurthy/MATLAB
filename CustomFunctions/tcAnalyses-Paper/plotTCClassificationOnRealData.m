load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_realDataAnalysis_methodA_batch.mat')
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_realDataAnalysis_methodB_batch.mat')
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_realDataAnalysis_methodC_batch.mat')
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_realDataAnalysis_methodD_batch.mat')
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_realDataAnalysis_methodF_batch.mat')

mCOutput_batch.timeCells2(:, 2) = [];

nCells = 135;
nAlgos = 11;

iddTimeCells = zeros(nCells, nAlgos);

figureDetails = compileFigureDetails(20, 2, 5, 0, 'inferno');

for algo = 1:nAlgos
    if algo == 1
        iddTimeCells(:, algo) = squeeze(mAOutput_batch.timeCells);
    elseif algo == 2
        iddTimeCells(:, algo) = squeeze(mBOutput_batch.timeCells);
    elseif algo == 3
        iddTimeCells(:, algo) = squeeze(mCOutput_batch.timeCells1);
    elseif algo == 4
        iddTimeCells(:, algo) = squeeze(mCOutput_batch.timeCells2);
    elseif algo == 5
        iddTimeCells(:, algo) = squeeze(mCOutput_batch.timeCells3);
    elseif algo == 6
        iddTimeCells(:, algo) = squeeze(mCOutput_batch.timeCells4);
    elseif algo == 7
        iddTimeCells(:, algo) = squeeze(mDOutput_batch.timeCells);
    elseif algo == 8
        iddTimeCells(:, algo) = squeeze(mFOutput_batch.timeCells1);
    elseif algo == 9
        iddTimeCells(:, algo) = squeeze(mFOutput_batch.timeCells2);
    elseif algo == 10
        iddTimeCells(:, algo) = squeeze(mFOutput_batch.timeCells3);
    elseif algo == 11
        iddTimeCells(:, algo) = squeeze(mFOutput_batch.timeCells4);
    end
end

fig1 = figure(1);
set(fig1,'Position',[100, 100, 1600, 800])
subplot(4, 1, 1:2)
imagesc(iddTimeCells)
colormap(figureDetails.colorMap)
%caxis([0 1.1])
title('Time Cell Classification')
xlabel('Algorithms', 'FontWeight', 'bold')
ylabel('All Cells', 'FontWeight', 'bold')
xticks(1:11)
xticklabels({'Ar', 'Br', 'C1r', 'C2r', 'C1o', 'C2o', 'Do', 'F1r', 'F2r', 'F1o', 'F2o'})
z = colorbar;
colorbar('Ticks',[0, 1],...
    'TickLabels',{'No','Yes'})
set(gca, 'FontSize', 20)

percentHits = sum(iddTimeCells, 1)*100/nCells;
subplot(4, 1, 3)
%plot(percentHits, 'bo', 'MarkerSize', 10)
bar(percentHits, 'r')
xlabel('Algorithms', 'FontWeight', 'bold')
ylabel('Hits (%)', 'FontWeight', 'bold')
xticklabels({'Ar', 'Br', 'C1r', 'C2r', 'C1o', 'C2o', 'Do', 'F1r', 'F2r', 'F1o', 'F2o'})
set(gca, 'FontSize', 20)

%in comparison to F2r
compN = sum(iddTimeCells(:, 9));
percentOverlap(1) = dot(iddTimeCells(:, 1), iddTimeCells(:, 9))*100/compN;
percentOverlap(2) = dot(iddTimeCells(:, 2), iddTimeCells(:, 9))*100/compN;
percentOverlap(3) = dot(iddTimeCells(:, 3), iddTimeCells(:, 9))*100/compN;
percentOverlap(4) = dot(iddTimeCells(:, 4), iddTimeCells(:, 9))*100/compN;
percentOverlap(5) = dot(iddTimeCells(:, 5), iddTimeCells(:, 9))*100/compN;
percentOverlap(6) = dot(iddTimeCells(:, 6), iddTimeCells(:, 9))*100/compN;
percentOverlap(7) = dot(iddTimeCells(:, 7), iddTimeCells(:, 9))*100/compN;
percentOverlap(8) = dot(iddTimeCells(:, 8), iddTimeCells(:, 9))*100/compN;
percentOverlap(9) = dot(iddTimeCells(:, 9), iddTimeCells(:, 9))*100/compN;
percentOverlap(10) = dot(iddTimeCells(:, 10), iddTimeCells(:, 9))*100/compN;
percentOverlap(11) = dot(iddTimeCells(:, 11), iddTimeCells(:, 9))*100/compN;
subplot(4, 1, 4)
bar(percentOverlap, 'r')
xlabel('Algorithms', 'FontWeight', 'bold')
ylabel('Overlap (%)', 'FontWeight', 'bold')
xticklabels({'Ar', 'Br', 'C1r', 'C2r', 'C1o', 'C2o', 'Do', 'F1r', 'F2r', 'F1o', 'F2o'})
set(gca, 'FontSize', 20)