function plotmeasures(listname)

% load graphdata_allsubj_icoh

load(sprintf('graphdata_%s_pli.mat',listname));

weiorbin = 3;
fontsize = 16;

if exist(sprintf('graphdata_%s_rand_pli.mat',listname),'file')
    randgraph = load(sprintf('graphdata_%s_rand_pli.mat',listname));
    graph{end+1,1} = 'small-worldness index';
    graph{end,2} = ( mean(graph{1,2},4) ./ mean(randgraph.graph{1,2},4) ) ./ ( graph{2,2} ./ randgraph.graph{2,2}) ;
    graph{end,3} = ( mean(graph{1,3},4) ./ mean(randgraph.graph{1,3},4) ) ./ ( graph{2,3} ./ randgraph.graph{2,3}) ;
end

grp(grp == 2) = 1;
grp(grp == 3) = 2;

v1idx = zeros(size(subjlist,1),1);
for s = 1:size(subjlist,1)
    if ~isempty(subjlist{s,5})
        v1idx(s) = find(strcmp(subjlist{s,5},subjlist(:,1)));
    end
end
v2idx = logical(v1idx);
v1idx = nonzeros(v1idx);

% grp = cell2mat(allsubj(:,4));

groups = unique(grp)';

bands = {
    'delta'
    'theta'
    'alpha'
    'beta'
    'gamma'
    };

plotlist = {
%     'clustering'
%     'characteristic path length'
%     'global efficiency'
    'small-worldness index'
    'modularity'
% %     'modules'
%     'centrality'
    'participation coefficient'
    'modular span'
    'mutual information'
%     'connection density'
%     'rentian scaling'
%     'threshold'
    };

nfreq = size(graph{1,3},2);
nmes = length(plotlist);

trange = [0.5 0.05];
trange = (tvals <= trange(1) & tvals >= trange(2));
plottvals = tvals(trange);

figure;
i = 1;
for f = 1:nfreq
    for midx = 1:nmes
        subplot(nfreq,nmes,i);
        hold all
        m = find(strcmp(plotlist{midx},graph(:,1)));
        if isempty(m)
            continue;
        end
        for g = groups
            if strcmp(graph{m,1},'modules') || strcmp(graph{m,1},'centrality')
                groupvals = squeeze(max(graph{m,weiorbin}(grp == g & ~v2idx,f,:,:),[],4));
            elseif strcmp(graph{m,1},'mutual information')
                groupvals = squeeze(mean(graph{m,weiorbin}(grp == g & ~v2idx,grp == 2,f,:),2));
            elseif strcmp(graph{m,1},'participation coefficient')
                groupvals = squeeze(std(graph{m,weiorbin}(grp == g & ~v2idx,f,:,:),[],4));
            else
                groupvals = squeeze(mean(graph{m,weiorbin}(grp == g & ~v2idx,f,:,:),4));
            end
            groupmean = mean(groupvals,1);
            groupstd = std(groupvals,[],1)/sqrt(size(groupvals,1));
            errorbar(1-plottvals,groupmean(trange),groupstd(trange));
            set(gca,'XLim',1-[plottvals(1) plottvals(end)],'XTick',1-plottvals(1:2:end),'XTickLabel',plottvals(1:2:end),...
                'FontSize',fontsize);
        end
        i = i+1;
        if f == 1
            title(graph{m,1},'FontSize',fontsize);
        end
        if midx == 1
            ylabel(bands{f},'FontSize',fontsize);
        end
    end
end
xlabel('Graph connection density','FontSize',fontsize);
set(gcf,'Color','white');