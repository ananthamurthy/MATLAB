%Add the effect of "imprecision"

%Preallocation, for speed
imprecisionFWHM = 8;
nCounts = 10000;
pad = zeros(nCounts,1);

%Uniform Distribution
for i = 1:nCounts
    pad(i) = randi([-1*(imprecisionFWHM/2), (imprecisionFWHM/2)]);
end
figure(1)
subplot(1,2,1)
hist(pad)
title(['Uniform Distribution with FWHM: ' num2str(imprecisionFWHM)])
ylabel('Counts')

%NOTE: "pad" will automatically be updated, below; no need to preallocate
%Normal Distribution
for i = 1:nCounts
    stddev = imprecisionFWHM/(2*sqrt(2*log(2))); %NOTE: In MATLAB, log() performs a natural log
    pad(i) = round(normrnd(0, stddev)); %Setting mean = 0; rounding to produce an integer
end
subplot(1,2,2)
hist(pad)
title(['Normal Distribution with FWHM: ' num2str(imprecisionFWHM)])
ylabel('Counts')