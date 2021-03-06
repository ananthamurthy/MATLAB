% Additional Plots for scatter based comparison

close all

% Mehrab Time vs Actual Time
fig1 = figure(1);
scatter(mAOutput.T/db.samplingRate, (sdo.T * mCInput.delta)/db.samplingRate, 'k');
xlim([0 (db.nFrames/db.samplingRate)])
ylim([0 (db.nFrames/db.samplingRate)])
title('Method A vs Method C', ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
xlabel('T - Method A (s)', ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
ylabel('Derived Time (s)', ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize', figureDetails.fontSize-3)
print('/Users/ananth/Desktop/Reports/TAvsTC_', ...
    '-dpng')

fig2 = figure(2);
scatter(mBOutput.Q_norm, mAOutput.Q_norm, 'k');
xlim([0 (db.nFrames/db.samplingRate)])
ylim([0 (db.nFrames/db.samplingRate)])
title('Method A vs Method B', ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
xlabel('Q - Method B', ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
ylabel('Q - Method A', ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize', figureDetails.fontSize-3)
print('/Users/ananth/Desktop/Reports/QAvsQB_', ...
    '-dpng')

fig3 = figure(3);
scatter(mCOutput.Q1_norm, mAOutput.Q_norm, 'k');
xlim([0 (db.nFrames/db.samplingRate)])
ylim([0 (db.nFrames/db.samplingRate)])
title('Method A vs Method C', ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
xlabel('Q - Method C', ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
ylabel('Q - Method A', ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize', figureDetails.fontSize-3)
print('/Users/ananth/Desktop/Reports/QAvsQC_', ...
    '-dpng')

fig4 = figure(4);
scatter(mCOutput.Q1_norm, mBOutput.Q_norm, 'k');
xlim([0 (db.nFrames/db.samplingRate)])
ylim([0 (db.nFrames/db.samplingRate)])
title('Method B vs Method C', ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
xlabel('Q - Method B', ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
ylabel('Q - Method C', ...
    'FontSize', figureDetails.fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize', figureDetails.fontSize-3)
print('/Users/ananth/Desktop/Reports/QBvsQC_', ...
    '-dpng')

