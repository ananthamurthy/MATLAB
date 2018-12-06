function trialDetails = getTrialDetails(dataset)

disp('Getting session details ...')
trialDetails.nFrames = dataset.nFrames;

trialDetails.frameRate          = round((dataset.nFrames/dataset.trialDuration),1);
trialDetails.preDuration        = 8.0000; %in seconds
trialDetails.csDuration         = 0.0500; %in seconds
trialDetails.usDuration         = 0.0500; %in seconds

if dataset.sessionType == 1 %No stimulus
    trialDetails.traceDuration      = 0.2500; %in seconds

elseif dataset.sessionType == 2 %No Puff
    trialDetails.traceDuration      = 0.2500; %in seconds

elseif dataset.sessionType == 3 %250 ms trace
    trialDetails.traceDuration      = 0.2500; %in seconds

elseif dataset.sessionType == 4 %350 ms trace
    trialDetails.traceDuration      = 0.3500; %in seconds

elseif dataset.sessionType == 5 %450 ms trace
    trialDetails.traceDuration      = 0.4500; %in seconds 

elseif dataset.sessionType == 6 %550 ms trace
    trialDetails.traceDuration      = 0.0000; %in seconds

elseif dataset.sessionType == 7 %650 ms trace
    trialDetails.traceDuration      = 0.0000; %in seconds
else
    warning('Unknown session type')
end

trialDetails.postDuration = dataset.trialDuration - ...
    (trialDetails.preDuration + ...
    trialDetails.csDuration + ...
    trialDetails.traceDuration + ...
    trialDetails.usDuration); %in seconds

disp('... done!')