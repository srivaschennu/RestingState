function plotmeasures

load graphdata_allsubj_pli
randgraph = load('graphdata_allsubj_pli_rand');

graph{end+1,1} = 'small-worldness index';
graph{end,2} = ( mean(graph{1,2},4) ./ mean(randgraph.graph{1,2},4) ) ./ ( graph{2,2} ./ randgraph.graph{2,2}) ;
graph{end,3} = ( mean(graph{1,3},4) ./ mean(randgraph.graph{1,3},4) ) ./ ( graph{2,3} ./ randgraph.graph{2,3}) ;

grp(grp == 2) = 1;
grp(grp == 3) = 2;

figure;
i = 1;
for f = 1:3
    for m = 1:8
        subplot(3,8,i);
        hold all
        for g = 0:2
            groupvals = squeeze(mean(graph{m,3}(grp == g,f,:,:),4));
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