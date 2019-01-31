% AUTHOR - Kambadur Ananthmurthy
function PSTH = getPSTH(Data, delta, skipFrames)
%Develop PSTH

fprintf('Now, developing PSTH for these %i cells ...\n', size(Data,1))
%disp('Now, developing PSTH ...')

%NOTE: 'Data' is organized as cells, trials, frames
%A = zeros(1,size(Data,3));
%netFrames = (size(Data,3)-(length(skipFrames)+2));
nbins = size(Data,3)/delta;
X = zeros(size(Data,1), size(Data,2), nbins);
PSTH = zeros(size(Data,1), nbins);

for cell = 1:size(Data,1)
    for trial = 1:size(Data,2)
        %fprintf('Trial: %i\n', trial)
        %Get rid of CS artifact
        Data(cell, trial, skipFrames) = 0;
        %Get rid of 1st and last frames
        %Data(cell,trial,1) = [];
        %Data(cell,trial,end) = [];
        %Now the total number of frames/delta should be an integer (assuming delta = 3)
        
        bin = 1;
        trialAUCs = zeros(nbins,1);
        for frame = 1:delta:size(Data,3)
            %fprintf('Frame: %i\n', frame)
            windowAUC = trapz(Data(cell, trial, frame:(frame+delta-1)));
            trialAUCs(bin) = windowAUC;
            clear windowSum
            bin = bin + 1;
        end
        %check if trialSums has the same length as nbins
        %fprintf('Length of trialSums is %i \n', length(trialSums))
        if length(trialAUCs) ~= nbins
            error('Length of trialSums ~= nbins for trial %i', trial)
        end
        X(cell, trial, :) = trialAUCs;
    end
    PSTH = squeeze(sum(X,2));
    
    if (mod(cell, 10) == 0) && cell ~= size(Data,1)
        fprintf('... %i cells considered ...\n', cell)
    end
    
end
disp('... done!')