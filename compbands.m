function compbands(listname,measure,bandidxs)

for b = 1:length(bandidxs)
    [testdata(:,b),grp,v2idx] = testmeasure(listname,measure,bandidxs(b));
    fprintf('Band %d mean = %.2f\n\n',bandidxs(b),...
        mean(testdata((grp == 0 | grp == 1) & ~v2idx,b)));
end

testdata = testdata((grp == 0 | grp == 1) & ~v2idx,:);
[pval,~,stats] = ranksum(testdata(:,1),testdata(:,2));
fprintf('Ranksum U = %.2f, p = %.3f\n', stats.ranksum,pval);

[h,p] = ttest(testdata(:,1)-testdata(:,2))
end