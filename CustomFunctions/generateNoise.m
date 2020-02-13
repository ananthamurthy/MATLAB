function noiseComponent = generateNoise(event, noise, noisePercent, nFrames)

%Preallocation
noiseComponent = zeros(nFrames,1);

s = (noisePercent/100) * max(event);

if strcmpi(noise, 'gaussian')
    for frame = 1:nFrames
        noiseComponent(frame) = s .* randn();
    end
else
    %error('Unable to identify noise case')
end
end