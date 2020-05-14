nCells = size(DATA, 1);
nTrials = size(DATA, 2);
nFrames = size(DATA, 3);

allTrials = 1:nTrials;

rTC = nan(nCells, nTrials, nTrials);
lagTC = nan(nCells, nTrials, nTrials);

rOC = nan(nCells, nTrials, nTrials);
lagOC = nan(nCells, nTrials, nTrials);

%Loop for time cells
for celli = 1:length(sdo.ptcList)
    for tx = 1:nTrials
        options = find(allTrials~=tx);
        for ty = 1:length(options)
            x = squeeze(DATA(sdo.ptcList(celli), tx, :));
            y = squeeze(DATA(sdo.ptcList(celli), options(ty), :));
            [r, lags] = xcorr(x, y);
            [val, ind] = max(r);
            rTC(celli, tx, ty) = val;
            lagTC(celli, tx, options(ty)) = lags(ind);
        end
    end
end

%Loop for other cells
for celli = 1:length(sdo.ocList)
    for tx = 1:nTrials
        options = find(allTrials~=tx);
        for ty = 1:length(options)
            x = squeeze(DATA(sdo.ocList(celli), tx, :));
            y = squeeze(DATA(sdo.ocList(celli), options(ty), :));
            [r, lags] = xcorr(x, y);
            [val, ind] = max(r);
            rOC(celli, tx, ty) = val;
            lagOC(celli, tx, options(ty)) = lags(ind);
        end
    end
end
vec_rTC = reshape(rTC, [], 1);
vec_lagTC = reshape(lagTC, [], 1);

vec_rOC = reshape(rOC, [], 1);
vec_lagOC = reshape(lagOC, [], 1);

figure(1)
subplot(1, 2, 1)
scatter(vec_rTC, vec_lagTC, 'r')
title('Time Cells')
xlabel('Cross-correlation')
ylabel('Lags (frames)')

subplot(1, 2, 2)
scatter(vec_rOC, vec_lagOC, 'k')
title('Other Cells')
xlabel('Cross-correlation')
ylabel('Lags (frames)')