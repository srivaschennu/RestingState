figure('Position',[0 0 1024 768]);
for f = 1:5
    subplot(5,6,(f-1)*6+1);
    plot(tvals,squeeze(mean(mod(grp==1,f,:),1)),tvals,squeeze(mean(mod(grp==2,f,:),1)));
    ylim = get(gca,'YLim');
    for t = 1:length(tvals)
        [~,h] = ranksum(mod(grp==1,f,t),mod(grp==2,f,t),'alpha',0.01);
        if h
            text(tvals(t),ylim(1),'*');
        end
    end
    
    subplot(5,6,(f-1)*6+2);
    plot(tvals,squeeze(mean(bet(grp==1,f,:),1)),tvals,squeeze(mean(bet(grp==2,f,:),1)));
    ylim = get(gca,'YLim');
    for t = 1:length(tvals)
        [~,h] = ranksum(bet(grp==1,f,t),bet(grp==2,f,t),'alpha',0.01);
        if h
            text(tvals(t),ylim(1),'*');
        end
    end
    
    subplot(5,6,(f-1)*6+3);
    plot(tvals,squeeze(mean(maxci(grp==1,f,:),1)),tvals,squeeze(mean(maxci(grp==2,f,:),1)));
    ylim = get(gca,'YLim');
    for t = 1:length(tvals)
        [~,h] = ranksum(maxci(grp==1,f,t),maxci(grp==2,f,t),'alpha',0.01);
        if h
            text(tvals(t),ylim(1),'*');
        end
    end
    
    subplot(5,6,(f-1)*6+4);
    plot(tvals,squeeze(mean(clust(grp==1,f,:),1)),tvals,squeeze(mean(clust(grp==2,f,:),1)));
    ylim = get(gca,'YLim');
    for t = 1:length(tvals)
        [~,h] = ranksum(clust(grp==1,f,t),clust(grp==2,f,t),'alpha',0.01);
        if h
            text(tvals(t),ylim(1),'*');
        end
    end
    
    subplot(5,6,(f-1)*6+5);
    plot(tvals,squeeze(mean(charp(grp==1,f,:),1)),tvals,squeeze(mean(charp(grp==2,f,:),1)));
    ylim = get(gca,'YLim');
    for t = 1:length(tvals)
        [~,h] = ranksum(charp(grp==1,f,t),charp(grp==2,f,t),'alpha',0.01);
        if h
            text(tvals(t),ylim(1),'*');
        end
    end
    
    subplot(5,6,(f-1)*6+6);
    plot(tvals,squeeze(mean(dist(grp==1,f,:),1)),tvals,squeeze(mean(dist(grp==2,f,:),1)));
    ylim = get(gca,'YLim');
    for t = 1:length(tvals)
        [~,h] = ranksum(dist(grp==1,f,t),dist(grp==2,f,t),'alpha',0.01);
        if h
            text(tvals(t),ylim(1),'*');
        end
    end
end


