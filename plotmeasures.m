function plotmeasures

% load graphdata_allsubj_icoh

load graphdata_allsubj_pli

weiorbin = 3;

randgraph = load('graphdata_allsubj_pli_rand');
graph{end+1,1} = 'small-worldness index';
graph{end,2} = ( mean(graph{1,2},4) ./ mean(randgraph.graph{1,2},4) ) ./ ( graph{2,2} ./ randgraph.graph{2,2}) ;
graph{end,3} = ( mean(graph{1,3},4) ./ mean(randgraph.graph{1,3},4) ) ./ ( graph{2,3} ./ randgraph.graph{2,3}) ;

grp(grp == 2) = 1;
grp(grp == 3) = 2;

plotlist = {
    'clustering'
%     'characteristic path length'
%     'global efficiency'
    'small-worldness index'
    'modularity'
    'modules'
    'centrality'
    'modular distance'
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
        for g = 0:2
            if strcmp(graph{m,1},'modules') || strcmp(graph{m,1},'centrality')
                groupvals = squeeze(max(graph{m,weiorbin}(grp == g,f,:,:),[],4));
            else
                groupvals = squeeze(mean(graph{m,weiorbin}(grp == g,f,:,:),4));
            end
            groupmean = mean(groupvals,1);
            groupstd = std(groupvals,[],1)/sqrt(size(groupvals,1));
            errorbar(1-tvals,groupmean,groupstd);
            set(gca,'XLim',1-[tvals(1) tvals(end)]);
        end
        i = i+1;
        if f == 1
            title(graph{m,1});
        end
    end
end