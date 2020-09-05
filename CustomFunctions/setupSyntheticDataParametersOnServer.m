%NOTE: String arguments may be provided in uppercase, partial capitalization, or lowercase

%{
JUST FOR REFERENCE
% Synthetic Data Parameters
timeCellPercent = 50; %in %
cellOrder = 'basic'; %basic or random
maxHitTrialPercent = 100; %in %
hitTrialPercentAssignment = 'random'; %fixed or random
trialOrder = 'random'; %basic or random
eventWidth = {50, 1}; %{percentile, range}
eventAmplificationFactor = 1;
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
    sdcp(count).eventWidth = {100, 0};
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
%1-10

%Time cell percents with 'random' order
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = value;
    sdcp(count).cellOrder = 'random';
    sdcp(count).maxHitTrialPercent = 100;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'basic';
    sdcp(count).eventWidth = {100, 0};
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
%11-20

%Max Hit Trial Percents with 'fixed' assignment
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'basic';
    sdcp(count).eventWidth = {100, 0};
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
%21-30

%Max Hit Trial Percents with 'random' assignment
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'random';
    sdcp(count).trialOrder = 'basic';
    sdcp(count).eventWidth = {100, 0};
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
%31-40

% %Max Hit Trial Percents with 'fixed' assignment, 'random' trial order
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 0};
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
%41-50

%Max Hit Trial Percents with 'random' assignment, 'random' trial order
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'random';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 0};
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
%51-60

%Event Widths (percentiles)
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {value, 0};
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
%61-70

%Event Widths (percentiles) with standard deviations
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {value, 1};
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
%71-80

%Uniform Imprecisions
for value = 1:2:20
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 0};
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
%81-90

%Normal Imprecisions
for value = 1:2:20
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 0};
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
%91-100

%Noise (only Gaussian type)
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 0};
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
%101-110

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
    sdcp(count).eventWidth = {100, 0};
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
%111-120

%Time cell percents with 'random' order
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = value;
    sdcp(count).cellOrder = 'random';
    sdcp(count).maxHitTrialPercent = 100;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'basic';
    sdcp(count).eventWidth = {100, 0};
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
%121-130

%Max Hit Trial Percents with 'fixed' assignment
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'basic';
    sdcp(count).eventWidth = {100, 0};
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
%131-140

%Max Hit Trial Percents with 'random' assignment
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'random';
    sdcp(count).trialOrder = 'basic';
    sdcp(count).eventWidth = {100, 0};
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
%141-150

%Max Hit Trial Percents with 'fixed' assignment, 'random' trial order
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 0};
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
%151-160

%Max Hit Trial Percents with 'random' assignment, 'random' trial order
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = value;
    sdcp(count).hitTrialPercentAssignment = 'random';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 0};
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
%161-170

%Event Widths (percentiles)
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {value, 0};
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
%171-180

%Event Widths (percentiles) with standard deviations
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {value, 1};
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
%181-190

%Uniform Imprecisions
for value = 1:2:20
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 0};
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
%191-200

%Normal Imprecisions
for value = 1:2:20
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 0};
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
%201-210

%Noise (only Gaussian type)
for value = 10:10:100
    count = count + 1;
    sdcp(count).timeCellPercent = 50;
    sdcp(count).cellOrder = 'basic';
    sdcp(count).maxHitTrialPercent = 50;
    sdcp(count).hitTrialPercentAssignment = 'fixed';
    sdcp(count).trialOrder = 'random';
    sdcp(count).eventWidth = {100, 0};
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
%211-220