function plotmeangraph(listname,conntype,bandidx)

loadpaths

load(sprintf('%s/%s/alldata_%s_%s.mat',filepath,conntype,listname,conntype));
load chanlist

plotqt = 0.7;

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

grouplist = {
    'p0311_restingstate1'
    'p0411_restingstate1'
    'p1611_restingstate'
    };

group = 1:length(grouplist);

for g = group
%     groupcoh(g,:,:) = squeeze(mean(allcoh(grp == groups(g),bandidx,:,:),1));
    groupcoh(g,:,:) = squeeze(mean(allcoh(strcmp(grouplist{g},subjlist(:,1)),bandidx,:,:),1));
    meancohmat = threshold_proportional(squeeze(groupcoh(g,:,:)),1-plotqt);
    for c = 1:size(meancohmat,1)
        groupdeg(g,c) = sum(meancohmat(c,:))/(size(meancohmat,2)-1);
    end
end

erange = [min(groupcoh(:)) max(groupcoh(:))];
vrange = [min(groupdeg(:)) max(groupdeg(:))];

for g = group
    minfo = plotgraph(squeeze(groupcoh(g,:,:)),sortedlocs,'plotqt',plotqt,'escale',erange,'vscale',vrange,'legend','off','plotinter','off');
    fprintf('group %s: %s band - number of modules: %d\n',grouplist{g},bands{bandidx},length(unique(minfo)));
    set(gcf,'Name',sprintf('group %s: %s band',grouplist{g},bands{bandidx}));
    export_fig(gcf,sprintf('figures/meangraph_%s_%s.tif',grouplist{g},bands{bandidx}));
    close(gcf);
end
