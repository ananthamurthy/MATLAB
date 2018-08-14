%Maybe this is silly, but I've decided to write out two separate functions
%to identify time cells (isTimeLockedCell.m), and
%to populate a list of the same (getTimeLockedCellList.m).
function [timeLockedCells, reliability] = getTimeLockedCellList(Data, nShuffles, identificationPrinciple, comparisonPrinciple, threshold, window, skipFrames)

disp(['Total cells: ' num2str(size(Data,1))])
timeLockedCells = []; %preallocation
reliability = []; %preallocation

disp('Now, checking for time-locked cells ...')
fprintf('Identification Principle: %s; Comparison Principle: %s', ...
    identificationPrinciple, comparisonPrinciple)
fprintf('Threshold: %s',num2str(threshold))

if exist ('skipFrames', 'var')
    %NOTE: Data has 3 dimensions - Cells, Trials and Frames
    if skipFrames ~= 0
        Data(:,:,skipFrames) = [];
        %local modification:
        window(end) = [];
    end
end

for cell = 1:size(Data,1)
    if strcmp(identificationPrinciple, 'CaPSTH')
        %Develop Ca PSTH using threshold
        
        %Estimate reliability based on comparison principle
        
    elseif strcmp(identificationPrinciple,'AOC') || strcmp(identificationPrinciple, 'Peak')
        result = isTimeLockedCell(squeeze(Data(cell, :, :)), nShuffles, identificationPrinciple, comparisonPrinciple, threshold, window);
        %disp(['comparison: ' num2str(comparison)])
        if result
            timeLockedCells = [timeLockedCells cell];
        end
    else
        error('Unknown Identification Principle')
    end
    
    if (mod(cell, 10) == 0) && cell ~= size(Data,1)
        disp(['... ' num2str(cell) ' cells checked ...'])
    end
end
disp([num2str(length(timeLockedCells)) ' time-locked cells found!'])
disp('... done!')

