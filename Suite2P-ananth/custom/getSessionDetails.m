function [preDuration, csDuration, traceDuration, usDuration, postDuration] ...
    = getSessionDetails(sessionType, trialDuration)

preDuration        = 8.0000; %in seconds
csDuration         = 0.0500; %in seconds
usDuration         = 0.0500; %in seconds

if sessionType == 1 %250 ms trace
    traceDuration      = 0.2500; %in seconds

elseif sessionType == 2 %350 ms trace
    traceDuration      = 0.3500; %in seconds

elseif sessionType == 3 %500 ms trace
    traceDuration      = 0.5000; %in seconds 

elseif sessionType == 4 %No US, so no trace
    traceDuration      = 0.0000; %in seconds

elseif sessionType == 5 %No US, so no trace
    traceDuration      = 0.0000; %in seconds

else
    warning('Unknown session type')
end

postDuration = trialDuration - (preDuration + csDuration + traceDuration + usDuration); %in seconds