%"Dispatcher" by Kambadur Ananthamurthy
% This code uses actual dfbf curves from my data and analyses it for time
% cells using multiple methods
% Currently uses one session of real data, but can analyze synthetic
% datasets in batch.

tic
clear
close all

%% Addpaths
addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions')) % my custom functions
addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis')) % Additional functions
addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis/Suite2P-ananth'))
addpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis/Suite2P-ananth/localCopies')

%% Dataset
make_db
fprintf('Analyzing %s_%i_%i - Date: %s\n', db.mouseName, ...
    db.sessionType, ...
    db.session, ...
    db.date)

saveDirec = '/Users/ananth/Desktop/Work/Analysis/Imaging/';
saveFolder = [saveDirec db.mouseName '/' db.date '/'];

ops0.saveData                  = 1;
ops0.onlyProbeTrials           = 0;
ops0.loadSyntheticData         = 1;
ops0.doSigOnly                 = 0;
ops0.comment                   = 'EffectOfNoisePercent'; %No spaces or "-"; capitalization is handled

if ops0.loadSyntheticData
    setupSyntheticDataParameters_batch
end

%% Preallocation
s.Q = 0;
s.T = 0;
s.timeCells = [];
s.normQ = 0;
mAOutput_batch = repmat(s, 1, length(sdcp));
mBOutput_batch = repmat(s, 1, length(sdcp));
clear s

s.Q1 = 0;
s.Q2 = 0;
s.T = 0;
s.timeCells = [];
s.normQ1 = 0;
s.normQ2 = 0;
mCOutput_batch = repmat(s, 1, length(sdcp));
clear s

%% Main script
for runi = 1: 1: length(sdcp)
    fprintf('Currently running control parameter set: %i\n', runi)
    
    if ops0.loadSyntheticData
        load([saveFolder ...
            'synthDATA' ...
            '_batch_', ...
            lower(ops0.comment), ...
            '.mat']);
        myData.dfbf = sdo_batch(runi).syntheticDATA;
        myData.dfbf_2D = sdo_batch(runi).syntheticDATA_2D;
        myData.baselines = zeros(size(sdo_batch(runi).syntheticDATA)); %initialization
    else
        %Load processed data (processed dfbf for dataset/session)
        myData = load([saveFolder db.mouseName '_' db.date '.mat']);
    end
    trialDetails = getTrialDetails(db);
    
    %Significant-Only Traces
    if ops0.doSigOnly
        if ops0.onlyProbeTrials
            disp('Only analysing Probe Trials ...')
            dfbf_sigOnly = findSigOnly(myData.dfbf(:, iProbeTrials, :));
        else
            dfbf_sigOnly = findSigOnly(myData.dfbf);
        end
        DATA = dfbf_sigOnly;
    else
        DATA = myData.dfbf;
    end
    
    %% Analysis Pipelines
    
    %Method A - Mehrab's Reliability Analysis (Bhalla Lab)
    mAInput.cellList = 1:1:size(DATA,1); %using all cells
    mAInput.onFrame = sdcp.startFrame;
    mAInput.offFrame = sdcp.endFrame;
    mAInput.ridgeHalfWidth = 100; %in ms
    mAInput.nIterations = 5000; %number of iterations of randomisation used to find averaged r-shifted rb ratio - might have to go as high as 3000.
    mAInput.selectNonOverlappingTrials = 1; %1 - non-overlapping trial sets used for kernel estimation and rb ratio calculation, 0 - all trials used for both
    mAInput.earlyOnly = 0; %0 - uses all trials; 1 - uses only the first 5 trials of the session
    mAInput.startTrial = 1; %the analysis begins with this trial number (e.g. - 1: analysis on all trials)
    
    [mAOutput] = runMehrabR2BAnalysis(DATA, mAInput, trialDetails);
    mAOutput.normQ = (mAOutput.Q)/max(mAOutput.Q(~isinf(mAOutput.Q)));
    
    %save([saveFolder db.mouseName '_' db.date '_methodA.mat' ], 'mAInput', 'mAOutput')
    
    % ----
    
    %Method B - William Mau's Temporal Information (Eichenbaum Lab)
    mBInput = [];
    [mBOutput] = runWilliamTIAnalysis(DATA);
    mBOutput.normQ = (mBOutput.Q)/max(mBOutput.Q);
    
    %save([saveFolder db.mouseName '_' db.date '_methodB.mat' ], 'mBInput', 'mBOutput')
    
    % ----
    
    %Method C - Simple Analysis
    mCInput.delta = 3;
    mCInput.skipFrames = [];
    mCInput.trialThreshold = 25; % in %
    [mCOutput] = runSimpleTCAnalysis(DATA, mCInput);
    mCOutput.normQ1 = (mCOutput.Q1)/max(mCOutput.Q1);
    mCOutput.normQ2 = (mCOutput.Q2)/max(mCOutput.Q2);
    
    %save([saveFolder db.mouseName '_' db.date '_methodC.mat' ], 'mCInput', 'mCOutput')
    
    mAOutput_batch(runi) = mAOutput;
    mBOutput_batch(runi) = mBOutput;
    mCOutput_batch(runi) = mCOutput;
end

%% Save Data
if ops0.saveData
    
    if ops0.loadSyntheticData
        save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_methodA_batch.mat' ], 'mAInput', 'mAOutput_batch')
        save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_methodB_batch.mat' ], 'mBInput', 'mBOutput_batch')
        save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_methodC_batch.mat' ], 'mCInput', 'mCOutput_batch')
    else
        save([saveFolder db.mouseName '_' db.date '_realDataAnalysis_methodA_batch.mat' ], 'mAInput', 'mAOutput_batch')
        save([saveFolder db.mouseName '_' db.date '_realDataAnalysis_methodB_batch.mat' ], 'mBInput', 'mBOutput_batch')
        save([saveFolder db.mouseName '_' db.date '_realDataAnalysis_methodC_batch.mat' ], 'mCInput', 'mCOutput_batch')
    end
end
toc