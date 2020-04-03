function [seqAnalysisOutput] = runSeqBasedTCAnalysis(DATA, seqAnalysisInput)

nCells = size(DATA, 1);
nTrials = size(DATA, 2);
nFrames = size(DATA, 3);

%Gaussian Smoothing
if seqAnalysisInput.gaussianSmoothing
    [smoothedData, ~] = doGaussianSmoothing(DATA, seqAnalysisInput.nSamples);
    %[smoothedDATA, gaussianKernel] = doGaussianSmoothing2D(DATA_2D, nSamples);
end

%Convert Data to 2D
DATA_2D = zeros(nCells, nTrials*nFrames);
for cell = 1:nCells
    for trial = 1:nTrials
        count = trial - 1;
        % All trials
        if seqAnalysisInput.gaussianSmoothing
            DATA_2D(cell,(((count*nFrames)+1):(count*nFrames)+nFrames)) = smoothedData(cell, trial, :);
        else
            DATA_2D(cell,(((count*nFrames)+1):(count*nFrames)+nFrames)) = DATA(cell, trial, :);
        end
    end
end

%Remember to transpose the 2D data to rows - allFrames (observations), and columns - Cells (variables)
X = DATA_2D';

% PCA
%[coeff, score, latent, tsquared, explained, mu] = pca(X);
[coeff, score, ~, ~, explained, mu] = pca(X);

%RecreatedDATA = (score * coeff') + mu;
if seqAnalysisInput.automatic
    %Add condition to exclude tsquared values >1? Skipping
    %Add condition to only include eigenvalues >1? Skipping
    
    %Select the index of the PC that explains the highest percentage of the total variance
    [~, selectedIndex] = max(explained);
    
else %Manual mode
    %Make a gui? Keeping things simple
    selectedIndex = 1;
    finish = 'n';
    while strcmpi(finish, 'n')
        figure
        set(gcf,'Visible','on')
        clf
        imagesc(((score(:, selectedIndex) * coeff(:, selectedIndex)') + mu)'*100)
        title(sprintf('Data | PC: %i', selectedIndex), ...
            'FontSize', 15, ...
            'FontWeight','bold')
        xlabel('Observations', ...
            'FontSize', 15, ...
            'FontWeight', 'bold')
        ylabel('Cells', ...
            'FontSize', 15, ...
            'FontWeight', 'bold')
        z = colorbar;
        colormap('jet')
        ylabel(z,'dF/F (%)', ...
        'FontSize', 15, ...
        'FontWeight', 'bold')
        set(gca, 'FontSize', 15)
        
        finish = input('Finish? y/n: ', 's');
        
        if ~strcmpi(finish, 'y')
            selectedIndex = input('Enter a PC option: ');
        end
    end
    set(gcf,'Visible','off')
end


seqAnalysisOutput.coeff = coeff;
seqAnalysisOutput.score = score;
seqAnalysisOutput.explained = explained;
seqAnalysisOutput.mu = mu;

seqAnalysisOutput.recDATA = ((score(:, selectedIndex) * coeff(selectedIndex, :)) + mu)';

%Take derivative of Selected Principal Component
seqAnalysisOutput.selectedPC = squeeze(coeff(:, selectedIndex));
size(seqAnalysisOutput.selectedPC);
dx = seqAnalysisOutput.selectedPC(2:end) - seqAnalysisOutput.selectedPC(1:end-1);
dt = seqAnalysisInput.timeVector(2:end) - seqAnalysisInput.timeVector(1:end-1);
seqAnalysisOutput.d1 = dx./dt;

%Cross-correlate with the activity of each cell to get Quality (Q)

%seqAnalysisOutput.Q = xcorr(seqAnalysisOutput.d1, seqAnalysisOutput.selectedPC);

%seqAnalysisOutput.T = peakTimeBin;
%seqAnalysisOutput.timeCells = timeCells;


end