% Time Cell Analysis Paper - "Figure3"
% Written by Kambadur Ananthamurthy
% This code can only be used after the following variables are in the workspace:
% 1. dfbf_2D
% 2. eventLibrary_2D
% 3. sdo

%% "Real Data"
fig3 = figure(3);
set(fig3,'Position',[300,300,1000,800])
plotdFbyF(db, realProcessedData.dfbf_2D(:,1:(3*db.nFrames)), 'Real Data - First 3 Trials', 'Frame Number', 'Cell Number', figureDetails, 0)
%%
fig3 = figure(3);
set(fig3,'Position',[300,300,1000,800])
plotdFbyF(db, sdo(1).syntheticDATA_2D(:,1:(3*db.nFrames)), 'Synthetic Data - First 3 Trials', 'Frame Number', 'Cell Number', figureDetails, 0)

%% Calcium Library Example
% exampleCells = [6, 40, 73];

%cell = exampleCells(i);
cellNum = 73;
nExamples = 5;
%indices = [15, 27, 40, 44, 46];
eventIndices = 1:eventLibrary_2D(cellNum).nEvents;
%disp(eventIndices);

eventList = sort(randperm(length(eventIndices), nExamples));
disp(eventList)

fig3 = figure(3);
clf
set(fig3,'Position',[300,300,1200,350])
event = zeros(100, 1);

for example = 1:nExamples
    selectedEventIndex = eventIndices(eventList(example));
    eventStartIndex = eventLibrary_2D(cellNum).eventStartIndices(selectedEventIndex);
    
    %Now, we pick out exactly one event per trial
    event(10:1:(10+eventLibrary_2D(cellNum).eventWidths(selectedEventIndex))) = dfbf_2D(cellNum, eventStartIndex: 1: (eventStartIndex + eventLibrary_2D(cellNum).eventWidths(selectedEventIndex)));
    
    subplot(1, nExamples, example)
    plot(event*100, 'k')
    ylim([0 150])
    text(40, 75, sprintf('Event = %i', selectedEventIndex), 'FontSize', 16)
    if example == 1
        ylabel('dF/F (%)', ...
            'FontSize', 16, ...
            'FontWeight', 'bold')
    end
    
    if example == 3
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
print(['/Users/ananth/Desktop/TCM-March2020/library_cell', num2str(cellNum)], '-dpng')