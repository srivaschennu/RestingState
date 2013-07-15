function plotmeasures(listname)

% load graphdata_allsubj_icoh

load(sprintf('graphdata_%s_pli.mat',listname));

weiorbin = 3;

if exist(sprintf('graphdata_%s_pli_rand.mat',listname),'file')
    randgraph = load(sprintf('graphdata_%s_pli_rand.mat',listname));
    graph{end+1,1} = 'small-worldness index';
    graph{end,2} = ( mean(graph{1,2},4) ./ mean(randgraph.graph{1,2},4) ) ./ ( graph{2,2} ./ randgraph.graph{2,2}) ;
    graph{end,3} = ( mean(graph{1,3},4) ./ mean(randgraph.graph{1,3},4) ) ./ ( graph{2,3} ./ randgraph.graph{2,3}) ;
end

grp(grp == 2) = 1;
grp(grp == 3) = 2;

groups = unique(grp)';

bands = {
    'delta'
    'theta'
    'alpha'
    'beta'
    'gamma'
    };

plotlist = {
    'clustering'
%     'characteristic path length'
%     'global efficiency'
    'small-worldness index'
    'modularity'
%     'modules'
%     'centrality'
    'modular distance'
    'mutual information'
%     'threshold'
    };

nfreq = size(graph{1,2},2);
nmes = length(plotlist);

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
                groupvals = squeeze(max(graph{m,weiorbin}(grp == g,f,:,:),[],4));
            elseif strcmp(graph{m,1},'mutual information')
                groupvals = squeeze(mean(graph{m,weiorbin}(grp == g,grp == g,f,:),2));
            else
                groupvals = squeeze(mean(graph{m,weiorbin}(grp == g,f,:,:),4));
            end
            groupmean = mean(groupvals,1);
            groupstd = std(groupvals,[],1)/sqrt(size(groupvals,1));
            errorbar(1-tvals,groupmean,groupstd);
            set(gca,'XLim',1-[tvals(1) tvals(end)],'XTick',1-tvals(1:2:end),'XTickLabel',tvals(1:2:end));
        end
        i = i+1;
        if f == 1
            title(graph{m,1});
        end
        if midx == 1
            ylabel(bands{f});
        end
    end
end
xlabel('Graph connection density');