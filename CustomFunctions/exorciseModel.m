function holyData = exorciseModel(db, params)
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
holyData(params.sdcpStart:params.sdcpEnd) = load(direc, varName);
fprintf('Trimming %s ...\n', filename)

for dataset = 1:length(holyData)
    if strcmpi(params.methodList, 'B')
        if isfield(holyData(dataset).mBOutput_batch, 'Mdl')
            try
                holyData = rmfield(holyData(dataset).mBOutput_batch, 'Mdl');
            catch
                fprintf('Method: %s', params.methodList)
                fprintf('Dataset: %i', dataset)
                fieldnames(holyData(dataset).mBOutput_batch)
                error('Unable to delete "Mdl"')
            end
        else
            disp('Skipping to next dataset ...')
        end
    elseif strcmpi(params.methodList, 'E')
        if isfield(holyData(dataset).mEOutput_batch, 'SVMModel')
            try
                holyData = rmfield(holyData(dataset).mEOutput_batch, 'SVMModel');
            catch
                fprintf('Method: %s', params.methodList)
                fprintf('Dataset: %i', dataset)
                fieldnames(holyData(dataset).mEOutput_batch)
                error('Unable to delete "SVMModel"')
            end
        else
            disp('Skipping to next dataset ...')
        end
    end
end