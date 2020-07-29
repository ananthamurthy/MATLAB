function jobData = harvestAnalyzedData(db, params)

if params.trim
    filename = sprintf('%s_%s_synthDataAnalysis_%i_gRun%i_method%s_batch_%i-%i_trimRun%i_trimmed.mat', ...
        db.mouseName, ...
        db.date, ...
        params.date, ...
        params.gRun, ...
        params.methodList, ...
        params.sdcpStart, ...
        params.sdcpEnd, ...
        params.trimRun);
else
        filename = sprintf('%s_%s_synthDataAnalysis_%i_gRun%i_method%s_batch_%i-%i.mat', ...
        db.mouseName, ...
        db.date, ...
        params.date, ...
        params.gRun, ...
        params.methodList, ...
        params.sdcpStart, ...
        params.sdcpEnd);
end

fullDirec4Read = strcat(params.fileLocation, filename);

fprintf('Harvesting %s ...\n', filename)
jobData = load(fullDirec4Read);
disp(' ... done!')

end