function plotgraphdata

load graphdata.mat

for f = 1:5
    figure('Name',sprintf('band %d',f));
    for m = 1:length(graph)
        subplot(2,3,m);
        hold all
        for g = 0:2
            plot(tvals, mean(squeeze(graph{m,1}(grp == g,f,:)),1));
        end
        ylabel(graph{m,2});
    end
end