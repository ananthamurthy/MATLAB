% AUTHOR: Kambadur Ananthamurthy
% Here, 'date' refers to the date the batch analysis jobs were launched
% Doubt I'll launch multiple batch analyses on the same day, but this can
% be remedied by selecting an appropriate string instead of the date.
% AUTHOR: Kambadur Ananthamurthy
% Run this function to collect outputs from independent jobs and
% consolidate them into one file.
% date: Job Date
% cRun: Harvest Number

function consolidateBatch(date, cRun)

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
cData.methodA = [];
cData.methodB = [];
cData.methodC = [];
cData.methodD = [];
cData.methodE = [];

for job = 1:length(params)
    %fprintf('Parsing output from job: %i\n', job)
    %     if strcmpi(params(job).methodList, 'A')
    %         cData.methodA(params(job).sdcpStart: params(job).sdcpEnd) = harvestAnalyzedData(db, params(job));
    %     elseif strcmpi(params(job).methodList, 'B')
    %         cData.methodB(params(job).sdcpStart: params(job).sdcpEnd) = harvestAnalyzedData(db, params(job));
    %     elseif strcmpi(params(job).methodList, 'C')
    %         cData.methodC(params(job).sdcpStart: params(job).sdcpEnd) = harvestAnalyzedData(db, params(job));
    %     elseif strcmpi(params(job).methodList, 'D')
    %         cData.methodD(params(job).sdcpStart: params(job).sdcpEnd) = harvestAnalyzedData(db, params(job));
    %     elseif strcmpi(params(job).methodList, 'E')
    %         cData.methodE(params(job).sdcpStart: params(job).sdcpEnd) = harvestAnalyzedData(db, params(job));
    %     else
    %     end
    if strcmpi(params(job).methodList, 'A')
        cData.methodA = harvestAnalyzedData(db, params(job));
    elseif strcmpi(params(job).methodList, 'B')
        cData.methodB = harvestAnalyzedData(db, params(job));
    elseif strcmpi(params(job).methodList, 'C')
        cData.methodC = harvestAnalyzedData(db, params(job));
    elseif strcmpi(params(job).methodList, 'D')
        cData.methodD = harvestAnalyzedData(db, params(job));
    elseif strcmpi(params(job).methodList, 'E')
        cData.methodE = harvestAnalyzedData(db, params(job));
    else
    end
end

filename = [db.mouseName '_' db.date '_synthDataAnalysis_' num2str(date) '_cRun' num2str(cRun) '_cData.mat' ];
fullPath4Save = strcat(saveFolder, filename);

disp('Saving everything ...')
save(fullPath4Save, 'cData', '-v7.3')
%save(fullPath4Save, 'cData', '-v7')
disp('... done!')

%Information about new file
h5info(filename, saveFolder)
h5disp(filename, saveFolder)

toc
disp('All done!')

end