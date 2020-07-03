% Function call: "Dispatcher" by Kambadur Ananthamurthy
% This code uses actual dfbf curves from my data and analyses it for time
% cells using multiple methods
% Currently uses one session of real data, but can analyze synthetic
% datasets in batch.

function runBatchAnalysisOnServer(sdcpStart, sdcpEnd, runA, runB, runC, runD, runE)

tic
close all

HOME_DIR = '/home/bhalla/ananthamurthy';
%HOME_DIR = '/Users/ananth/Documents/';
addpath(genpath(strcat(HOME_DIR, 'MATLAB/CustomFunctions'))) % my custom functions
addpath(genpath(strcat(HOME_DIR,'MATLAB/ImagingAnalysis'))) % Additional functions
addpath(genpath(strcat(HOME_DIR, 'MATLAB/ImagingAnalysis/Suite2P-ananth')))
addpath(strcat(HOME_DIR, 'MATLAB/ImagingAnalysis/Suite2P-ananth/localCopies'))

methodList = determineMethod(runA, runB, runC, runD, runE);

% Print 6 lines of whitespace - Prevents any messages from being missed
for space = 1:6
    fprintf(1, '\n');
end
clear space

%diary (strcat(HOME_DIR, '/logs/analysisDiary'))
%diary on
%% Dataset
make_db %Currently only for one session at a time
fprintf('Analyzing %s_%i_%i - Date: %s\n', ...
    db.mouseName, ...
    db.sessionType, ...
    db.session, ...
    db.date)

saveDirec = strcat(HOME_DIR, '/Work/Analysis/Imaging/');
%saveDirec = strcat('/Users/ananth/Desktop/', 'Work/Analysis/Imaging/');
saveFolder = strcat(saveDirec, db.mouseName, '/', db.date, '/');

ops0.saveData                  = 1;
ops0.onlyProbeTrials           = 0;
ops0.loadSyntheticData         = 1;
ops0.doSigOnly                 = 0;

if ops0.loadSyntheticData
    setupSyntheticDataParametersOnServer %Loads all options, not just [sdcpStart, sdcpEnd]
    nDatasets = length(sdcp);
end

%% Preallocation
%Method A
s.Q = [];
s.T = [];
s.timeCells = [];
s.normQ = [];
mAOutput_batch = repmat(s, 1, nDatasets);
clear s

%Method B
s.Mdl = [];
s.Yfit = [];
s.Q = [];
s.trainingTrials = [];
s.testingTrials = [];
s.Yfit_actual = [];
s.YfitDiff = [];
s.Yfit_2D = [];
s.Yfit_actual_2D = [];
s.YfitDiff_2D = [];
s.timeCells = [];
s.normQ = [];
mBOutput_batch = repmat(s, 1, nDatasets);
clear s

%Method C
s.Q1 = [];
s.Q2 = [];
s.T = [];
s.timeCells = [];
s.normQ1 = [];
s.normQ2 = [];
mCOutput_batch = repmat(s, 1, nDatasets);
clear s

%Method D
s.selectedPC = [];
s.d1 = [];
s.dx = [];
s.dt = [];
s.Q = [];
s.T = [];
s.timeCells = [];
s.normQ = [];
mDOutput_batch = repmat(s, 1, nDatasets);
clear s

%Method E
s.X = [];
s.X0 = [];
s.Y = [];
s.SVMModel = [];
s.Yfit = [];
s.YfitDiff = [];
s.Q = [];
s.Yfit_2D = [];
s.Yfit_actual_2D = [];
s.YfitDiff_2D = [];
s.Q_2D = [];
s.T = [];
s.timeCells = [];
mEOutput_batch = repmat(s, 1, nDatasets);
clear s

