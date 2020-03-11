function Q = developQ(params4Q)

Q = zeros(params4Q.nTotalCells, 1);
for cell = 1:params4Q.nTotalCells
    Q(cell) = (params4Q.hitTrialPercent(cell) * params4Q.eventAmplificationFactor)/((((params4Q.actualEventWidth(cell, 1) + params4Q.actualEventWidth(cell, 2))/2) + params4Q.imprecisionFWHM) * params4Q.noisePercent);
end