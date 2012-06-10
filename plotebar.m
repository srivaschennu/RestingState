numgrp = 3;
alpha = 0.01;

bardata = zeros(5,numgrp);
errdata = zeros(5,numgrp);
for g = 1:numgrp
    bardata(:,g) = mean(bandpower(grp == g-1,:))';
    errdata(:,g) = std(bandpower(grp == g-1,:))'/sqrt(sum(grp == g-1));
end

pairlist = cell(1,5);
for f = 1:5
    for g = 1:numgrp
        for h = 1:numgrp
            if g < h
                p = ranksum(bandpower(grp == g-1,f),bandpower(grp == h-1,f));
                if p < alpha
                    fprintf('Band %d: Significant difference between groups %d and %d: p = %.03f.\n', ...
                        f, g-1, h-1, p);
                    pairlist{f} = [pairlist{f}; g h];
                end
            end
        end
    end
end

figure('Name',mfilename,'Color','white');
figpos = get(gcf,'Position');
set(gcf,'Position',[figpos(1) figpos(2) 1280 800]);

hstruct = barweb(bardata,errdata, [], {'delta','theta','alpha','beta','gamma'}, ...
    [], [], [], [], [], {'VS','MCS','Control'}, 1, []);
set(gca,'YLim',[-7 16],'FontName','Gill Sans','FontSize',48,'FontWeight','bold');
xlabel('Frequency bands','FontName','Gill Sans','FontSize',48,'FontWeight','bold');
ylabel('Band power (dB)','FontName','Gill Sans','FontSize',48,'FontWeight','bold');
set(hstruct.legend,'FontSize',48);

for f = 1:5
    for p = 1:size(pairlist{f},1)
        text(f,pairlist{f}(p,1),'**','FontName','Gill Sans','FontSize',48,'FontWeight','bold');
    end
end

barwebpairs(hstruct,[],pairlist);