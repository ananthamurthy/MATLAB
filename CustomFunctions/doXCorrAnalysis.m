function [rVector, lagVector] = doXCorrAnalysis(DATA)

nCells = size(DATA, 1);
nTrials = size(DATA, 2);
%nFrames = size(DATA, 3);

rMatrix = nan(nCells, nTrials, nTrials);
lagMatrix = nan(nCells, nTrials, nTrials);

for cell = 1:nCells
    for tx = 1:nTrials
        for ty = (tx+1):nTrials
            x = squeeze(DATA(cell, tx, :));
            y = squeeze(DATA(cell, ty, :));
            [r, lag] = xcorr(x, y, 'coeff');
            [val, ind] = max(r);
            rMatrix(cell, tx, ty) = val;
            lagMatrix(cell, tx, ty) = lag(ind);
        end
    end
end

rVector = reshape(rMatrix, [], 1);
lagVector = reshape(lagMatrix, [], 1);

end