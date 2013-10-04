function plotmeasures

plotlist = {
%     'Small-worldness'
%     'Modularity'
    'Participation coefficient'
%     'Modular span'
    };

plotoptions
for p = 1:length(plotlist)
    plotmeasure('allsubj',plotlist{p},plotoptions{:});
end