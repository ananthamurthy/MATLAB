%Trial Averaged Data
A = squeeze(mean(dfbf_sigOnly,2));
B = squeeze(mean(dfbf_sigOnly_smooth,2));

figure(1)
subplot(1,2,1)
imagesc(A)
colormap('hot')
title('Significant-Only Data')
xlabel('Frames')
ylabel('Unsorted Cells')
set(gca,'FontSize', 20)

subplot(1,2,2)
imagesc(B)
colormap('hot')
title('Smoothed Data')
xlabel('Frames')
ylabel('Unsorted Cells')
set(gca,'FontSize', 20)
