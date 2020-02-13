%NOTE: String arguments may be provided in uppercase, partial capitalization, or lowercase
%{
JUST FOR REFERENCE
timeCellPercent = 50; %in %
cellOrder = 'Basic'; %Basic or Random
maxHitTrialPercent = 100; %as a fraction
hitTrialAssignment = 'fixed'; %random or fixed
trialOrder = 'Basic'; %basic or random
eventWidth = {50, 'stddev'}; % {location, width}; e.g. - {percentile, stddev}; string array
eventAmplificationFactor = 1;
eventTiming = 'Sequence'; %sequence or random
startFrame = 20;
endFrame = db(1).nFrames;
imprecisionFWHM = 8; %Will be divided by 2 for positive and negative "width" around the centre
imprecisionType = 'None'; %Uniform, Normal, or None
noise = 'Gaussian'; %Gaussian (as noisePercent) or None (renders noisePercent irrelevant)
noisePercent = 20; %How much percent of noise to add
%}

%% Synthetic Data Parameters
timeCellPercent = 50; %in %
cellOrder = 'Basic'; %Basic or Random
maxHitTrialPercent = 100; %as a fraction
hitTrialAssignment = 'random'; %random or fixed
trialOrder = 'Basic'; %basic or random
eventWidth = {100, 'stddev'}; % {location, width}; e.g. - {percentile, stddev}; string array
eventAmplificationFactor = 1;
eventTiming = 'Sequential'; %sequential or random
startFrame = 116;
endFrame = 123;
imprecisionFWHM = 8; %Will be divided by 2 for positive and negative "width" around the centre
imprecisionType = 'Uniform'; %Uniform, Normal, or None
noise = 'Gaussian'; %Gaussian (as noisePercent) or None (renders noisePercent irrelevant)
noisePercent = 20; %How much percent of noise to add