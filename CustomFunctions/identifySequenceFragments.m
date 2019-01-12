% AUTHOR - Kambadur Ananthmurthy
% Identify trials with time cell sequence fragments, if any
% Best to use the significant-only traces of identified time locked cells
% Data = dfbf_sigOnly(find(timeLockedCells),:,:)

function [importantFrames] = identifySequenceFragments(Data, skipFrames)
%Preallocation
importantFrames = zeros(size(Data));
for cell = 1:size(Data,1)
    for trial = 1:size(Data,2)
        for frame = 1:size(Data,3)
            if frame == skipFrames
                %skip
            elseif Data(cell, trial, frame) > 0 %NOTE: the data should be significant-only
                importantFrames(cell, trial, frame) = 1;
            else
            end
        end
    end
end
end