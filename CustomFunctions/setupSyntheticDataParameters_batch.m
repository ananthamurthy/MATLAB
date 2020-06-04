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
count = 0;
%% Synthetic Data Parameters - Batch

%Sequential Timing
%Time cell percents with 'basic' order
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = value;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 100;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'basic';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'sequential';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Percent Time Cells: %i; Cell Order: %s; Event Timing: %s', count, value, sdcp(count).cellOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Time cell percents with 'random' order
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = value;
    sdcp(count).cellOrder = 'random';
    sdcp(count).maxHitTrialPercent = 100;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'basic';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'sequential';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Percent Time Cells: %i; Cell Order: %s; Event Timing: %s', count, value, sdcp(count).cellOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Max Hit Trial Percents with 'fixed' assignment
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'basic';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'sequential';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Max Hit Trial Percent: %i; Trial Assignment: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Max Hit Trial Percents with 'random' assignment
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'random';
    sdcp(count).trialOrder = 'basic';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'sequential';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Max Hit Trial Percent: %i; Trial Assignment: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

% %Max Hit Trial Percents with 'fixed' assignment, 'random' trial order
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'sequential';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Max Hit Trial Percent: %i; Trial Assignment: %s; Trial Order: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).trialOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Max Hit Trial Percents with 'random' assignment, 'random' trial order
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'random';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'sequential';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Max Hit Trial Percent: %i; Trial Assignment: %s; Trial Order: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).trialOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Event Widths (percentiles)
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {value, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'sequential';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Event Width (percentile): %i; Trial Assignment: %s; Trial Order: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).trialOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Event Widths (percentiles) with standard deviations
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {value, 'stddev'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'sequential';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Event Width (percentile): %i (with stddev); Trial Assignment: %s; Trial Order: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).trialOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Uniform Imprecisions
for value = 1:2:20
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'sequential';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = value;
    sdcp(count).imprecisionType = 'uniform';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Uniform ImprecisionFWHM: %i; Trial Assignment: %s; Trial Order: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).trialOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Normal Imprecisions
for value = 1:2:20
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'sequential';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = value;
    sdcp(count).imprecisionType = 'normal';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Normal ImprecisionFWHM: %i; Trial Assignment: %s; Trial Order: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).trialOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Noise (only Gaussian type)
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'sequential';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = value;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Noise Percent: %i; Trial Assignment: %s; Trial Order: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).trialOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%--- Repeat everything with random timing

%Random Timing
%Time cell percents with 'basic' order
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = value;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 100;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'basic';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'random';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Percent Time Cells: %i; Cell Order: %s; Event Timing: %s', count, value, sdcp(count).cellOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Time cell percents with 'random' order
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = value;
    sdcp(count).cellOrder = 'random';
    sdcp(count).maxHitTrialPercent = 100;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'basic';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'random';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Percent Time Cells: %i; Cell Order: %s; Event Timing: %s', count, value, sdcp(count).cellOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Max Hit Trial Percents with 'fixed' assignment
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'basic';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'random';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Max Hit Trial Percent: %i; Trial Assignment: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Max Hit Trial Percents with 'random' assignment
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'random';
    sdcp(count).trialOrder = 'basic';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'random';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Max Hit Trial Percent: %i; Trial Assignment: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Max Hit Trial Percents with 'fixed' assignment, 'random' trial order
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'random';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Max Hit Trial Percent: %i; Trial Assignment: %s; Trial Order: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).trialOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Max Hit Trial Percents with 'random' assignment, 'random' trial order
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'random';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'random';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Max Hit Trial Percent: %i; Trial Assignment: %s; Trial Order: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).trialOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Event Widths (percentiles)
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {value, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'random';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Event Width (percentile): %i; Trial Assignment: %s; Trial Order: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).trialOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Event Widths (percentiles) with standard deviations
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {value, 'stddev'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'random';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Event Width (percentile): %i (with stddev); Trial Assignment: %s; Trial Order: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).trialOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Uniform Imprecisions
for value = 1:2:20
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'random';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = value;
    sdcp(count).imprecisionType = 'uniform';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Uniform ImprecisionFWHM: %i; Trial Assignment: %s; Trial Order: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).trialOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Normal Imprecisions
for value = 1:2:20
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'random';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = value;
    sdcp(count).imprecisionType = 'normal';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = 0;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Normal ImprecisionFWHM: %i; Trial Assignment: %s; Trial Order: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).trialOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end

%Noise (only Gaussian type)
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 'same'};
    sdcp(count).eventAmplificationFactor = 1;
    sdcp(count).eventTiming = 'random';
    sdcp(count).startFrame = 75;
    sdcp(count).endFrame = 150;
    sdcp(count).imprecisionFWHM = 0;
    sdcp(count).imprecisionType = 'none';
    sdcp(count).noise = 'gaussian';
    sdcp(count).noisePercent = value;
    sdcp(count).randomseed = 'default';
    sdcp(count).comment = sprintf('%i | Noise Percent: %i; Trial Assignment: %s; Trial Order: %s; Event Timing: %s', count, value, sdcp(count).hitTrialPercentAssignment, sdcp(count).trialOrder, sdcp(count).eventTiming);
    rng(sdcp(count).randomseed)
end