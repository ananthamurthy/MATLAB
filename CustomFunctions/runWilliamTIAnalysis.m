function [williamOutput] = runWilliamTIAnalysis(DATA)
nCells = size(DATA,1);
%Preallocations
MI = nan(nCells,1);
Isec = nan(nCells,1);
Ispk = nan(nCells,1);
Itime = nan(nCells,size(DATA,3),1);
timeCells = nan(nCells, 1);
time = nan(nCells, 1);

for cell = 1:size(DATA,1)
    [MI(cell), Isec(cell), Ispk(cell), Itime(cell, :)] = tempInfoOneNeuron(squeeze(DATA(cell,:,:)));
end

%williamOutput.Isec = Isec;
williamOutput.Q = Ispk;
williamOutput.T = time;
williamOutput.timeCells = timeCells;
end