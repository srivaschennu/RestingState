function plotpower

load alldata_allsubj

grp(grp == 2) = 1;
grp(grp == 3) = 2;

groups = unique(grp);
plotvals = zeros(size(bandpower,2),length(groups));
for g = 1:length(groups)
    for bandidx = 1:size(bandpower,2)
        plotvals(bandidx,g) = mean(mean(bandpower(grp == groups(g),bandidx,:),3),1);
    end
    
end
figure('Color','white');
bar(plotvals,'grouped');
legend(num2cell(num2str(groups))');