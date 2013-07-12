function plotmi(bandidx)

load graphdata_allsubj_pli

groups = unique(grp);

grp(grp == 2) = 1;
grp(grp == 3) = 2;

mutinfo = graph{end,3};

figure; hold all
for g = 1:length(groups)
    errorbar(1-tvals,squeeze(mean(mean(mutinfo(grp == groups(g),grp == groups(g),3,:),1),2)),...
        squeeze(std(mean(mutinfo(grp == groups(g),grp == groups(g),3,:),1),[],2))/sqrt(size(mutinfo,2)),...
        'DisplayName',num2str(groups(g)));
end
set(gca,'XLim',1-[tvals(1) tvals(end)],'YLim',[0 0.18]);
legend('show');