function plotpower(listname)

load(sprintf('alldata_%s.mat',listname));
load chanlist

bands = {
    'delta'
    'theta'
    'alpha'
    'beta'
    'gamma'
    };

grp(grp == 2) = 1;
grp(grp == 3) = 2;

groups = unique(grp);
plotvals = zeros(size(bandpower,2),length(groups));
figure('Color','white');
p = 1;
for g = 1:length(groups)
    for bandidx = 1:size(bandpower,2)
        subplot(length(groups),size(bandpower,2),p); hold all;
        topoplot(squeeze(mean(bandpower(grp == groups(g),bandidx,:),1)),chanlocs); colorbar
        if g == 1
            title(bands{bandidx});
        end
        if bandidx == 1
            text(0,0,num2str(groups(g)));
        end
        p = p+1;
        plotvals(bandidx,g) = mean(mean(bandpower(grp == groups(g),bandidx,:),3),1);
    end
    
end
figure('Color','white');
bar(plotvals,'grouped');
legend(num2cell(num2str(groups))');