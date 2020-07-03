function cData = harvestAnalyzedData(db, params)
filename = sprintf('%s_%s_synthDataAnalysis_method%s_batch_%i-%i.mat', ...
    db.mouseName, ...
    db.date, ...
    params.methodList, ...
    params.sdcpStart, ...
    params.sdcpEnd);
direc = strcat(params.fileLocation, filename);

if strlength(params.methodList) == 1
    varName = strcat('m', params.methodList, 'Output_batch'); %string
else
    methods = split(params.methodList, '-');
    for choice = 1:size(methods,1)
        varName = strcat('m', methods(choice, 1), 'Output_batch'); %string
    end
end
fprintf('Harvesting %s ...\n', direc)
cData(params.sdcpStart:params.sdcpEnd) = load(direc, varName);
end