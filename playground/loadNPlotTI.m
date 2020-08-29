load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/synthDATA_20200822_gRun2_batch_10.mat')

nDatasets = 10;
nCells = 135;

Q = zeros(nDatasets, nCells);
Q_med = zeros(nDatasets, 1);
Q_std = zeros(nDatasets, 1);

for runi = 1:10
    DATA = sdo_batch(runi).syntheticDATA;
    
    for cell = 1: 135
        [MI(cell), Isec(cell), Ispk(cell), Itime(cell, :)] = tempInfoOneNeuron(squeeze(DATA(cell,:,:)));
    end
    
    Q(runi, :) = Ispk;
    Q_med(runi) = nanmedian(Ispk);
    Q_std(runi) = nanstd(Ispk);
end

errorbar(Q_med, Q_std)
title('QB vs Fixed HTR - 50% Noise')
xlabel('Dataset No.')
ylabel('Temporal Information (bits/spike)')