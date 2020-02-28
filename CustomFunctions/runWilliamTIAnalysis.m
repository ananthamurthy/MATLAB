function [williamOutput] = runWilliamTIAnalysis(DATA)
nCells = size(DATA,1);
%Preallocations
MI = zeros(nCells,1);
Isec = zeros(nCells,1);
Ispk = zeros(nCells,1);
Itime = zeros(nCells,size(DATA,3),1);
timeCells = zeros(nCells, 1);
time = zeros(nCells, 1);

for cell = 1:size(DATA,1)
    [MI(cell), Isec(cell), Ispk(cell), Itime(cell, :)] = tempInfoOneNeuron(squeeze(DATA(cell,:,:)));
end

williamOutput.Isec = Isec;
williamOutput.Q = Ispk;
williamOutput.T = time;
williamOutput.timeCells = timeCells;
end