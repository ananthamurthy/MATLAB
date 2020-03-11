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
%% Synthetic Data Parameters - Batch

%i = 1
i = i + 1;
sdcp(i).timeCellPercent = 50;
sdcp(i).cellOrder = 'basic';
sdcp(i).maxHitTrialPercent = 100;
sdcp(i).hitTrialPercentAssignment = 'fixed';
sdcp(i).trialOrder = 'basic';
sdcp(i).eventWidth = {100, 'same'};
sdcp(i).eventAmplificationFactor = 1;
sdcp(i).eventTiming = 'sequential';
sdcp(i).startFrame = 100;
sdcp(i).endFrame = 200;
sdcp(i).imprecisionFWHM = 8;
sdcp(i).imprecisionType = 'none';
sdcp(i).noise = 'gaussian';
sdcp(i).noisePercent = 0;
sdcp(i).randomseed = 'default';
sdcp(i).comment = '0% gaussian noise';
rng(sdcp(i).randomseed)

%i = 2
i = i + 1;
sdcp(i).timeCellPercent = 50;
sdcp(i).cellOrder = 'basic';
sdcp(i).maxHitTrialPercent = 100;
sdcp(i).hitTrialPercentAssignment = 'fixed';
sdcp(i).trialOrder = 'basic';
sdcp(i).eventWidth = {100, 'same'};
sdcp(i).eventAmplificationFactor = 1;
sdcp(i).eventTiming = 'sequential';
sdcp(i).startFrame = 100;
sdcp(i).endFrame = 200;
sdcp(i).imprecisionFWHM = 8;
sdcp(i).imprecisionType = 'none';
sdcp(i).noise = 'gaussian';
sdcp(i).noisePercent = 25;
sdcp(i).randomseed = 'default';
sdcp(i).comment = '25% gaussian noise';
rng(sdcp(i).randomseed)
% 
% %i = 3
% i = i + 1;
% sdcp(i).timeCellPercent = 50;
% sdcp(i).cellOrder = 'basic';
% sdcp(i).maxHitTrialPercent = 100;
% sdcp(i).hitTrialPercentAssignment = 'fixed';
% sdcp(i).trialOrder = 'basic';
% sdcp(i).eventWidth = {100, 'same'};
% sdcp(i).eventAmplificationFactor = 1;
% sdcp(i).eventTiming = 'sequential';
% sdcp(i).startFrame = 100;
% sdcp(i).endFrame = 200;
% sdcp(i).imprecisionFWHM = 8;
% sdcp(i).imprecisionType = 'none';
% sdcp(i).noise = 'gaussian';
% sdcp(i).noisePercent = 50;
% sdcp(i).randomseed = 'default';
% sdcp(i).comment = '50% gaussian noise';
% rng(sdcp(i).randomseed)
% 
% %i = 4
% i = i + 1;
% sdcp(i).timeCellPercent = 50;
% sdcp(i).cellOrder = 'basic';
% sdcp(i).maxHitTrialPercent = 100;
% sdcp(i).hitTrialPercentAssignment = 'fixed';
% sdcp(i).trialOrder = 'basic';
% sdcp(i).eventWidth = {100, 'same'};
% sdcp(i).eventAmplificationFactor = 1;
% sdcp(i).eventTiming = 'sequential';
% sdcp(i).startFrame = 100;
% sdcp(i).endFrame = 200;
% sdcp(i).imprecisionFWHM = 8;
% sdcp(i).imprecisionType = 'none';
% sdcp(i).noise = 'gaussian';
% sdcp(i).noisePercent = 75;
% sdcp(i).randomseed = 'default';
% sdcp(i).comment = '75% gaussian noise';
% rng(sdcp(i).randomseed)
% 
% %i = 5
% i = i + 1;
% sdcp(i).timeCellPercent = 50;
% sdcp(i).cellOrder = 'basic';
% sdcp(i).maxHitTrialPercent = 100;
% sdcp(i).hitTrialPercentAssignment = 'fixed';
% sdcp(i).trialOrder = 'basic';
% sdcp(i).eventWidth = {100, 'same'};
% sdcp(i).eventAmplificationFactor = 1;
% sdcp(i).eventTiming = 'sequential';
% sdcp(i).startFrame = 100;
% sdcp(i).endFrame = 200;
% sdcp(i).imprecisionFWHM = 8;
% sdcp(i).imprecisionType = 'none';
% sdcp(i).noise = 'gaussian';
% sdcp(i).noisePercent = 100;
% sdcp(i).randomseed = 'default';
% sdcp(i).comment = '100% gaussian noise';
% rng(sdcp(i).randomseed)