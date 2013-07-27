function plotmeangraph(listname)

load(sprintf('alldata_%s.mat',listname));
load chanlist

v1idx = zeros(size(subjlist,1),1);
for s = 1:size(subjlist,1)
    if ~isempty(subjlist{s,5})
        v1idx(s) = find(strcmp(subjlist{s,5},subjlist(:,1)));
    end
end
v2idx = logical(v1idx);
v1idx = nonzeros(v1idx);

bands = {
    'delta'
    'theta'
    'alpha'
    'beta'
    'gamma'
    };

grouplist = {
    'VS'
    'MCS'
    'Control'
    };

grp(grp == 2) = 1;
grp(grp == 3) = 2;

grp = grp(~v2idx);
allcoh = allcoh(~v2idx,:,:,:,:);

groups = unique(grp);

for bandidx = 1:size(allcoh,2)
    for g = 1:length(groups)
        groupcoh = squeeze(mean(mean(allcoh(grp == groups(g),bandidx,:,:,:),3),1));
        plotgraph(groupcoh,chanlocs,0.85);
        set(gcf,'Name',sprintf('group %s: %s band',grouplist{g},bands{bandidx}));
        saveas(gcf,sprintf('figures/meangraph_%s_%s.jpg',grouplist{g},bands{bandidx}));
        close(gcf);
    end
end