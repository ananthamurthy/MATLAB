option = 1;
finish = 'n';
while strcmpi(finish, 'n')
    finish = input('Finish? y/n: ', 's');
    
    figure
    clf
%     imagesc(((score(:, option) * coeff(:, option)') + mu)')
%     colorbar
%     colormap('jet')
%     title('Data - First 3 PCs', ...
%         'FontSize', 15, ...
%         'FontWeight','bold')
%     xlabel('Observations', ...
%         'FontSize', 15, ...
%         'FontWeight', 'bold')
%     ylabel('Principal Components', ...
%         'FontSize', 15, ...
%         'FontWeight', 'bold')
%     set(gca, 'FontSize', 15)
    if ~strcmpi(finish, 'y')
        option = input('Enter a PC option: ');
    end
end