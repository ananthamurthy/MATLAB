% AUTHOR: Kambadur Ananthamurthy
% Here, 'date' refers to the date the batch analysis jobs were launched
% Doubt I'll launch multiple batch analyses on the same day, but this can
% be remedied by selecting an appropriate string instead of the date.

function consolidateBatch(date)

HOME_DIR = '/home/bhalla/ananthamurthy/';
ANALYSIS_DIR = '/home/bhalla/ananthamurthy/Work/Analysis/';
addpath(strcat(HOME_DIR, 'MATLAB/ImagingAnalysis/Suite2P-ananth/localCopies'))
addpath(genpath(strcat(HOME_DIR, 'MATLAB/CustomFunctions'))) % my custom functions

make_db

saveFolder = strcat(ANALYSIS_DIR, 'Imaging/', db.mouseName, '/', db.date, '/');

setupHarvestParamsOnServer

for job = 1:length(params)
    fprintf('Currently parsing output from job: %i\n', job)
    cData = harvestAnalyzedData(db, params(exp));
end

save([saveFolder db.mouseName '_' db.date '_batch' num2str(date) '_cData.mat' ], 'cData', '-v7.3')
end