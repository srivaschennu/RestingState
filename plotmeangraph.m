function plotmeangraph(listname,bandidx,groupidx)

if ~exist('plotqt','var') || isempty(plotqt)
    plotqt = 0.95;
end

load(sprintf('alldata_%s.mat',listname));
load chanlist

fontsize = 16;

bands = {
    'delta'
    'theta'
    'alpha'
    'beta'
    'gamma'
    };

grp(grp == 2) = 1;
grp(grp == 3) = 2;

groupcoh = squeeze(mean(allcoh(grp == groupidx,bandidx,:,:),1));
plotgraph(groupcoh,chanlocs,plotqt);
set(gcf,'Name',sprintf('group %d: %s band',groupidx,bands{bandidx}));