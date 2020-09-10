function Q = developQ(params4Q)

Q = zeros(params4Q.nCells, 1);

for cell = 1:params4Q.nCells
    
    htp = params4Q.hitTrialPercent(cell);
    a = params4Q.alpha;
    np = params4Q.noisePercent;
    eaf = params4Q.eventAmplificationFactor;
    b = params4Q.beta;
    aew = params4Q.allEventWidths(cell, :);
    ht = find(params4Q.hitTrials(cell, :));
    g = params4Q.gamma;
    p = params4Q.pad(cell, :);
    sw = params4Q.stimulusWindow;
    sdAEW = std(aew(ht)); %Only Hit Trials
    mAEW = mean(aew(ht)); %Only Hit Trials
    
    Q(cell) = (htp/100) * exp(-1 * (((a * np)/(100 * eaf)) + ((b * sdAEW)/mAEW) + ((g * std(p))/sw)));
    
    %fprintf('All event widths for cell %i :\n', cell)
    %disp(aew)
    %disp(length(aew))
    %fprintf('Std Dev: %d\n', sdAEW)
    %fprintf('Mean: %d\n', mAEW)
    %fprintf('Fano Factor: %d\n', sdAEW/mAEW)
    
end