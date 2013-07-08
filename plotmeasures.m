function plotmeasures

load graphdata_allsubj_pli

figure;
i = 1;
for f = 1:3
    for m = 1:7
        if m == 2 || m == 5
            continue;
        end
        
        subplot(3,5,i);
        hold all
        for g = 0:3
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