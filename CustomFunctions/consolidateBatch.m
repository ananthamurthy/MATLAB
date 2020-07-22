% AUTHOR: Kambadur Ananthamurthy
% Here, 'date' refers to the date the batch analysis jobs were launched
% Doubt I'll launch multiple batch analyses on the same day, but this can
% be remedied by selecting an appropriate string instead of the date.
% AUTHOR: Kambadur Ananthamurthy
% Run this function to collect outputs from independent jobs and
% consolidate them into one file.
% date: Job Date
% cRun: Harvest Number

function consolidateBatch(date, cRun, nDatasets)

tic
HOME_DIR = '/home/bhalla/ananthamurthy';
ANALYSIS_DIR = '/home/bhalla/ananthamurthy/Work/Analysis';
addpath(strcat(HOME_DIR, '/MATLAB/ImagingAnalysis/Suite2P-ananth/localCopies'))
addpath(genpath(strcat(HOME_DIR, '/MATLAB/CustomFunctions'))) % my custom functions

disp('Loading main dataset details ...')
make_db
disp('... done!')

saveFolder = strcat(ANALYSIS_DIR, '/Imaging/', db.mouseName, '/', db.date, '/');

disp('Setting up parameters for harvest ...')
setupHarvestParamsOnServer
disp('... done!')

%Preallocation
% cData.methodA = [];
% cData.methodB = [];
% cData.methodC = [];
% cData.methodD = [];
% cData.methodE = [];
%% Preallocation
%Method A
s.Q = [];
s.T = [];
s.timeCells = [];
s.normQ = [];
cData.methodA.mAOutput_batch = repmat(s, 1, nDatasets);
cData.methodA.mAInput = [];
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
cData.methodB.mBOutput_batch = repmat(s, 1, nDatasets);
cData.methodB.mBInput = [];
clear s

%Method C
s.Q1 = [];
s.Q2 = [];
s.T = [];
s.timeCells = [];
s.normQ1 = [];
s.normQ2 = [];
mCOutput_batch = repmat(s, 1, nDatasets);
cData.methodC.mCOutput_batch = repmat(s, 1, nDatasets);
cData.methodC.mCInput = [];
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
cData.methodD.mDOutput_batch = repmat(s, 1, nDatasets);
cData.methodD.mDInput = [];
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
cData.methodE.mEOutput_batch = repmat(s, 1, nDatasets);
cData.methodE.mEInput = [];
clear s

for job = 1:length(params)
    fprintf('Parsing output from job: %i\n', job)
    jobData = harvestAnalyzedData(db, params(job));
    if strcmpi(params(job).methodList, 'A')
        cData.methodA.mAInput = getfield(jobData, 'mAInput');
        cData.methodA.mAOutput_batch(params(job).sdcpStart:params(job).sdcpEnd) = getfield(jobData.holyData, 'mAOutput_batch');
    elseif strcmpi(params(job).methodList, 'B')
        cData.methodB.mBInput = getfield(jobData, 'mBInput');
        cData.methodB.mBOutput_batch(params(job).sdcpStart:params(job).sdcpEnd) = getfield(jobData.holyData, 'mBOutput_batch');
    elseif strcmpi(params(job).methodList, 'C')
        cData.methodC.mCInput = getfield(jobData, 'mCInput');
        cData.methodC.mCOutput_batch(params(job).sdcpStart:params(job).sdcpEnd) = getfield(jobData.holyData, 'mCOutput_batch');
    elseif strcmpi(params(job).methodList, 'D')
        cData.methodD.mDInput = getfield(jobData, 'mDInput');
        cData.methodD.mDOutput_batch(params(job).sdcpStart:params(job).sdcpEnd) = getfield(jobData.holyData, 'mDOutput_batch');
    elseif strcmpi(params(job).methodList, 'E')
        cData.methodE.mEInput = getfield(jobData, 'mEInput');
        cData.methodE.mEOutput_batch(params(job).sdcpStart:params(job).sdcpEnd) = getfield(jobData, 'mEOutput_batch');
    else
    end
    %     if strcmpi(params(job).methodList, 'A')
    %         cData.methodA = harvestAnalyzedData(db, params(job));
    %     elseif strcmpi(params(job).methodList, 'B')
    %         cData.methodB = harvestAnalyzedData(db, params(job));
    %     elseif strcmpi(params(job).methodList, 'C')
    %         cData.methodC = harvestAnalyzedData(db, params(job));
    %     elseif strcmpi(params(job).methodList, 'D')
    %         cData.methodD = harvestAnalyzedData(db, params(job));
    %     elseif strcmpi(params(job).methodList, 'E')
    %         cData.methodE = harvestAnalyzedData(db, params(job));
    %     else
    %     end
end

filename = [db.mouseName '_' db.date '_synthDataAnalysis_' num2str(date) '_cRun' num2str(cRun) '_cData.mat' ];
fullPath4Save = strcat(saveFolder, filename);

disp('Saving everything ...')
%save(fullPath4Save, 'cData', '-v7.3')
save(fullPath4Save, 'cData')
disp('... done!')

% %Information about new file
% h5info(filename, saveFolder)
% h5disp(filename, saveFolder)

toc
disp('All done!')

end