function testmeasures(measure)

bands = {
    'Delta'
    'Theta'
    'Alpha'
    'Beta'
    'Gamma'
    };

selectbands = [1 2 3];

for bandidx = 1:length(selectbands)
    [~,~,~,~,pvals(bandidx),stats(bandidx)] = testmeasure('allsubj',measure,selectbands(bandidx));
    fprintf('\n');
end

pvals = bonf_holm(pvals);

for bandidx = 1:length(selectbands)
    fprintf('%s band %s: t(%.1f) = %.2f, corr. p = %.3f.\n',bands{selectbands(bandidx)},measure,stats(bandidx).df,stats(bandidx).tstat,pvals(bandidx));
end
