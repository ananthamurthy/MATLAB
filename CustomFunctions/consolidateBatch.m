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

for job = 1:length(params)
    fprintf('Parsing output from job: %i\n', job)
    jobData = harvestAnalyzedData(db, params(job));
    if strcmpi(params(job).methodList, 'A')
        if ~params(job).trim
            cData.methodA.mAInput = jobData.mAInput;
            cData.methodA.mAOutput_batch(params(job).sdcpStart:params(job).sdcpEnd) = jobData.mAOutput_batch(params(job).sdcpStart:params(job).sdcpEnd);
        else
            cData.methodA.holyData.mAInput = jobData.holyData.mAInput;
            cData.methodA.holyData.mAOutput_batch(params(job).sdcpStart:params(job).sdcpEnd) = jobData.holyData.mAOutput_batch(params(job).sdcpStart:params(job).sdcpEnd);
        end
    elseif strcmpi(params(job).methodList, 'B')
        if ~params(job).trim
            cData.methodB.mBInput = jobData.mBInput;
            cData.methodB.mBOutput_batch(params(job).sdcpStart:params(job).sdcpEnd) = jobData.mBOutput_batch(params(job).sdcpStart:params(job).sdcpEnd);
        else
            cData.methodB.holyData.mBInput = jobData.holyData.mBInput;
            cData.methodB.holyData.mBOutput_batch(params(job).sdcpStart:params(job).sdcpEnd) = jobData.holyData.mBOutput_batch(params(job).sdcpStart:params(job).sdcpEnd);
        end
    elseif strcmpi(params(job).methodList, 'C')
        if ~params(job).trim
            cData.methodC.mCInput = jobData.mCInput;
            cData.methodC.mCOutput_batch(params(job).sdcpStart:params(job).sdcpEnd) = jobData.mCOutput_batch(params(job).sdcpStart:params(job).sdcpEnd);
        else
            cData.methodC.holyData.mCInput = jobData.holyData.mCInput;
            cData.methodC.holyData.mCOutput_batch(params(job).sdcpStart:params(job).sdcpEnd) = jobData.holyData.mCOutput_batch(params(job).sdcpStart:params(job).sdcpEnd);
        end
    elseif strcmpi(params(job).methodList, 'D')
        if ~params(job).trim
            cData.methodD.mDInput = jobData.mDInput;
            cData.methodD.mDOutput_batch(params(job).sdcpStart:params(job).sdcpEnd) = jobData.mDOutput_batch(params(job).sdcpStart:params(job).sdcpEnd);
        else
            cData.methodD.holyData.mDInput = jobData.holyData.mDInput;
            cData.methodD.holyData.mDOutput_batch(params(job).sdcpStart:params(job).sdcpEnd) = jobData.holyData.mDOutput_batch(params(job).sdcpStart:params(job).sdcpEnd);
        end
    elseif strcmpi(params(job).methodList, 'E')
        if ~params(job).trim
            cData.methodE.mEInput = jobData.mEInput;
            cData.methodE.mEOutput_batch(params(job).sdcpStart:params(job).sdcpEnd) = jobData.mEOutput_batch(params(job).sdcpStart:params(job).sdcpEnd);
        else
            cData.methodE.holyData.mEInput = jobData.holyData.mEInput;
            cData.methodE.holyData.mEOutput_batch(params(job).sdcpStart:params(job).sdcpEnd) = jobData.holyData.mEOutput_batch(params(job).sdcpStart:params(job).sdcpEnd);
        end
    else
    end
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