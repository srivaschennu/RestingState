function plotmeasures

plotlist = {
    'Small-worldness'
    'Modularity'
    'Participation coefficient'
    'Modular span'
    };

bands = {
    'Delta'
    'Theta'
    'Alpha'
    'Beta'
    'Gamma'
    };

for f = 2:3%1:5
    for p = 1:length(plotlist)
        if f == 2 && p == 1
            plotoptions = {'plotinfo','on','legend','on'};
        else
            plotoptions = {'plotinfo','off','legend','off'};
        end
            
        plotmeasure('allsubj',f,plotlist{p},plotoptions{:});
        
        export_fig(gcf,sprintf('figures/%s_%s.eps',plotlist{p},bands{f}));
        close(gcf);
    end
end
