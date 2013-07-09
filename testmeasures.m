function testmeasures(mid,freq)

load graphdata_allsubj_pli
randgraph = load('graphdata_allsubj_pli_rand');

graph{end+1,1} = 'small-worldness index';
graph{end,2} = ( mean(graph{1,2},4) ./ mean(randgraph.graph{1,2},4) ) ./ ( graph{2,2} ./ randgraph.graph{2,2}) ;
graph{end,3} = ( mean(graph{1,3},4) ./ mean(randgraph.graph{1,3},4) ) ./ ( graph{2,3} ./ randgraph.graph{2,3}) ;

grp(grp == 2) = 1;
grp(grp == 3) = 2;

trange = 1-[0.2 0.5];
trange = find(tvals <= trange(1) & tvals >= trange(2));

for g = 0:2
    groupvals = squeeze(mean(mean(graph{mid,3}(grp == g,freq,trange,:),4),3));
    groupmean(1,g+1) = mean(groupvals,1);
    groupse(1,g+1) = std(groupvals,[],1)/sqrt(size(groupvals,1));
end

[~,~,stats] = anova1(squeeze(mean(mean(graph{mid,3}(:,freq,trange,:),4),3)),grp);
figure; multcompare(stats);
