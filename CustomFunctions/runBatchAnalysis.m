% Function call: "Dispatcher" by Kambadur Ananthamurthy
% This code uses actual dfbf curves from my data and analyses it for time
% cells using multiple methods
% Currently uses one session of real data, but can analyze synthetic
% datasets in batch.
% gDate: date when data generation occurred (ideally, analysis should
% happen on the same day as the generation)
% gRun: run number for data generation (multiple runs could happen on the
% same day)

function emptyOutput = runBatchAnalysis(sdcpStart, sdcpEnd, runA, runB, runC, runD, runE, runF, gDate, gRun, workingOnServer, diaryOn)

tic
close all

if workingOnServer
    HOME_DIR = '/home/bhalla/ananthamurthy/';
else
    HOME_DIR = '/Users/ananth/Documents/';
    HOME_DIR2 = '/Users/ananth/Desktop/';
end
addpath(genpath(strcat(HOME_DIR, '/MATLAB/CustomFunctions'))) % my custom functions
addpath(genpath(strcat(HOME_DIR,'/MATLAB/ImagingAnalysis'))) % Additional functions
addpath(genpath(strcat(HOME_DIR, '/MATLAB/ImagingAnalysis/Suite2P-ananth')))
addpath(strcat(HOME_DIR, '/MATLAB/ImagingAnalysis/Suite2P-ananth/localCopies'))

methodList = determineMethod(runA, runB, runC, runD, runE, runF);

if diaryOn
    if workingOnServer
        diary (strcat(HOME_DIR, '/logs/batchAnalysisDiary'))
    else
        diary (strcat(HOME_DIR2, '/logs/batchAnalysisDiary_', num2str(gDate), '_', num2str(gRun)))
    end
    diary on
end

% % Print 6 lines of whitespace - Prevents any messages from being missed
% for space = 1:6
%     fprintf(1, '\n');
% end
% clear space

%% Dataset
make_db %Currently only for one session at a time
fprintf('Analyzing %s_%i_%i - Date: %s\n', ...
    db.mouseName, ...
    db.sessionType, ...
    db.session, ...
    db.date)

if workingOnServer
    saveDirec = strcat(HOME_DIR, 'Work/Analysis/Imaging/');
else
    saveDirec = strcat(HOME_DIR2, 'Work/Analysis/Imaging/');
end
saveFolder = strcat(saveDirec, db.mouseName, '/', db.date, '/');

ops0.saveData                  = 1;
ops0.onlyProbeTrials           = 0;
ops0.loadSyntheticData         = 1;
ops0.doSigOnly                 = 0;

if ops0.loadSyntheticData
    setupSyntheticDataParams %Loads all options, not just [sdcpStart, sdcpEnd]
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
s.timeCells1 = [];
s.timeCells2 = [];
s.timeCells3 = [];
s.timeCells4 = [];
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
s.normQ = [];
mEOutput_batch = repmat(s, 1, nDatasets);
clear s

%Method F
s.Q1 = [];
s.Q2 = [];
s.T = [];
s.timeCells1 = [];
s.timeCells2 = [];
s.normQ1 = [];
s.normQ2 = [];
mFOutput_batch = repmat(s, 1, nDatasets);
clear s

