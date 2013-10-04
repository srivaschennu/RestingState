function plotcohdist(listname,bandidx,varargin)

param = finputcheck(varargin, {
    'xlim', 'real', [], []; ...
    'ylim', 'real', [], []; ...
    'plotinfo', 'string', {'on','off'}, 'on'; ...
    });

load(sprintf('alldata_%s.mat',listname));
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

chandist = chandist ./ max(chandist(:));

chandist = chandist(:);
uniqcd = sort(unique(chandist));
uniqcd = linspace(uniqcd(1),uniqcd(end),10);


figure('Color','white'); hold all
for g = groups
    groupcoh = squeeze(allcoh(grp == g,bandidx,:,:));
    plotvals = zeros(length(uniqcd)-1,size(groupcoh,1));
    
    for u = 1:length(uniqcd)-1
        selvals = (chandist > uniqcd(u) & chandist <= uniqcd(u+1));
        for s = 1:size(groupcoh,1)
            cohmat = squeeze(groupcoh(s,:,:));
            cohmat = cohmat(:);
            cohmat = cohmat(selvals);
            plotvals(u,s) = mean(cohmat);
        end
    end
    errorbar(uniqcd(2:end),mean(plotvals,2),std(plotvals,[],2)/sqrt(size(plotvals,2)),'LineWidth',1);
end
set(gca,'XLim',[uniqcd(1) uniqcd(end)],'FontSize',fontsize);
if strcmp(param.plotinfo,'on')
    xlabel('Normalised inter-channel distance','FontName',fontname,'FontSize',fontsize);
    ylabel('PLI z-scores','FontName',fontname,'FontSize',fontsize);
    legend(groupnames);
else
    xlabel(' ','FontName',fontname,'FontSize',fontsize);
    ylabel(' ','FontName',fontname,'FontSize',fontsize);
end
if ~isempty(param.ylim)
    ylim(param.ylim);
end
export_fig(gcf,sprintf('figures/plidist_%s.eps',bands{bandidx}));
% close(gcf);
