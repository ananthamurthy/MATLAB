%Persistent vs sequential activity

per = zeros(6,3);
seq = zeros(6,6);

per(2,:) = 1;
per(4,:) = 1;

for cell = 1:size(seq)
    seq(cell,cell) = 1;
end

fontSize = 16;
figure(1)
imagesc(per)
% title('Persistent activity', ...
%     'FontSize', fontSize+20,...
%     'FontWeight', 'bold')
xlabel('Time', ...
    'FontSize', fontSize)
ylabel('Cells', ...
    'FontSize', fontSize)
xticks(1:size(per,2))
colormap('jet')
z = colorbar;
ylabel(z,'Cell Activity (%)', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
set(z,'YTick',[0, 1])
set(z,'YTickLabel',({'0', '100'}))
set(gca,'FontSize', fontSize)

figure(2)
imagesc(seq)
% title('Sequential activity', ...
%     'FontSize', fontSize+20,...
%     'FontWeight', 'bold')
xlabel('Time', ...
    'FontSize', fontSize)
ylabel('Cells', ...
    'FontSize', fontSize)
xticks(1:size(seq,2))
colormap('jet')
z = colorbar;
ylabel(z,'Cell Activity (%)', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
caxis([0 1])
set(z,'YTick',[0, 1])
set(z,'YTickLabel',({'0', '100'}))
set(gca,'FontSize', fontSize)