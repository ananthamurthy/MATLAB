%Written by Kambadur Ananthamurthy
function [frameIndex, pad] = selectFrameIndex(eventTiming, startFrame, endFrame, I, imprecision, imprecisionType, cell)
%What timing/frame to select?
if strcmp(eventTiming, 'sequence')
    %Perfect sequence
    frameIndex = (startFrame + cell - 1) - I; %Uses the event peak instead of the event start index
    %fprintf('frameIndex: %i\n', frameIndex)
    
elseif strcmp(eventTiming, 'random')
    %randomized
    frameIndex = floor(rand()*(endFrame - startFrame)) + startFrame - I; %Uses the event peak instead of the event start index
    %fprintf('frameIndex: %i\n', frameIndex)
end

%Add the effect of "imprecision"
if strcmp(imprecisionType, 'uniform')
    pad = floor(rand()*imprecision(1) + floor(rand()*imprecision(2)));
elseif strcmp(imprecisionType, 'gaussian')
    %pad = floor(rand()*imprecision(1) + floor(rand()*imprecision(2)));
else
    pad = 0;
end

end