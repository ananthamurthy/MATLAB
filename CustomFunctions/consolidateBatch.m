% AUTHOR: Kambadur Ananthamurthy
% Here, 'date' refers to the date the batch analysis jobs were launched
% Doubt I'll launch multiple batch analyses on the same day, but this can
% be remedied by selecting an appropriate string instead of the date.

function consolidateBatch(date)

setupHarvestParamsOnServer
saveDirec = strcat(HOME_DIR, 'Work/Analysis/Imaging/');
%saveDirec = strcat('/Users/ananth/Desktop/', 'Work/Analysis/Imaging/');
saveFolder = strcat(saveDirec, db.mouseName, '/', db.date, '/');


for job = 1:length(params)
    cData = harvestAnalyzedData(db, params(exp));
end

save([saveFolder db.mouseName '_' db.date '_batch' num2str(date) '_cData.mat' ], 'cData', '-v7.3')
end