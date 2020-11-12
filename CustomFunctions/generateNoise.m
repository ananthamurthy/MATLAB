function noiseComponent = generateNoise(maxSignal, noise, noisePercent, nFrames, ceil2zero)

%Preallocation
noiseComponent = zeros(1, nFrames);

s = (noisePercent/100) * maxSignal;

if strcmpi(noise, 'gaussian')
    noiseComponent(1, :) = s .* randn(1, nFrames);
else
    %error('Unable to identify noise case')
end

if ceil2zero
    noiseComponent(noiseComponent < 0) = 0;
end

end