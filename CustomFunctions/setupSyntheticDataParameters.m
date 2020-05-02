%NOTE: String arguments may be provided in uppercase, partial capitalization, or lowercase

%{
JUST FOR REFERENCE
% Synthetic Data Parameters
timeCellPercent = 50; %in %
cellOrder = 'basic'; %basic or random
maxHitTrialPercent = 100; %in %
hitTrialPercentAssignment = 'random'; %fixed or random (maxHitTrialPercent/2 to maxHitTrialPercent)
trialOrder = 'random'; %basic or random
eventWidth = {50, 'stddev'}; %{location, width}; e.g. - {percentile, stddev}
eventAmplificationFactor = 10;
eventTiming = 'sequential'; %sequential or random
startFrame = 116; %Try to leave a good set of frames (depending on sampling rate) as buffer
endFrame = 123; %Try to leave a good set of frames (depending on sampling rate) as buffer
imprecisionFWHM = 8; %Will be divided by 2 for positive and negative "width" around the centre
imprecisionType = 'uniform'; %Uniform, Normal, or None
noise = 'gaussian'; %Gaussian (as noisePercent) or None (renders noisePercent irrelevant)
noisePercent = 20; %How much percent of noise to add
comment = 'anything you like'

Random Seed
rng('seed', 'generator')  %See help rng for details; Typically: 'default' or 'shuffle'
%}
%%
i = 0;
%% Synthetic Data Parameters
i = i + 1;
sdcp(i).timeCellPercent = 100; %in %
sdcp(i).cellOrder = 'basic'; %basic or random (not useful if)
sdcp(i).maxHitTrialPercent = 100; %in %
sdcp(i).hitTrialPercentAssignment = 'fixed'; %fixed or random (maxHitTrialPercent/2 to maxHitTrialPercent)
sdcp(i).trialOrder = 'random'; %basic or random
sdcp(i).eventWidth = {100, 'same'}; %{location, width}; e.g. - {percentile, stddev}
sdcp(i).eventAmplificationFactor = 1;
sdcp(i).eventTiming = 'sequential'; %sequential or random
sdcp(i).startFrame = 50;
sdcp(i).endFrame = 200;
sdcp(i).imprecisionFWHM = 8; %Will be divided by 2 for positive and negative "width" around the centre
sdcp(i).imprecisionType = 'uniform'; %Uniform, Normal, or None
sdcp(i).noise = 'gaussian'; %Gaussian (as noisePercent) or None (renders noisePercent irrelevant)
sdcp(i).noisePercent = 25; %How much percent of noise to add
sdcp(i).randomseed = 'default';
sdcp(i).comment = '';
rng(sdcp(i).randomseed) %Typically: 'default' or 'shuffle'