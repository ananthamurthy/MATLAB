function [Q, ex1, ex2, ex3] = developQ(params4Q)

Q = zeros(params4Q.nCells, 1);

ex1 = zeros(params4Q.nCells, 1);
ex2 = zeros(params4Q.nCells, 1);
ex3 = zeros(params4Q.nCells, 1);

for cell = 1:params4Q.nCells
    
    Q(cell) = (params4Q.hitTrialPercent(cell)/100) ...
        * exp(-1 * (((params4Q.alpha * params4Q.noisePercent)/(100*params4Q.eventAmplificationFactor)) ...
        + (1/mean(params4Q.allEventWidths(cell, :))) * ((params4Q.beta * std(params4Q.allEventWidths(cell, :))) + (params4Q.gamma * params4Q.imprecisionFWHM))));
    
    ex1(cell) = ((params4Q.noisePercent)/(100*params4Q.eventAmplificationFactor));
    ex2(cell) = std(params4Q.allEventWidths(cell, :))/mean(params4Q.allEventWidths(cell, :));
    ex3(cell) = params4Q.imprecisionFWHM/mean(params4Q.allEventWidths(cell, :));
end