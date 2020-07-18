% AUTHOR: Kambadur Ananthamurthy

function trimBatch

HOME_DIR = '/home/bhalla/ananthamurthy';
ANALYSIS_DIR = '/home/bhalla/ananthamurthy/Work/Analysis';
addpath(strcat(HOME_DIR, '/MATLAB/ImagingAnalysis/Suite2P-ananth/localCopies'))
addpath(genpath(strcat(HOME_DIR, '/MATLAB/CustomFunctions'))) % my custom functions

disp('Picking up details of the primary/real dataset...')
make_db
disp('... done!')

saveFolder = strcat(ANALYSIS_DIR, '/Imaging/', db.mouseName, '/', db.date, '/');

disp('Picking up details for trim ...')
setupTrimParamsOnServer
disp('... done!')

for job = 1:length(params)
    fprintf('Parsing output from job: %i ...\n', job)
    holyData = exorciseModel(db, params(job));
    
    if strcmpi(params(job).methodList, 'B') && isfield(holyData.mBOutput_batch, 'Mdl')
        error('The Exorcism has failed')
    end
    
    if strcmpi(params(job).methodList, 'E') && isfield(holyData.mEOutput_batch, 'SVMModel')
        error('The Exorcism has failed')
    end
    
    disp('Saving trimmed file ...')
    save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_method' params(job).methodList '_' num2str(params(job).sdcpStart) '-' num2str(params(job).sdcpEnd) '_trimmed.mat'], 'holyData', '-v7.3');
    disp('... done!')
end
disp('All done!')

end