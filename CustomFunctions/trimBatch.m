% AUTHOR: Kambadur Ananthamurthy

function trimBatch

HOME_DIR = '/home/bhalla/ananthamurthy';
ANALYSIS_DIR = '/home/bhalla/ananthamurthy/Work/Analysis';
addpath(strcat(HOME_DIR, '/MATLAB/ImagingAnalysis/Suite2P-ananth/localCopies'))
addpath(genpath(strcat(HOME_DIR, '/MATLAB/CustomFunctions'))) % my custom functions

disp('Loading main dataset details ...')
make_db
disp('... done!')

saveFolder = strcat(ANALYSIS_DIR, '/Imaging/', db.mouseName, '/', db.date, '/');

disp('Setting up parameters for trimming datasets ...')
setupTrimParamsOnServer
disp('... done!')

for job = 1:length(params)
    %fprintf('Parsing output from job: %i\n', job)
    holyData = exorciseModel(db, params(job));
    save([saveFolder db.mouseName '_' db.date '_synthDataAnalysis_method' params(job).methodList '_' num2str(params(job).sdcpStart) '-' num2str(params(job).sdcpEnd) '_trimmed.mat'], 'holyData', '-v7.3');
end

end