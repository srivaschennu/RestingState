function [testdata,grp,v2idx,v1idx] = testmeasure(listname,measure,bandidx,varargin)

load(sprintf('graphdata_%s_pli.mat',listname));
if ~exist('measure','var') || isempty(measure)
    for m = 1:size(graph,1)
        fprintf('%s\n',graph{m,1});
    end
    return;
end

param = finputcheck(varargin, {
    'xlim', 'real', [], []; ...
    'xtick', 'real', [], []; ...
    'ylim', 'real', [], []; ...
    'plotinfo', 'string', {'on','off'}, 'on'; ...
    'legend', 'string', {'on','off'}, 'on'; ...
    'legendposition', 'string', {}, ''; ...
    'xlabel', 'string', {}, measure; ...
    'exclude', 'string', {'on','off'}, 'off'; ...
    });

fontname = 'Helvetica';
fontsize = 28;

load(sprintf('alldata_%s.mat',listname));
load chanlist

randgraph = load(sprintf('graphdata_%s_rand_pli.mat',listname));

weiorbin = 3;
trange = [0.5 0.1];

crs = cell2mat(subjlist(:,3));
tennis = logical(cell2mat(subjlist(:,4)));

bands = {
    'Delta'
    'Theta'
    'Alpha'
    'Beta'
    'Gamma'
    };

graph{end+1,1} = 'small-worldness';
graph{end,2} = ( mean(graph{1,2},4) ./ mean(randgraph.graph{1,2},4) ) ./ ( graph{2,2} ./ randgraph.graph{2,2}) ;
graph{end,3} = ( mean(graph{1,3},4) ./ mean(randgraph.graph{1,3},4) ) ./ ( graph{2,3} ./ randgraph.graph{2,3}) ;

mid = find(strcmpi(measure,graph(:,1)));
if isempty(mid)
    error('Measure not found.');
end

v1idx = zeros(size(subjlist,1),1);
for s = 1:size(subjlist,1)
    if ~isempty(subjlist{s,5})
        v1idx(s) = find(strcmp(subjlist{s,5},subjlist(:,1)));
    end
end
v2idx = logical(v1idx);
v1idx = nonzeros(v1idx);

trange = (tvals <= trange(1) & tvals >= trange(2));

if strcmpi(measure,'mutual information')
    for s = 1:size(subjlist,1)
        testdata(s,1) = squeeze(mean(mean(graph{mid,weiorbin}(s,grp == grp(s),bandidx,trange),4),2));
    end
else
    testdata = squeeze(mean(mean(graph{mid,weiorbin}(:,bandidx,trange,:),4),3));
end
powerdata = mean(bandpower(:,bandidx,:),3);

%% test patients vs controls group difference
[pval,~,stats] = ranksum(testdata(grp == 2),testdata((grp == 0 | grp == 1) & ~v2idx));
fprintf('%s band %s: Ctrl %.2f, Pat %.2f, Mann-whitney U = %.2f, p = %.3f.\n',...
    bands{bandidx},measure,mean(testdata(grp == 2)),mean(testdata((grp == 0 | grp == 1) & ~v2idx)),stats.ranksum,pval);

%% compare vs to mcs patients
[pval,~,stats] = ranksum(testdata(grp == 1 & ~v2idx),testdata(grp == 0 & ~v2idx));
fprintf('%s band %s: MCS - VS = %.2f, Mann-whitney U = %.2f, p = %.3f.\n',...
    bands{bandidx},measure,mean(testdata(grp == 1 & ~v2idx))-mean(testdata(grp == 0 & ~v2idx)),stats.ranksum,pval);

%% compare power between imagers and non-imagers
[pval,~,stats] = ranksum(testdata((grp == 0 | grp == 1) & ~v2idx & ~tennis),testdata((grp == 0 | grp == 1) & ~v2idx & tennis));
fprintf('Imagers vs non-imagers %s band power: Mann-whitney U = %.2f, p = %.3f.\n',bands{bandidx},stats.ranksum,pval);

%% correlate patients with crs scores

datatable = sortrows(cat(2,...
    crs((grp == 0 | grp == 1) & ~v2idx),...
    testdata((grp == 0 | grp == 1) & ~v2idx),...
    tennis((grp == 0 | grp == 1) & ~v2idx),...
    grp((grp == 0 | grp == 1) & ~v2idx),...
    powerdata((grp == 0 | grp == 1) & ~v2idx)),...
    2);
mdl = LinearModel.fit(datatable(:,2),datatable(:,1),'RobustOpts','on');
fprintf('%s %s: R2 = %.2f, p = %.3f.\n',bands{bandidx},measure,mdl.Rsquared.Adjusted,doftest(mdl));
exmdl = LinearModel.fit(datatable(:,2),datatable(:,1),'RobustOpts','on','Exclude',find(datatable(:,4) == 0 & datatable(:,3) == 1));
fprintf('%s %s (excl): R2 = %.2f, p = %.3f.\n',bands{bandidx},measure,exmdl.Rsquared.Adjusted,doftest(exmdl));

% test with power covariate
% exmdl = LinearModel.fit(datatable(:,[2 5]),datatable(:,1),'RobustOpts','on','Exclude',find(datatable(:,4) == 0 & datatable(:,3) == 1))
% fprintf('%s %s (excl with power): R2 = %.2f, p = %.3f.\n',bands{bandidx},measure,exmdl.Rsquared.Adjusted,doftest(exmdl));

