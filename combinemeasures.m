function combinemeasures(listname,conntype,measures,bandidx)

for m = 1:length(measures)
    [testdata(:,m),grp,crs,tennis,v2idx] = testmeasure(listname,conntype,measures{m},bandidx);
end

testdata = testdata(~v2idx,:);

%% test patients vs controls group difference
% [pval,~,stats] = ranksum(testdata(grp == 2),testdata((grp == 0 | grp == 1) & ~v2idx));
[~,pval1,~,stats1] = ttest2(testdata(grp == 2),testdata((grp == 0 | grp == 1) & ~v2idx),[],[],'unequal');
fprintf('%s: Ctrl %.2f, Pat %.2f, t = %.2f, p = %.3f.\n',...
    measure,mean(testdata(grp == 2)),mean(testdata((grp == 0 | grp == 1) & ~v2idx)),stats1.tstat,pval1);

%% compare vs to mcs patients
[~,pval2,~,stats2] = ttest2(testdata(grp == 1 & ~v2idx),testdata(grp == 0 & ~v2idx),[],[],'unequal');
fprintf('MCS vs. VS: t = %.2f, p = %.3f.\n',stats2.tstat,pval2);

datatable = sortrows(cat(2,...
    crs((grp == 0 | grp == 1) & ~v2idx),...
    testdata((grp == 0 | grp == 1) & ~v2idx),...
    tennis((grp == 0 | grp == 1) & ~v2idx),...
    grp((grp == 0 | grp == 1) & ~v2idx)),...
    2);

%     powerdata((grp == 0 | grp == 1) & ~v2idx)),...
mdl = LinearModel.fit(datatable(:,2),datatable(:,1),'RobustOpts','on');
fprintf('%s: R2 = %.2f, p = %.3f.\n',measure,mdl.Rsquared.Adjusted,doftest(mdl));
exmdl = LinearModel.fit(datatable(:,2),datatable(:,1),'RobustOpts','on','Exclude',find(datatable(:,4) == 0));
fprintf('%s (excl): R2 = %.2f, p = %.3f.\n',measure,exmdl.Rsquared.Adjusted,doftest(exmdl));

% test with power covariate
% exmdl = LinearModel.fit(datatable(:,[2 5]),datatable(:,1),'RobustOpts','on','Exclude',find(datatable(:,4) == 0 & datatable(:,3) == 1))
% fprintf('%s %s (excl with power): R2 = %.2f, p = %.3f.\n',bands{bandidx},measure,exmdl.Rsquared.Adjusted,doftest(exmdl));

% [rho, pval] = corr(datatable(:,1),datatable(:,2),'type','spearman');
% fprintf('Spearman rho = %.2f, p = %.3f.\n',rho,pval);

figure('Color','white');
hold all
%VS
legendoff(scatter(datatable(datatable(:,4) == 0 & datatable(:,3) == 0,2), ...
    datatable(datatable(:,4) == 0 & datatable(:,3) == 0,1),'red'));
legendoff(scatter(datatable(datatable(:,4) == 0 & datatable(:,3) == 1,2), ...
    datatable(datatable(:,4) == 0 & datatable(:,3) == 1,1),'red','filled'));
% legendoff(scatter(datatable(datatable(:,4) == 0,2),datatable(datatable(:,4) == 0,1),'red','filled'));
%MCS
legendoff(scatter(datatable(datatable(:,4) == 1 & datatable(:,3) == 0,2), ...
    datatable(datatable(:,4) == 1 & datatable(:,3) == 0,1),'blue'));
legendoff(scatter(datatable(datatable(:,4) == 1 & datatable(:,3) == 1,2), ...
    datatable(datatable(:,4) == 1 & datatable(:,3) == 1,1),'blue','filled'));
% legendoff(scatter(datatable(datatable(:,4) == 1,2),datatable(datatable(:,4) == 1,1),'blue','filled'));

end