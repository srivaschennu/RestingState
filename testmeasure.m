function testmeasure(listname,measure,bandidx,varargin)

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
    'legend', 'string', {'on','off'}, 'on'; ...
    'plotinfo', 'string', {'on','off'}, 'on'; ...
    'xlabel', 'string', {}, measure; ...
    });

fontname = 'Helvetica';
fontsize = 28;

load(sprintf('alldata_%s.mat',listname));
load chanlist

randgraph = load(sprintf('graphdata_%s_rand_pli.mat',listname));

weiorbin = 3;
trange = [0.5 0.1];

crs = cell2mat(subjlist(:,3));
tennis = cell2mat(subjlist(:,4));

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
[pval,~,stats] = ranksum(testdata((grp == 0 | grp == 1) & ~v2idx),testdata(grp == 2));
fprintf('%s band %s: Diff = %.2f, Mann-whitney U = %.2f, p = %.3f.\n',...
    bands{bandidx},measure,mean(testdata(grp == 2))-mean(testdata((grp == 0 | grp == 1) & ~v2idx)),stats.ranksum,pval);

%% compare power between imagers and non-imagers
tennisidx = logical(tennis((grp == 0 | grp == 1) & ~v2idx));
[pval,~,stats] = ranksum(testdata(~tennisidx),testdata(tennisidx));
fprintf('Imagers vs non-imagers %s band power: Mann-whitney U = %.2f, p = %.3f.\n',bands{bandidx},stats.ranksum,pval);

%% correlate patients with crs scores

datatable = sortrows(cat(2,...
    crs((grp == 0 | grp == 1) & ~v2idx),...
    testdata((grp == 0 | grp == 1) & ~v2idx),...
    tennisidx,...
    powerdata((grp == 0 | grp == 1) & ~v2idx)),...
    2);
mdl = LinearModel.fit(datatable(:,2),datatable(:,1),'RobustOpts','on');
[rho, pval] = corr(datatable(:,1),datatable(:,2),'type','spearman');
fprintf('Spearman rho = %.2f, p = %.3f.\n',rho,pval);

[Fstat,pVal] = fTest(mdl);
fprintf('%s %s: R2 = %.2f, p = %.3f.\n',bands{bandidx},measure,mdl.Rsquared.Adjusted,pVal);

figure('Color','white');
hold all
scatter(datatable(datatable(:,3) == 0,2),datatable(datatable(:,3) == 0,1),'filled');
scatter(datatable(datatable(:,3) == 1,2),datatable(datatable(:,3) == 1,1),'filled','red');
b = mdl.Coefficients.Estimate;
plot(datatable(:,2),b(1)+b(2)*datatable(:,2),'--','Color','black');

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

mdl = LinearModel.fit(futable(:,2),futable(:,1),'RobustOpts','on');
[Fstat,pVal] = fTest(mdl);
fprintf('%s follow-up: R2 = %.2f, p = %.3f.\n',bands{bandidx},mdl.Rsquared.Adjusted,pVal);
figure('Color','white');
hold all
scatter(futable(:,2),futable(:,1),'filled');
b = mdl.Coefficients.Estimate;
plot(futable(:,2),b(1)+b(2)*futable(:,2),'--','Color','black');

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
export_fig(sprintf('figures/measurefu_%s_%s.eps',measure,bands{bandidx}));
close(gcf);

end

function [f,p] = fTest(model)
% F test for whole model (assumes constant term)
ssr = model.SST - model.SSE;
nobs = model.NumObservations;
dfr = model.NumEstimatedCoefficients - 1;
dfe = nobs - 1 - dfr;
f = (ssr./dfr) / (model.SSE/dfe);
p = fcdf(1./f,dfe,dfr); % upper tail
end
