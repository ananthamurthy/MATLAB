function [cellRastor, cellFrequency, timeLockedCells, importantTrials] = getFreqBasedTimeCellList(Data, threshold, skipFrames)
%Develop Ca activity Frequency using threshold

fprintf(['Total cells: %i\n' size(Data,1)])
disp('Now, checking for time-locked cells based on Event Frequency ...')
fprintf('Threshold: %i trials\n', threshold)

%NOTE: 'Data' is organized as cells, trials, frames
%Preallocation
Data_mean = zeros(size(Data,1),size(Data,2));
Data_std = zeros(size(Data,1),size(Data,2));
%A = zeros(1,size(Data,3));
cellRastor = zeros(size(Data));
importantTrials = zeros(size(Data,1),size(Data,2));
cellFrequency = zeros(size(Data,1),size(Data,3));
timeLockedCells = zeros(size(Data,1),1); %Important to initialize with "0"

for cell = 1:size(Data,1)
    %Develop significant only traces
    %Not binarizing in the first step to allow analog detection
    Data_sigOnly = Data;
    for trial = 1:size(Data,2)
        Data_mean(cell,trial) = mean(squeeze(squeeze(Data(cell,trial,:))));
        Data_std(cell,trial) = std(squeeze(squeeze(Data(cell,trial,:))));
        %floor any value less than mean + 2*stddev to 0
        A = squeeze(squeeze(Data(cell,trial,:)));
        A(A<(Data_mean(cell,trial) + 2*(Data_std(cell,trial)))) = 0;
        Data_sigOnly(cell,trial,:) = A;
        
        %Get rid of CS artifact
        Data_sigOnly(cell,trial,skipFrames) = 0;
        
        if ~isempty(find(Data_sigOnly(cell,trial,:),1))
            importantTrials(cell,trial) = 1;
        end
        
        for frame = 1:size(Data,3)
            if Data_sigOnly(cell, trial, frame) > 0
                cellRastor(cell, trial, frame) = 1; % Rastor plot
                cellFrequency(cell,frame) = cellFrequency(cell,frame)+1; %Frequency matrix
            end
        end
    end
    
    if (mod(cell, 10) == 0) && cell ~= size(Data,1)
        fprintf('... %i cells checked ...\n', cell)
    end
    
    %Identify time-locked cells based on activity on more than threshold
    %number of trials
    if ~isempty(find((cellFrequency(cell,:) > threshold),1))
        timeLockedCells(cell) = 1;
    end
end
fprintf('%i time-locked cells found!\n', length(find(timeLockedCells)))
disp('... done!')