%Generate a schematic for trace vs delay conditioning
csLine_trace = zeros(1,100);
csLine_delay = zeros(1,100);
usLine = zeros(1,100);

csLine_trace(20:35) = 1;
csLine_delay(20:75) = 1;
usLine(60:75) = 1;

fig1 = figure(1);
set(fig1, 'Position', [100 100 1500 300])
%trace
subplot(2,2,1)
plot(csLine_trace, 'blue', 'LineWidth', 3)
title('Trace Conditioning', 'FontSize', 20)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
legend('CS')
subplot(2,2,3)
plot(usLine, 'red', 'LineWidth', 3)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
%set(gca,'YTickLabel',{'Off', 'On'});
legend('US')
xlabel('Time', 'FontSize', 20)

subplot(1,2,2)
%delay
subplot(2,2,2)
plot(csLine_delay, 'blue', 'LineWidth', 3)
title('Delay Conditioning', 'FontSize', 20)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
legend('CS')
subplot(2,2,4)
plot(usLine, 'red', 'LineWidth', 3)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
%set(gca,'YTickLabel',{'Off', 'On'});
legend('US')
xlabel('Time', 'FontSize', 20)