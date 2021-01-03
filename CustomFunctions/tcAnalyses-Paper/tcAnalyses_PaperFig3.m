% Time Cell Analysis Paper - "Figure3"
% Written by Kambadur Ananthamurthy
% This code can only be used after the following variables are in the workspace:
% 1. dfbf_2D
% 2. eventLibrary_2D
% 3. sdo

make_db
%Load Calcium Library
HOME_DIR2 = '/Users/ananth/Desktop/';
saveDirec = strcat(HOME_DIR2, 'Work/Analysis/Imaging/');
saveFolder = strcat(saveDirec, db.mouseName, '/', db.date, '/');
disp('Loading existing event library ...')
filepath = strcat(saveFolder, db.mouseName, '_', db.date, '_eventLibrary_2D.mat');
load(filepath)
disp('... done!')

%Load Real Data
realProcessedData = load(strcat(saveFolder, db.mouseName, '_', db.date, '.mat'));
nCells = size(realProcessedData.dfbf, 1);
nTrials = size(realProcessedData.dfbf, 2);
nFrames = size(realProcessedData.dfbf, 3);
dfbf_2D = realProcessedData.dfbf_2D;
fprintf('Total cells: %i\n', nCells)
%% "Real Data"
%fig3 = figure(3);
%set(fig3,'Position',[300,300,1000,800])
%plotdFbyF(db, realProcessedData.dfbf_2D(:,1:(3*db.nFrames)), 'Real Data - First 3 Trials', 'Frame Number', 'Cell Number', figureDetails, 0)
%%
%fig3 = figure(3);
%set(fig3,'Position',[300,300,1000,800])
%plotdFbyF(db, sdo(1).syntheticDATA_2D(:,1:(3*db.nFrames)), 'Synthetic Data - First 3 Trials', 'Frame Number', 'Cell Number', figureDetails, 0)

%% Calcium Library Example
exampleCells = [6, 40, 73];

fig3 = figure(3);
%clf
set(fig3,'Position',[300,300,1200,800])

for i = 1:length(exampleCells)
    cellNum = exampleCells(i);
    nExamples = 5;
    %indices = [15, 27, 40, 44, 46];
    eventIndices = 1:eventLibrary_2D(cellNum).nEvents;
    %disp(eventIndices);
    
    eventList = sort(randperm(length(eventIndices), nExamples));
    disp(eventList)
    
    event = zeros(100, 1);
    
    for example = 1:nExamples
        selectedEventIndex = eventIndices(eventList(example));
        eventStartIndex = eventLibrary_2D(cellNum).eventStartIndices(selectedEventIndex);
        
        %Now, we pick out exactly one event per trial
        event(10:1:(10+eventLibrary_2D(cellNum).eventWidths(selectedEventIndex))) = dfbf_2D(cellNum, eventStartIndex: 1: (eventStartIndex + eventLibrary_2D(cellNum).eventWidths(selectedEventIndex)));
        
        subplot(length(exampleCells), nExamples, (example + nExamples*(i-1)))
        
        if i == 1
            plot(event*100, 'blue')
        elseif i == 2
            plot(event*100, 'magenta')            
        elseif i == 3
            plot(event*100, 'green')
        end
        
        ylim([0 150])
        text(40, 75, sprintf('Event = %i', selectedEventIndex), 'FontSize', 16)
        if example == 1
            ylabel('dF/F (%)', ...
                'FontSize', 16, ...
                'FontWeight', 'bold')
        end
        
        if example == 3 %right in the center
            title(sprintf('Example Calcium Events - Cell %i', cellNum), ...
                'FontSize', 16, ...
                'FontWeight', 'bold')
            xlabel('Frame Number', ...
                'FontSize', 16, ...
                'FontWeight', 'bold')
        end
        set(gca, 'FontSize', 16)
        
        %Reinitialize event
        event = zeros(100, 1);
    end
end
print(['/Users/ananth/Desktop/TCM-March2020/library_cell', num2str(cellNum)], '-dpng')