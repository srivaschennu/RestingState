function plotmetric(basename,listname,conntype,measure,varargin)

loadpaths

param = finputcheck(varargin, {
    'ylim', 'real', [], []; ...
    'legend', 'string', {'on','off'}, 'on'; ...
    'plotinfo', 'string', {'on','off'}, 'on'; ...
    'plotticks', 'string', {'on','off'}, 'on'; ...
    'ylabel', 'string', {}, measure; ...
    'randratio', 'string', {'on','off'}, 'on'; ...
    'legendposition', 'string', {}, 'NorthEast'; ...
    });

fontname = 'Helvetica';
fontsize = 28;

load(sprintf('%s/%s/%s%sgraph.mat',filepath,conntype,basename,conntype));
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
    graphdata{end,2} = ( mean(graphdata{1,2},4) ./ mean(mean(randgraphdata.graph{1,2},5),4) ) ./ ( graphdata{2,2} ./ mean(randgraphdata.graph{2,2},4) ) ;
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
[groups, sortidx] = sort(groups,'descend');
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

plottvals = tvals(trange);

m = find(strcmpi(measure,graph(:,1)));

barvals = zeros(3,length(groups));
errvals = zeros(3,length(groups));

for bandidx = 1:3
    figure('Color','white');
    hold all
    for g = 1:length(groups)
        if strcmp(graph{m,1},'modules')
            groupvals = squeeze(max(graph{m,weiorbin}(grp == groups(g) & ~v2idx,bandidx,:,:),[],4));
        elseif strcmp(graph{m,1},'mutual information')
            groupvals = squeeze(mean(graph{m,weiorbin}(grp == groups(g) & ~v2idx,grp == groups(g) & ~v2idx,bandidx,:),2));
        elseif strcmp(graph{m,1},'participation coefficient')
            groupvals = squeeze(std(graph{m,weiorbin}(grp == groups(g) & ~v2idx,bandidx,:,:),[],4));
        else
            groupvals = squeeze(mean(graph{m,weiorbin}(grp == groups(g) & ~v2idx,bandidx,:,:),4));
        end
        groupmean = mean(groupvals,1);
        groupste = std(groupvals,[],1)/sqrt(size(groupvals,1));
        set(gca,'XDir','reverse');
        errorbar(plottvals,groupmean(trange),groupste(trange),'LineWidth',1);
        set(gca,'XLim',[plottvals(end) plottvals(1)],'FontName',fontname,'FontSize',fontsize);
        if ~isempty(param.ylim)
            set(gca,'YLim',param.ylim);
        end
        
        barvals(bandidx,g) = mean(mean(groupvals(:,trange),2),1);
        errvals(bandidx,g) = std(mean(groupvals(:,trange),2),[],1)/sqrt(size(groupvals,1));
    end
    
    if strcmp(param.plotticks,'on')
        if bandidx == 1
            ylabel(param.ylabel,'FontName',fontname,'FontSize',fontsize);
        else
            ylabel(' ','FontName',fontname,'FontSize',fontsize);
        end
        if bandidx == 1 && strcmp(param.plotinfo,'on')
            xlabel('Graph connection density','FontName',fontname,'FontSize',fontsize);
        else
            xlabel(' ','FontName',fontname,'FontSize',fontsize);
        end
        if bandidx == 1 && strcmp(param.legend,'on')
            legend(groupnames,'Location',param.legendposition);
        end
        
    else
        set(gca,'XTick',[],'YTick',[]);
    end
    
    if bandidx == 1
        ylimits = ylim;
    end
    
    export_fig(gcf,sprintf('figures/%s_%s_%s.eps',listname,measure,bands{bandidx}));
    close(gcf);
end

figure('Color','white');
if strcmp(param.plotinfo,'on')
    hdl = barweb(barvals,errvals,[],bands,[],[],[],[],[],groupnames,[],[]);
    set(hdl.legend,'FontName',fontname,'FontSize',fontsize,'Location','NorthWest','Orientation','Horizontal');
else
    hdl = barweb(barvals,errvals,[],repmat(' ',1,length(bands)),[],[],[],[],[],[],[],[]);
end

set(hdl.ax,'FontName',fontname,'FontSize',fontsize,'YLim',ylimits);
ylabel(param.ylabel,'FontName',fontname,'FontSize',fontsize);
export_fig(gcf,sprintf('figures/%s_bar.eps',measure));
close(gcf);
