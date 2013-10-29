function plotmeangraph(listname,conntype,bandidx)

loadpaths

load(sprintf('%s/%s/alldata_%s_%s.mat',filepath,conntype,listname,conntype));
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

grp = grp(~v2idx);
allcoh = allcoh(~v2idx,:,:,:,:);

groups = unique(grp);

    for g = 1:length(groups)
%         groupcoh = squeeze(mean(mean(allcoh(grp == groups(g),bandidx,:,:,:),3),1));
        groupcoh = squeeze(mean(allcoh(grp == groups(g),bandidx,:,:),1));
        plotgraph(groupcoh,sortedlocs,'plotqt',0.95,'legend','off','plotinter','off');
        set(gcf,'Name',sprintf('group %s: %s band',grouplist{g},bands{bandidx}));
        export_fig(gcf,sprintf('figures/meangraph_%s_%s.tif',grouplist{g},bands{bandidx}));
        close(gcf);
    end