%% Main script
for runi = sdcpStart: 1: sdcpEnd
    fprintf('Currently analyzing dataset: %i\n', runi)
    
    if ops0.loadSyntheticData
        if exist("sdo_batch", "var")
            %No need to load anything
        else
            load([saveFolder ...
                'synthDATA' ...
                '_batch_', ...
                num2str(nDatasets), ...
                '.mat'], 'sdo_batch');
        end
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
    
    if runA
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
        mAOutput_batch(runi) = mAOutput;
        %save([saveFolder db.mouseName '_' db.date '_methodA.mat' ], 'mAInput', 'mAOutput')
    end
    
    % ----
    
    if runB
        %Method B - William Mau's Temporal Information (Eichenbaum Lab)
        mBInput.delta = 3;
        mBInput.whichTrials = 'alternate';
        mBInput.labelShuffle = 'off';
        mBInput.distribution4Bayes = 'mn';
        [mBOutput] = runWilliamTIAnalysis(DATA, mBInput);
        mBOutput.normQ = (mBOutput.Q)/max(mBOutput.Q);
        mBOutput_batch(runi) = mBOutput;
        %save([saveFolder db.mouseName '_' db.date '_methodB.mat' ], 'mBInput', 'mBOutput')
    end
    
    % ----
    if runC
        %Method C - Simple Analysis
        mCInput.delta = 3;
        mCInput.skipFrames = [];
        mCInput.trialThreshold = 25; % in %
        [mCOutput] = runSimpleTCAnalysis(DATA, mCInput);
        mCOutput.normQ1 = (mCOutput.Q1)/max(mCOutput.Q1);
        mCOutput.normQ2 = (mCOutput.Q2)/max(mCOutput.Q2);
        mCOutput_batch(runi) = mCOutput;
        %save([saveFolder db.mouseName '_' db.date '_methodC.mat' ], 'mCInput', 'mCOutput')
    end
    
    % ----
    
    if runD
        %Method D - Arnaud Malvache' PCA based Analysis for Sequences
        mDInput.delta = 3;
        mDInput.skipFrames = [];
        mDInput.gaussianSmoothing = 1; %logical
        mDInput.nSamples = 5; %for Gaussian Kernel
        mDInput.automatic = 1; %for selecting P; logical
        mDInput.timeVector = (1:db.nFrames*size(DATA,2)) * (1/db.samplingRate); %in seconds; %For derivative
        [mDOutput] = runSeqBasedTCAnalysis(DATA, mDInput);
        mDOutput.normQ = (mDOutput.Q) ./max(mDOutput.Q);
        mDOutput_batch(runi) = mDOutput;
        %save([saveFolder db.mouseName '_' db.date '_methodD.mat' ], 'mDInput', 'mDOutput')
    end
    
    % ----
    
    if runE
        %Method E - SVM based classification of cells
        mEInput.delta = 3;
        mEInput.skipFrames = [];
        mEInput.gaussianSmoothing = 0; %logical
        mEInput.nSamples = 5; %for Gaussian Kernel; relevant only if gaussian smoothing is on
        mEInput.whichTrials = 'alternate';
        mEInput.labelShuffle = 'off';
        if ops0.loadSyntheticData
            mEInput.ptcList = sdo_batch(runi).ptcList;
            mEInput.ocList = sdo_batch(runi).ocList;
        else
            if strcmpi(mEInput.whichCells, 'timeCells')
                mEInput.ptcList = input('Enter Time Cell List: ');
            elseif strcmpi(mEInput.whichCells, 'otherCells')
                mEInput.ocList = input('Enter Other Cell List: ');
            end
        end
        [mEOutput] = runSVMClassification(DATA, mEInput);
        mEOutput_batch(runi) = mEOutput;
        %save([saveFolder db.mouseName '_' db.date '_methodE.mat' ], 'mEInput', 'mEOutput')
    end
end

%% Save Data
if ops0.saveData
    
    if ops0.loadSyntheticData
        if runA
            save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_batch_methodA_' num2str(sdcpStart) '-' num2str(sdcpEnd) '.mat' ], 'mAInput', 'mAOutput_batch', '-v7.3')
        end
        
        if runB
            save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_batch_methodB_' num2str(sdcpStart) '-' num2str(sdcpEnd) '.mat' ], 'mBInput', 'mBOutput_batch', '-v7.3')
        end
        
        if runC
            save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_batch_methodC_' num2str(sdcpStart) '-' num2str(sdcpEnd) '.mat' ], 'mCInput', 'mCOutput_batch', '-v7.3')
        end
        
        if runD
            save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_batch_methodD_' num2str(sdcpStart) '-' num2str(sdcpEnd) '.mat' ], 'mDInput', 'mDOutput_batch', '-v7.3')
        end
        
        if runE
            save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_batch_methodE_batch' num2str(sdcpStart) '-' num2str(sdcpEnd) '.mat' ], 'mEInput', 'mEOutput_batch', '-v7.3')
        end
    else %Real Physiology Data
        if runA
            save([saveFolder db.mouseName '_' db.date '_realDataAnalysis_batch_methodA.mat' ], 'mAInput', 'mAOutput_batch', '-v7.3')
        end
        
        if runB
            save([saveFolder db.mouseName '_' db.date '_realDataAnalysis_batch_methodB.mat' ], 'mBInput', 'mBOutput_batch', '-v7.3')
        end
        
        if runC
            save([saveFolder db.mouseName '_' db.date '_realDataAnalysis_batch_methodC.mat' ], 'mCInput', 'mCOutput_batch', '-v7.3')
        end
        
        if runD
            save([saveFolder db.mouseName '_' db.date '_realDataAnalysis_batch_methodD.mat' ], 'mDInput', 'mDOutput_batch', '-v7.3')
        end
        
        if runE
            save([saveFolder db.mouseName '_' db.date '_realDataAnalysis_batch_methodE.mat' ], 'mEInput', 'mEOutput_batch', '-v7.3')
        end
    end
end
toc
fprintf('Complete: %i to %i by %s', sdcpStart, sdcpEnd, methodList);
%diary off
end