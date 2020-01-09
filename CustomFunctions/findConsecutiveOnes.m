function [Events, StartIndices, Lengths] = findConsecutiveOnes(binaryData)
Events = 0;
StartIndices = [];
Lengths = [];
count = 0;
for frame = 1:length(binaryData) %use 1D data; say all trials for a particular cell
    if binaryData(frame) == 1
        count = count + 1;
    elseif (binaryData(frame) == 0)
        if frame ~= 1 && (binaryData(frame-1) == 1) %This algorithm should avoid considering a 1 in frame 1 as an independent event
            Events = Events + 1;
            %fprintf('Events = %i\n', Events)
            Lengths = [Lengths count];
            StartIndices = [StartIndices (frame - count)];
            count = 0;
        end
    else
        warning('Non binary data detection')
    end
end