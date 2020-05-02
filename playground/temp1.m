nCells = size(DATA,1);

%Preallocations
MI = nan(nCells,1);
Isec = nan(nCells,1);
Ispk = nan(nCells,1);
Itime = nan(nCells,size(DATA,3),1);
timeCells = nan(nCells, 1);
time = nan(nCells, 1);

%Quality (Q) or Temporal Information
for cell = 1:size(DATA,1)
    [MI(cell), Isec(cell), Ispk(cell), Itime(cell, :)] = tempInfoOneNeuron(squeeze(DATA(cell,:,:)));
end

[X, X0, Y] = createDataMatrix4Bayes(DATA, mBInput);

Mdl = fitcnb(X,Y,'distributionnames','mn');
%Mdl = fitcnb(X,Y);

williamOutput.Yfit = predict(Mdl,X0);

%williamOutput.Isec = Isec;
williamOutput.Q = Ispk;
williamOutput.T = time;
williamOutput.timeCells = timeCells;