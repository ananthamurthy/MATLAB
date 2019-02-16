% AUTHOR - Kambadur Ananthmurthy
function [smoothedData, gaussianKernel] = doGaussianSmoothing(Data, nSamples)
    gaussianKernel = gausswin(nSamples);
    %wvtool(gaussianKernel)
    % Data is organized as cells, trials, frames.
    smoothedData = zeros(size(Data,1), size(Data,2), (size(Data,3)+nSamples-1));
    for cell = 1:size(Data,1)
        for trial = 1:size(Data,2)
            originalSignal = squeeze(Data(cell, trial, :));
            smoothedData(cell,trial,:) = conv(originalSignal, gaussianKernel);
        end
    end
end