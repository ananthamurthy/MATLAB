%NOTE: String arguments may be provided in uppercase, partial capitalization, or lowercase

%{
JUST FOR REFERENCE
% Synthetic Data Parameters
timeCellPercent = 50; %in %
cellOrder = 'basic'; %basic or random
maxHitTrialPercent = 100; %in %
hitTrialPercentAssignment = 'random'; %fixed or random
trialOrder = 'random'; %basic or random
eventWidth = {50, 'stddev'}; %{location, width}; e.g. - {percentile, stddev}
eventAmplificationFactor = 10;
eventTiming = 'sequential'; %sequential or random
startFrame = 116;
endFrame = 123;
imprecisionFWHM = 8; %Will be divided by 2 for positive and negative "width" around the centre
imprecisionType = 'uniform'; %Uniform, Normal, or None
noise = 'gaussian'; %Gaussian (as noisePercent) or None (renders noisePercent irrelevant)
noisePercent = 20; %How much percent of noise to add
%}

%% Synthetic Data Parameters
sdcp.timeCellPercent = 50; %in %
sdcp.cellOrder = 'basic'; %basic or random
sdcp.maxHitTrialPercent = 100; %in %
sdcp.hitTrialPercentAssignment = 'fixed'; %fixed or random
sdcp.trialOrder = 'basic'; %basic or random
sdcp.eventWidth = {100, 'same'}; %{location, width}; e.g. - {percentile, stddev}
sdcp.eventAmplificationFactor = 1;
sdcp.eventTiming = 'sequential'; %sequential or random
sdcp.startFrame = 116;
sdcp.endFrame = 123;
sdcp.imprecisionFWHM = 8; %Will be divided by 2 for positive and negative "width" around the centre
sdcp.imprecisionType = 'none'; %Uniform, Normal, or None
sdcp.noise = 'gaussian'; %Gaussian (as noisePercent) or None (renders noisePercent irrelevant)
sdcp.noisePercent = 25; %How much percent of noise to add