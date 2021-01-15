function randDATA = generateRandData(DATA)
    nCells = size(DATA, 1);
    nTrials = size(DATA, 2);
    nFrames = size(DATA, 3);
    
    randDATA = nan(size(DATA));
    for cell = 1:nCells
        for trial = 1:nTrials
            shift = randi(nFrames);
            randDATA(cell, trial, 1:shift) = DATA(cell, trial, end - shift);
            randDATA(cell, trial, (shift + 1) : end) = DATA(cell, trial, 1:shift);
        end
    end
end