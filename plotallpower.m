function plotallpower(listname,conntype)

loadpaths

load(sprintf('%s/%s/allspec_%s_%s.mat',filepath,conntype,listname,conntype));
load chanlist
load freqlist

fontname = 'Helvetica';
fontsize = 28;

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
barvals = zeros(size(bandpower,2),length(groups));
errvals = zeros(size(bandpower,2),length(groups));

alphatheta = bandpower(:,3,:,:) ./ bandpower(:,2,:,:);

for bandidx = 1:size(bandpower,2)
    for g = 1:length(groups)
        barvals(bandidx,g) = mean(nanstd(nanmean(bandpower(grp == groups(g),bandidx,:,:),3),[],4),1);
        errvals(bandidx,g) = std(nanstd(nanmean(bandpower(grp == groups(g),bandidx,:,:),3),[],4),[],1)/sqrt(sum(grp == groups(g)));
        if bandidx == 3
            figure('Color','white'); plot(squeeze(nanmean(alphatheta(grp == groups(g),1,:,:),3))');
            set(gca,'XTick',0:6:60,'XTickLabel',0:10,'FontName',fontname,'FontSize',fontsize);
            xlabel('Time (minutes)','FontName',fontname,'FontSize',fontsize);
            ylabel('Alpha theta ratio','FontName',fontname,'FontSize',fontsize);
            %title(groupnames{g},'FontName',fontname,'FontSize',fontsize);
        end
    end
end

figure('Color','white');
hdl = barweb(barvals*100,errvals*100,[],bands,[],[],[],[],[],groupnames,[],[]);
set(hdl.ax,'FontName',fontname,'FontSize',fontsize);
ylabel('Temporal variance in power contribution (%)','FontName',fontname,'FontSize',fontsize)
set(hdl.legend,'FontName',fontname,'FontSize',fontsize);
export_fig(gcf,'figures/powervarbar.eps');
close(gcf);