%% Main script
for runi = sdcpStart: 1: sdcpEnd
    fprintf('Currently analyzing dataset: %i\n', runi)
    
    if ops0.loadSyntheticData
        if exist("sdo_batch", "var")
            %No need to load anything
        else
            load([saveFolder ...
                'synthDATA_' ...
                num2str(gDate), ...
                '_gRun', num2str(gRun), ...
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
        mBInput.distribution4Bayes = 'mvmn';
        mBInput.saveModel = 0;
        mBInput.nIterations = 1000;
        mBInput.startFrame = 75;
        mBInput.nIterations = 1000;
        mBInput.threshold = 99; %in %
        if ~mBInput.saveModel
            try
                mBOutput_batch = rmfield(mBOutput_batch, 'Mdl');
            catch
            end
        end
        
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
        mCInput.nIterations = 1000;
        mCInput.threshold = 99; %in %
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
        mDInput.getT = 1;
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
        mEInput.getT = 0;
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
        
        mEInput.saveModel = 0;
        if ~mEInput.saveModel
            try
                mEOutput_batch = rmfield(mEOutput_batch, 'SVMModel');
            catch
            end
        end
        [mEOutput] = runSVMClassification(DATA, mEInput);
        mEOutput.normQ = (mEOutput.Q) ./max(mEOutput.Q);
        mEOutput_batch(runi) = mEOutput;
        %save([saveFolder db.mouseName '_' db.date '_methodE.mat' ], 'mEInput', 'mEOutput')
    end
    
    % ----
    
    if runF
        %Method F - Derived Parametric Equations
        mFInput.delta = 3;
        mFInput.skipFrames = [];
        mFInput.nIterations = 1000;
        mFInput.alpha = 10;
        mFInput.beta = 1;
        mFInput.gamma = 10;
        [mFOutput] = runDerivedQAnalysis(DATA, mFInput);
        mFOutput.normQ1 = (mFOutput.Q1)/max(mFOutput.Q1);
        mFOutput.normQ2 = (mFOutput.Q2)/max(mFOutput.Q2);
        mFOutput_batch(runi) = mFOutput;
        %save([saveFolder db.mouseName '_' db.date '_methodF.mat' ], 'mFInput', 'mFOutput')
    end
end

%% Save Data
if ops0.saveData
    disp('Saving everything ...')
    if ops0.loadSyntheticData
        if runA
            save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_' num2str(gDate) '_gRun' num2str(gRun) '_methodA_batch_' num2str(sdcpStart) '-' num2str(sdcpEnd) '.mat' ], 'mAInput', 'mAOutput_batch', '-v7.3')
        end
        
        if runB
            save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_' num2str(gDate) '_gRun' num2str(gRun) '_methodB_batch_' num2str(sdcpStart) '-' num2str(sdcpEnd) '.mat' ], 'mBInput', 'mBOutput_batch', '-v7.3')
        end
        
        if runC
            save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_' num2str(gDate) '_gRun' num2str(gRun) '_methodC_batch_' num2str(sdcpStart) '-' num2str(sdcpEnd) '.mat' ], 'mCInput', 'mCOutput_batch', '-v7.3')
        end
        
        if runD
            save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_' num2str(gDate) '_gRun' num2str(gRun) '_methodD_batch_' num2str(sdcpStart) '-' num2str(sdcpEnd) '.mat' ], 'mDInput', 'mDOutput_batch', '-v7.3')
        end
        
        if runE
            save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_' num2str(gDate) '_gRun' num2str(gRun) '_methodE_batch_' num2str(sdcpStart) '-' num2str(sdcpEnd) '.mat' ], 'mEInput', 'mEOutput_batch', '-v7.3')
        end
        
        if runF
            save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_' num2str(gDate) '_gRun' num2str(gRun) '_methodF_batch_' num2str(sdcpStart) '-' num2str(sdcpEnd) '.mat' ], 'mFInput', 'mFOutput_batch', '-v7.3')
        end
    else %Real Physiology Data
        if runA
            save([saveFolder db.mouseName '_' db.date '_realDataAnalysis_' num2str(gDate) '_gRun' num2str(gRun) '_methodA_batch.mat' ], 'mAInput', 'mAOutput_batch', '-v7.3')
        end
        
        if runB
            save([saveFolder db.mouseName '_' db.date '_realDataAnalysis_' num2str(gDate) '_gRun' num2str(gRun) '_methodB_batch.mat' ], 'mBInput', 'mBOutput_batch', '-v7.3')
        end
        
        if runC
            save([saveFolder db.mouseName '_' db.date '_realDataAnalysis_' num2str(gDate) '_gRun' num2str(gRun) '_methodC_batch.mat' ], 'mCInput', 'mCOutput_batch', '-v7.3')
        end
        
        if runD
            save([saveFolder db.mouseName '_' db.date '_realDataAnalysis_' num2str(gDate) '_gRun' num2str(gRun) '_methodD_batch.mat' ], 'mDInput', 'mDOutput_batch', '-v7.3')
        end
        
        if runE
            save([saveFolder db.mouseName '_' db.date '_realDataAnalysis_' num2str(gDate) '_gRun' num2str(gRun) '_methodE_batch.mat' ], 'mEInput', 'mEOutput_batch', '-v7.3')
        end
        
        if runF
            save([saveFolder db.mouseName '_' db.date '_realDataAnalysis_' num2str(gDate) '_gRun' num2str(gRun) '_methodF_batch.mat' ], 'mFInput', 'mFOutput_batch', '-v7.3')
        end
    end
    disp('... done!')
end
toc
fprintf('Complete: %i to %i by %s [date:%i gRun:%i]\n', sdcpStart, sdcpEnd, methodList, gDate, gRun);
emptyOutput = [];

if diaryOn
    diary off
end

end