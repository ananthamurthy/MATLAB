%Written by Kambadur Ananthamurthy
function [frameIndex, pad] = selectFrameIndex(eventTiming, startFrame, endFrame, I, imprecisionFWHM, imprecisionType, frameGroup)
%What timing/frame to select?
if strcmpi(eventTiming, 'sequential')
    %Perfect sequence
    frameIndex = startFrame + (frameGroup - 1) - I;
    %fprintf('frameIndex: %i\n', frameIndex)
elseif strcmpi(eventTiming, 'random')
    %randomized
    frameIndex = floor(rand()*(endFrame - startFrame)) + startFrame - I; %Uses the event peak instead of the event start index
    %fprintf('frameIndex: %i\n', frameIndex)
end

%Add the effect of "imprecision"
if strcmpi(imprecisionType, 'uniform')
    pad = randi([-1*(imprecisionFWHM/2), (imprecisionFWHM/2)]);
elseif strcmpi(imprecisionType, 'normal')
    stddev = imprecisionFWHM/(2*sqrt(2*log(2))); %NOTE: In MATLAB, log() performs a natural log
    pad = round(normrnd(0, stddev)); %Setting mean = 0
elseif strcmpi(imprecisionType, 'none')
    pad = 0; %No imprecision
end
%NOTE: The selected frame will be established by (frameIndex + pad),
%outside of this code

end