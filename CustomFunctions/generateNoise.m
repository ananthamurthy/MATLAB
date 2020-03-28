function noiseComponent = generateNoise(maxSignal, noise, noisePercent, nFrames, ceil2zero)

%Preallocation
noiseComponent = zeros(1, nFrames);

s = floor((noisePercent/100) * maxSignal);

if strcmpi(noise, 'gaussian')
    for frame = 1:nFrames
        noiseComponent(1, frame) = s .* randn();
    end
else
    %error('Unable to identify noise case')
end

if ceil2zero
    noiseComponent(noiseComponent < 0) = 0;
end

end