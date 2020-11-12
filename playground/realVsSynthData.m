close all

%Load Real Physiology Data
HOME_DIR2 = '/Users/ananth/Desktop/';
saveDirec = strcat(HOME_DIR2, 'Work/Analysis/Imaging/');
saveFolder = strcat(saveDirec, 'M26/20180514/');
realProcessedData = load(strcat(saveFolder, 'M26_20180514.mat'));
realData = realProcessedData.dfbf;

%Load Synthetic Data
gDate = 20201107;
gRun = 1;
nDatasets = 208;
load([saveFolder ...
    'synthDATA_' ...
    num2str(gDate), ...
    '_gRun', num2str(gRun), ...
    '_batch_', ...
    num2str(nDatasets), ...
    '.mat'], 'sdo_batch');

cell = 1;
fig1 = figure(1);
set(fig1,'Position',[300, 300, 1000, 500])
subplot(1, 3, 1)
for i = 1:5
    plot(squeeze(realData(cell, i, :) + ((i-1)*0.5)))
    hold on
end
hold off
title(sprintf('Real Data - First 5 trials with Cell %i', cell))
xlabel('Frames')
ylabel('dF/F')

dataseti = 95;
synthData1 = sdo_batch(dataseti).syntheticDATA;

subplot(1, 3, 2)
for i = 1:5
    plot(squeeze(synthData1(cell, i, :) + ((i-1)*0.5)))
    hold on
end
hold off
title(sprintf('Synth Data (%i) - First 5 trials with Cell %i', dataseti, cell))
xlabel('Frames')
ylabel('dF/F')

dataseti = 99;
synthData2 = sdo_batch(dataseti).syntheticDATA;
subplot(1, 3, 3)
for i = 1:5
    plot(squeeze(synthData2(cell, i, :) + ((i-1)*0.5)))
    hold on
end
hold off
title(sprintf('Synth Data (%i) - First 5 trials with Cell %i', dataseti, cell))
xlabel('Frames')
ylabel('dF/F')
print(strcat(HOME_DIR2, sprintf('realVsSynth_cell%i', cell)), '-dpng')

%% -----
%realData = realProcessedData.dfbf;

cell = 20;
fig2 = figure(2);
set(fig2,'Position',[300, 300, 1000, 500])
subplot(1, 3, 1)
for i = 1:5
    plot(squeeze(realData(cell, i, :) + ((i-1)*0.5)))
    hold on
end
hold off
title(sprintf('Real Data - First 5 trials with Cell %i', cell))
xlabel('Frames')
ylabel('dF/F')

dataseti = 95;
synthData1 = sdo_batch(dataseti).syntheticDATA;

subplot(1, 3, 2)
for i = 1:5
    plot(squeeze(synthData1(cell, i, :) + ((i-1)*0.5)))
    hold on
end
hold off
title(sprintf('Synth Data (%i) - First 5 trials with Cell %i', dataseti, cell))
xlabel('Frames')
ylabel('dF/F')

dataseti = 99;
synthData2 = sdo_batch(dataseti).syntheticDATA;
subplot(1, 3, 3)
for i = 1:5
    plot(squeeze(synthData2(cell, i, :) + ((i-1)*0.5)))
    hold on
end
hold off
title(sprintf('Synth Data (%i) - First 5 trials with Cell %i', dataseti, cell))
xlabel('Frames')
ylabel('dF/F')
print(strcat(HOME_DIR2, sprintf('realVsSynth_cell%i', cell)), '-dpng')

%% -----
%realData = realProcessedData.dfbf;

cell = 72;
fig3 = figure(3);
set(fig3,'Position',[300, 300, 1000, 500])
subplot(1, 3, 1)
for i = 1:5
    plot(squeeze(realData(cell, i, :) + ((i-1)*0.5)))
    hold on
end
hold off
title(sprintf('Real Data - First 5 trials with Cell %i', cell))
xlabel('Frames')
ylabel('dF/F')

dataseti = 95;
synthData1 = sdo_batch(dataseti).syntheticDATA;
figure(3)
subplot(1, 3, 2)
for i = 1:5
    plot(squeeze(synthData1(cell, i, :) + ((i-1)*0.5)))
    hold on
end
hold off
title(sprintf('Synth Data (%i) - First 5 trials with Cell %i', dataseti, cell))
xlabel('Frames')
ylabel('dF/F')

dataseti = 99;
synthData2 = sdo_batch(dataseti).syntheticDATA;
subplot(1, 3, 3)
for i = 1:5
    plot(squeeze(synthData2(cell, i, :) + ((i-1)*0.5)))
    hold on
end
hold off
title(sprintf('Synth Data (%i) - First 5 trials with Cell %i', dataseti, cell))
xlabel('Frames')
ylabel('dF/F')
print(strcat(HOME_DIR2, sprintf('realVsSynth_cell%i', cell)), '-dpng')