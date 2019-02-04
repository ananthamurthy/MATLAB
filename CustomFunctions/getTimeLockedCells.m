% AUTHOR - Kambadur Ananthmurthy
function [timeLockedCells, TI] = getTimeLockedCells(PSTH_3D, nShuffles, threshold)
%{
'PSTH_3D' is organized as cells, trials, frames
Area under the curve might not be very revelatory
Here I use Temporal Information (TI), based on Mau et al (Eichenbaum) 2018
%}

%NOTE: 'threshold' is in percentage. Mau et al (Eichenbaum), 2018 uses 99%

%preallocation
timeLockedCells = zeros(size(PSTH_3D,1),1);
TI = zeros(size(PSTH_3D,1),1);
shuffledPSTH_3D = zeros(size(PSTH_3D));

disp('Now, checking for time-locked cells ...')
fprintf('Threshold (in %% of shuffles): %s\n',num2str(threshold))

for cell = 1:size(PSTH_3D,1)
        %fprintf('Cell: %i\n', cell)
        ratio = zeros(nShuffles,1);
        %Non-randomized
        avgPSTH_3D = mean(PSTH_3D(cell,:,:), 2);
        TI(cell) = findTI(avgPSTH_3D);
        
        %Random shuffled - reorder frames for every trial
        TI_rand = zeros(nShuffles,1); %use and throw variable
        for shuffle = 1:nShuffles
            %fprintf('Shuffle No.: %i\n', shuffle)
            for trial = 1:size(PSTH_3D,2)
                %fprintf('Trial No.: %i\n', trial)
                shuffledPSTH_3D(cell, trial, :) = PSTH_3D(cell, trial, squeeze(randperm(size(PSTH_3D,3))));
            end
            avgShuffledPSTH_3D = squeeze(squeeze(mean(shuffledPSTH_3D(cell, :, :),2)));
            TI_rand(shuffle) = findTI(avgShuffledPSTH_3D); %use and throw variable
            ratio(shuffle) = TI(cell)/TI_rand(shuffle);
        end
        comparison = (length(ratio(ratio>1))/length(ratio))*100; % in %
        
        if comparison >= threshold
            timeLockedCells(cell) = 1;
        else
            timeLockedCells(cell) = 0;
        end
    
    if (mod(cell, 10) == 0) && cell ~= size(PSTH_3D,1)
        fprintf('... %i cells checked ...\n', cell)
    end
end
%fprintf('Finally, %i time-locked cells found\n', length(find(timeLockedCells)))
disp('... done!')

