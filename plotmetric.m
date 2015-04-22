function plotmetric(basename,listname,conntype,measure,bandidx,varargin)

loadpaths

param = finputcheck(varargin, {
    'ylim', 'real', [], []; ...
    'legend', 'string', {'on','off'}, 'on'; ...
    'plotinfo', 'string', {'on','off'}, 'on'; ...
    'plotticks', 'string', {'on','off'}, 'on'; ...
    'ylabel', 'string', {}, measure; ...
    'randratio', 'string', {'on','off'}, 'off'; ...
    'legendposition', 'string', {}, 'NorthEast'; ...
    });

fontname = 'Helvetica';
fontsize = 28;

% load(sprintf('%s/%s/%s%sgraph.mat',filepath,conntype,basename,conntype));
load(sprintf('%s/%s/graphdata_%s_%s.mat',filepath,conntype,listname,conntype));

if ~exist('measure','var') || isempty(measure)
    for m = 1:size(graph,1)
        fprintf('%s\n',graph{m,1});
    end
    return;
end

weiorbin = 2;

if strcmpi(measure,'small-worldness') || strcmp(param.randratio,'on')
    if exist(sprintf('%s/%s/%s%srandgraph.mat',filepath,conntype,basename,conntype),'file')
        randgraphdata = load(sprintf('%s/%s/%s%srandgraph.mat',filepath,conntype,basename,conntype));
    else
        error('%s/%s/%s%srandgraph.mat not found!',filepath,conntype,basename,conntype);
    end
    if exist(sprintf('%s/%s/graphdata_%s_rand_%s.mat',filepath,conntype,listname,conntype),'file')
        randgraph = load(sprintf('%s/%s/graphdata_%s_rand_%s.mat',filepath,conntype,listname,conntype));
    else
        error('%s/%s/graphdata_%s_rand_%s.mat not found!',filepath,conntype,listname,conntype);
    end
end

if strcmpi(measure,'small-worldness')
    graphdata{end+1,1} = 'small-worldness';
    graphdata{end,2} = ( mean(graphdata{1,2},3) ./ mean(mean(randgraphdata.graphdata{1,2},4),3) ) ./ ( graphdata{2,2} ./ mean(randgraphdata.graphdata{2,2},3) ) ;
    graph{end+1,1} = 'small-worldness';
    graph{end,2} = ( mean(graph{1,2},4) ./ mean(mean(randgraph.graph{1,2},5),4) ) ./ ( graph{2,2} ./ mean(randgraph.graph{2,2},4) ) ;
elseif strcmp(param.randratio,'on')
    m = find(strcmpi(measure,graphdata(:,1)));
    graphdata{m,2} = graphdata{m,2} ./ mean(randgraphdata.graph{m,2},ndims(randgraphdata.graph{m,2}));
    m = find(strcmpi(measure,graph(:,1)));
    graph{m,2} = graph{m,2} ./ mean(randgraph.graph{m,2},ndims(randgraph.graph{m,2}));
end

v1idx = zeros(size(subjlist,1),1);
for s = 1:size(subjlist,1)
    if ~isempty(subjlist{s,5})
        v1idx(s) = find(strcmp(subjlist{s,5},subjlist(:,1)));
    end
end
v2idx = logical(v1idx);
v1idx = nonzeros(v1idx);

groups = unique(grp)';
[groups, sortidx] = sort(groups,'ascend');
groupnames = {
    'VS'
    'MCS'
    'Control'
    };
groupnames = groupnames(sortidx);

bands = {
    'Delta'
    'Theta'
    'Alpha'
    'Beta'
    'Gamma'
    };

trange = [0.5 0.1];
trange = (tvals <= trange(1) & tvals >= trange(2));

m = find(strcmpi(measure,graph(:,1)));

barvals = zeros(3,length(groups));
errvals = zeros(3,length(groups));

if strcmp(graph{m,1},'modules')
    groupvals = squeeze(max(graph{m,weiorbin}(~v2idx,bandidx,:,:),[],4));
elseif strcmp(graph{m,1},'mutual information')
    groupvals = squeeze(mean(graph{m,weiorbin}(~v2idx,grp == groups(g) & ~v2idx,bandidx,:),2));
elseif strcmp(graph{m,1},'participation coefficient')
    groupvals = squeeze(std(graph{m,weiorbin}(~v2idx,bandidx,:,:),[],4));
else
    groupvals = squeeze(mean(graph{m,weiorbin}(~v2idx,bandidx,:,:),4));
end

plotvals = mean(groupvals(:,trange),2);

figure('Color','white')
boxplot(plotvals,grp(~v2idx));

if strcmp(param.plotticks,'on')
    set(gca,'FontName',fontname,'FontSize',fontsize);
    xlabel('Groups','FontName',fontname,'FontSize',fontsize);
    ylabel(param.ylabel,'FontName',fontname,'FontSize',fontsize);
end

%     export_fig(gcf,sprintf('figures/%s_%s_%s.eps',listname,measure,bands{bandidx}));
%     close(gcf);

