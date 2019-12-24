% Comparing a list of time cells populated by two different methods
nTotalCells = 135;

%My Temporal Information metric
load('/Users/ananth/Desktop/Work/Analysis/Imaging/M26/20180514/M26_20180514_C.mat')
target = nan(1,nTotalCells);
target(iTimeCells) = 1; %Loaded previously from saved data

%Mehrab's Ridge to Background Ratio
selection = nan(6,nTotalCells);
count = 1;
for threshold = 0.95:0.01:1
    selection(count,:) = rrb_ratio_vec_final > threshold;
    selection(selection == 0) = nan;
    count = count + 1;
end

fig1 = figure(1);
set(fig1,'Position',[10,300,2000,300])
plot(selection(1,:)*1, 'b*', 'MarkerSize', 20)
hold on
plot(selection(2,:)*2, 'g*', 'MarkerSize', 20)
hold on
plot(selection(3,:)*3, 'r*', 'MarkerSize', 20)
hold on
plot(selection(4,:)*4, 'c*', 'MarkerSize', 20)
hold on
plot(selection(5,:)*5, 'm*', 'MarkerSize', 20)
hold on
plot(selection(6,:)*6, 'y*', 'MarkerSize', 20)
hold on
plot(target*1, 'ko', 'MarkerSize', 20)
hold on
plot(target*2, 'ko', 'MarkerSize', 20)
hold on
plot(target*3, 'ko', 'MarkerSize', 20)
hold on
plot(target*4, 'ko', 'MarkerSize', 20)
hold on
plot(target*5, 'ko', 'MarkerSize', 20)
hold on
plot(target*6, 'ko', 'MarkerSize', 20)
yticks([1 2 3 4 5 6]);

%Number of common time cells
common = zeros(size(selection));
for count = 1:6
    common(target == selection(count,:)) = 1;
end


% figure(2)
% subplot(2,3,1)
% plot(selection(1,:), 'blue*', 'MarkerSize', 20)
% hold on
% plot(target, 'redo', 'MarkerSize', 20)
% 
% subplot(2,3,2)
% plot(selection(2,:), 'blue*', 'MarkerSize', 20)
% hold on
% plot(target, 'redo', 'MarkerSize', 20)
% 
% subplot(2,3,3)
% plot(selection(3,:), 'blue*', 'MarkerSize', 20)
% hold on
% plot(target, 'redo', 'MarkerSize', 20)
% 
% subplot(2,3,4)
% plot(selection(4,:), 'blue*', 'MarkerSize', 20)
% hold on
% plot(target, 'redo', 'MarkerSize', 20)
% 
% subplot(2,3,5)
% plot(selection(5,:), 'blue*', 'MarkerSize', 20)
% hold on
% plot(target, 'redo', 'MarkerSize', 20)
% 
% subplot(2,3,6)
% plot(selection(6,:), 'blue*', 'MarkerSize', 20)
% hold on
% plot(target, 'redo', 'MarkerSize', 20)