% [rho, pval] = corr(datatable(:,1),datatable(:,2),'type','spearman');
% fprintf('Spearman rho = %.2f, p = %.3f.\n',rho,pval);


figure('Color','white');
hold all
%VS
legendoff(scatter(datatable(datatable(:,4) == 0 & datatable(:,3) == 0,2), ...
    datatable(datatable(:,4) == 0 & datatable(:,3) == 0,1),'red'));
legendoff(scatter(datatable(datatable(:,4) == 0 & datatable(:,3) == 1,2), ...
    datatable(datatable(:,4) == 0 & datatable(:,3) == 1,1),'red','filled'));
%MCS
legendoff(scatter(datatable(datatable(:,4) == 1 & datatable(:,3) == 0,2), ...
    datatable(datatable(:,4) == 1 & datatable(:,3) == 0,1),'blue'));
legendoff(scatter(datatable(datatable(:,4) == 1 & datatable(:,3) == 1,2), ...
    datatable(datatable(:,4) == 1 & datatable(:,3) == 1,1),'blue','filled'));

b = mdl.Coefficients.Estimate;
plot(datatable(:,2),b(1)+b(2)*datatable(:,2),'-','Color','black',...
    'Display',sprintf('R^2 = %.2f, p = %.3f',mdl.Rsquared.Adjusted,doftest(mdl)));
b = exmdl.Coefficients.Estimate;
plot(datatable(:,2),b(1)+b(2)*datatable(:,2),'--','Color','black',...
    'Display',sprintf('R^2 = %.2f, p = %.3f',exmdl.Rsquared.Adjusted,doftest(exmdl)));

set(gca,'FontName',fontname,'FontSize',fontsize);
if ~isempty(param.ylim)
    set(gca,'YLim',param.ylim);
end
if ~isempty(param.xlim)
    set(gca,'XLim',param.xlim);
end

xlabel(param.xlabel,'FontName',fontname,'FontSize',fontsize);
if strcmp(param.plotinfo,'on')
    ylabel('CRS-R score','FontName',fontname,'FontSize',fontsize);
else
    ylabel(' ','FontName',fontname,'FontSize',fontsize);
end
if strcmp(param.legend,'on')
    leg_h = legend('show');
    if isempty(param.legendposition)
        set(leg_h,'Location','Best');
    else
        set(leg_h,'Location',param.legendposition);
    end
    txt_h = findobj(leg_h,'type','text');
    set(txt_h,'FontSize',fontsize-6,'FontWeight','bold')
    legend('boxoff');
end
export_fig(sprintf('figures/crscorr_%s_%s.eps',measure,bands{bandidx}));
close(gcf);

futable = sortrows(cat(2,...
    crs(v2idx)-crs(v1idx),...
    testdata(v1idx),...
    powerdata(v1idx)),...
    2);

%% correlate follow-ups
% [rho, pval] = corr(futable(:,1),futable(:,2),'type','spearman');
% fprintf('Follow-up: Spearman rho = %.2f, p = %.3f.\n',rho,pval);

mdl = LinearModel.fit(futable(:,2),futable(:,1),'RobustOpts','off');
fprintf('%s follow-up: R2 = %.2f, p = %.3f.\n',bands{bandidx},mdl.Rsquared.Adjusted,doftest(mdl));
% powmdl = LinearModel.fit(futable(:,[2 3]),futable(:,1),'RobustOpts','off');
% fprintf('%s follow-up with power: R2 = %.2f, p = %.3f.\n',bands{bandidx},powmdl.Rsquared.Adjusted,doftest(powmdl));

figure('Color','white');
hold all
legendoff(scatter(futable(:,2),futable(:,1),'filled'));

b = mdl.Coefficients.Estimate;
plot(futable(:,2),b(1)+b(2)*futable(:,2),'-','Color','black',...
    'Display',sprintf('R^2 = %.2f, p = %.3f',mdl.Rsquared.Adjusted,doftest(mdl)));
% b = powmdl.Coefficients.Estimate;
% plot(futable(:,2),b(1)+b(2)*futable(:,2),'--','Color','black',...
%     'Display',sprintf('R^2 = %.2f, p = %.3f',powmdl.Rsquared.Adjusted,doftest(powmdl)));

set(gca,'FontName',fontname,'FontSize',fontsize);
if ~isempty(param.xlim)
    set(gca,'XLim',param.xlim);
end
if ~isempty(param.ylim)
    set(gca,'YLim',param.ylim);
end
xlabel(sprintf('Visit1 %s %s',bands{bandidx},measure),'FontName',fontname,'FontSize',fontsize);
if strcmp(param.plotinfo,'on')
    ylabel('V2 CRS-R - V1 CRS-R','FontName',fontname,'FontSize',fontsize);
else
    ylabel(' ','FontName',fontname,'FontSize',fontsize);
end
if strcmp(param.legend,'on')
    leg_h = legend('show');
    if isempty(param.legendposition)
        set(leg_h,'Location','Best');
    else
        set(leg_h,'Location',param.legendposition);
    end
    txt_h = findobj(leg_h,'type','text');
    set(txt_h,'FontSize',fontsize-6,'FontWeight','bold')
    legend('boxoff');
end

export_fig(sprintf('figures/measurefu_%s_%s.eps',measure,bands{bandidx}));
close(gcf);

end