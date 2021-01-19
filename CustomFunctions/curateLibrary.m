function eventLibrary_2D = curateLibrary(db, saveFolder, DATA_2D)
%Check to see if the library exits
if isfile(strcat(saveFolder, db.mouseName, '_', db.date, '_eventLibrary_2D.mat'))
    disp('Loading existing event library ...')
    filepath = strcat(saveFolder, db.mouseName, '_', db.date, '_eventLibrary_2D.mat');
    eventLibrary_2D = load(filepath);
    disp('... done!')
else
    %Preallocation
    
    nCells = size(DATA_2D, 1);
    %nTrials = size(DATA, 2);
    %nFrames = size(DATA, 3);
    
    %Use real 2D data
    cellMean = zeros(nCells, 1);
    cellStddev = zeros(nCells, 1);
    binaryData = zeros(nCells, 1);
    
    %disp('Basic scan for calcium events ...')
    
    %Preallocation
    s.nEvents = 0;
    s.eventStartIndices = [];
    s.eventWidths = [];
    eventLibrary_2D = repmat(s, 1, nCells);
    clear s
    
    for cell = 1:nCells
        sampledCellActivity = squeeze(DATA_2D(cell, :));
        cellMean(cell) = mean(sampledCellActivity);
        cellStddev(cell) = std(sampledCellActivity);
        logicalIndices = sampledCellActivity > (cellMean(cell) + 2* cellStddev(cell));
        binaryData(logicalIndices, 1) = 1;
        minNumberOf1s = 3;
        [nEvents, StartIndices, Width] = findConsecutiveOnes(binaryData, minNumberOf1s);
        eventLibrary_2D(cell).nEvents = nEvents;
        eventLibrary_2D(cell).eventStartIndices = StartIndices;
        eventLibrary_2D(cell).eventWidths = Width;
        
        clear binaryData
        clear Events
        clear StartIndices
        clear Lengths
    end
    save(strcat(saveFolder, db.mouseName, '_', db.date, '_eventLibrary_2D.mat'), 'eventLibrary_2D')
    %disp('... library curated and saved!')
end
end