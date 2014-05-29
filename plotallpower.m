function plotallpower(listname,conntype)

loadpaths

load(sprintf('%s/%s/allspec_%s_%s.mat',filepath,conntype,listname,conntype));
load chanlist
load freqlist

fontname = 'Helvetica';
fontsize = 28;

opengl = false;

bands = {
    'Delta'
    'Theta'
    'Alpha'
    'Beta'
    'Gamma'
    };

groupnames = {
    'VS'
    'MCS'
    'Control'
    };

crs = cell2mat(subjlist(:,3));

v1idx = zeros(size(subjlist,1),1);
for s = 1:size(subjlist,1)
    if ~isempty(subjlist{s,5})
        v1idx(s) = find(strcmp(subjlist{s,5},subjlist(:,1)));
    end
end
v2idx = logical(v1idx);
v1idx = nonzeros(v1idx);

crs = crs(~v2idx);
bandpower = bandpower(~v2idx,:,:,:);
grp = grp(~v2idx);

[groups, sortidx] = sort(unique(grp),'descend');
groupnames = groupnames(sortidx);
barvals = zeros(3,length(groups));
errvals = zeros(3,length(groups));

alphatheta = bandpower(:,3,:,:) ./ bandpower(:,2,:,:);
bandpower = bandpower * 100;

for bandidx = 1:3
    for g = 1:length(groups)
        powerdata = bandpower(grp == groups(g),bandidx,:,:);
        powersd = nanstd(powerdata,[],4);
        barvals(bandidx,g) = mean(mean(powersd,3),1);
        errvals(bandidx,g) = std(mean(powersd,3),[],1)/sqrt(sum(grp == groups(g)));
        
        if bandidx == 1
            figure('Color','white');
            plot(squeeze(nanmean(alphatheta(grp == groups(g),1,:,:),3))','LineWidth',1);
            %imagesc(squeeze(nanmean(bandpower(grp == groups(g),bandidx,:,:),3)));
            if ~opengl
                if bandidx == 1 && g == 1
                    xlabel('Time (minutes)','FontName',fontname,'FontSize',fontsize);
                    ylabel('Alpha-theta ratio','FontName',fontname,'FontSize',fontsize);
                else
                    xlabel(' ','FontName',fontname,'FontSize',fontsize);
                    ylabel(' ','FontName',fontname,'FontSize',fontsize);
                end
            end
            box off
            
            if ~opengl
                set(gca,'XTick',0:6:60,'XTickLabel',0:10,'FontName',fontname,'FontSize',fontsize);
%                 colorbar
                export_fig(gcf,sprintf('figures/%s_%s_powertrend.eps',groupnames{g},bands{bandidx}));
            elseif opengl
                set(gca,'XTick',[],'YTick',[]);
                export_fig(gcf,sprintf('figures/%s_%s_powertrend.eps',groupnames{g},bands{bandidx}),'-opengl');
            end
            
            close(gcf);
        end
    end
end

figure('Color','white');
hdl = barweb(barvals,errvals,[],bands,[],[],[],[],[],groupnames,[],[]);
set(hdl.ax,'FontName',fontname,'FontSize',fontsize,'YLim',[0 18]);
ylabel('Power contribution S.D. (%)','FontName',fontname,'FontSize',fontsize)
set(hdl.legend,'FontName',fontname,'FontSize',fontsize,'Location','NorthWest','Orientation','Horizontal');
export_fig(gcf,'figures/powervarbar.eps');
close(gcf);


