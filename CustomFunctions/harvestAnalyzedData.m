function cData = harvestAnalyzedData(db, params)
filename = sprintf('%s_%s_synthDataAnalysis_method%s_batch_%i-%i.mat', ...
    db.mouseName, ...
    db.date, ...
    params(job).methodList, ...
    params(job).sdcpStart, ...
    params(job).sdcpEnd);
direc = strcat(params(job).fileLocation, filename);

if strlength(params(job).methodList) == 1
    varName = strcat('m', params(job).methodList, 'Output_batch'); %string
else
    methods = split(params(job).methodList, '-');
    for choice = 1:size(methods,1)
        varName = strcat('m', methods(choice, 1), 'Output_batch'); %string
    end
end
fprintf('Harvesting %s ...\n', direc)
cData(params(job).sdcpStart:params(job).sdcpEnd) = load(direc, varName);
end