function plotcohdist(listname,conntype,bandidx,varargin)

loadpaths

param = finputcheck(varargin, {
    'xlim', 'real', [], []; ...
    'ylim', 'real', [], []; ...
    'plotinfo', 'string', {'on','off'}, 'on'; ...
    });

load(sprintf('%s/%s/alldata_%s_%s.mat',filepath,conntype,listname,conntype));
load chanlist

fontname = 'Helvetica';
fontsize = 28;

v1idx = zeros(size(subjlist,1),1);
for s = 1:size(subjlist,1)
    if ~isempty(subjlist{s,5})
        v1idx(s) = find(strcmp(subjlist{s,5},subjlist(:,1)));
    end
end
v2idx = logical(v1idx);
v1idx = nonzeros(v1idx);

grp = grp(~v2idx);
allcoh = allcoh(~v2idx,:,:,:);

groups = unique(grp)';
groupnames = {
    'VS'
    'MCS'
    'Control'
    };
[groups,sortidx] = sort(groups,'descend');
groupnames = groupnames(sortidx);

bands = {
    'Delta'
    'Theta'
    'Alpha'
    'Beta'
    'Gamma'
    };

nbins = 10;

chandist = chandist(logical(triu(ones(size(chandist)),1)));
sorteddist = sort(chandist);
[numcd,uniqcd] = hist(sorteddist,nbins);

figure('Color','white');
figpos = get(gcf,'Position');
figpos(4) = figpos(4)/2;
set(gcf,'Position',figpos);
bar(uniqcd,numcd);
set(gca,'FontSize',fontsize+4,'FontName',fontname,'XLim',[uniqcd(1)-1 uniqcd(end)+1],'YLim',[0 700]);
xlabel('Inter-channel distance (cm)','FontName',fontname,'FontSize',fontsize+4);
ylabel('Chan. pairs','FontName',fontname,'FontSize',fontsize+4);
export_fig(gcf,sprintf('figures/chandist.eps'));
close(gcf);

uniqcd = [sorteddist(1) uniqcd sorteddist(end)];

figure('Color','white'); hold all
for g = groups
    groupcoh = squeeze(allcoh(grp == g,bandidx,:,:));
    plotvals = zeros(length(uniqcd)-1,size(groupcoh,1));
    
    for u = 1:length(uniqcd)-1
        selvals = (chandist > uniqcd(u) & chandist <= uniqcd(u+1));
        for s = 1:size(groupcoh,1)
            cohmat = squeeze(groupcoh(s,:,:));
            cohmat = cohmat(logical(triu(ones(size(cohmat)),1)));
            plotvals(u,s) = mean(cohmat(selvals));
        end
    end
    errorbar(uniqcd(2:end),mean(plotvals,2),std(plotvals,[],2)/sqrt(size(plotvals,2)),'LineWidth',1);
end
set(gca,'XLim',[uniqcd(1) uniqcd(end)],'FontName',fontname,'FontSize',fontsize);
if strcmp(param.plotinfo,'on')
    xlabel('Inter-channel distance (cm)','FontName',fontname,'FontSize',fontsize);
    ylabel('dwPLI z-scores','FontName',fontname,'FontSize',fontsize);
    legend(groupnames,'Location','NorthEast');
else
    xlabel(' ','FontName',fontname,'FontSize',fontsize);
    ylabel(' ','FontName',fontname,'FontSize',fontsize);
end
if ~isempty(param.ylim)
    ylim(param.ylim);
end
export_fig(gcf,sprintf('figures/cohdist_%s.eps',bands{bandidx}));
close(gcf);
