function testpower(listname,bandidx,varargin)

param = finputcheck(varargin, {
    'xlim', 'real', [], []; ...
    'ylim', 'real', [], []; ...
    'legend', 'string', {'on','off'}, 'on'; ...
    'plotinfo', 'string', {'on','off'}, 'on'; ...
    });

fontname = 'Helvetica';
fontsize = 28;

load(sprintf('alldata_%s.mat',listname));
load chanlist

bands = {
    'Delta'
    'Theta'
    'Alpha'
    'Beta'
    'Gamma'
    };

frontal = {
    'E16'
    'F3'
    'F4'
    'Fz'
    'E19'
    'E4'
    'E5'
    'E6'
    'E12'
    };

for e = 1:length(frontal)
    chanidx = find(strcmp(frontal{e},{sortedlocs.labels}));
    if isempty(chanidx)
        error('Channel %s not found!',frontal{e});
    end
    frontal{e} = chanidx;
end
frontal = cell2mat(frontal);

occipital = {
    'Oz'
    'O1'
    'O2'
    'E65'
    'E71'
    'E76'
    'E90'
    'E66'
    'E84'
    };

for e = 1:length(occipital)
    chanidx = find(strcmp(occipital{e},{sortedlocs.labels}));
    if isempty(chanidx)
        error('Channel %s not found!',occipital{e});
    end
    occipital{e} = chanidx;
end
occipital = cell2mat(occipital);

crs = cell2mat(subjlist(:,3));
tennis = cell2mat(subjlist(:,4));

v1idx = zeros(size(subjlist,1),1);
for s = 1:size(subjlist,1)
    if ~isempty(subjlist{s,5})
        v1idx(s) = find(strcmp(subjlist{s,5},subjlist(:,1)));
    end
end
v2idx = logical(v1idx);
v1idx = nonzeros(v1idx);

%% compare power between patients and controls
testdata = mean(bandpower(:,bandidx,:),3);
[pval,~,stats] = ranksum(testdata((grp == 0 | grp == 1) & ~v2idx),testdata(grp == 2 & ~v2idx));
fprintf('Pat vs Ctrl %s band power: Mann-whitney U = %.2f, p = %.3f.\n',bands{bandidx},stats.ranksum,pval);

%% compare power between imagers and non-imagers
tennisidx = logical(tennis((grp == 0 | grp == 1) & ~v2idx));
[pval,~,stats] = ranksum(testdata(~tennisidx),testdata(tennisidx));
fprintf('Imagers vs non-imagers %s band power: Mann-whitney U = %.2f, p = %.3f.\n',bands{bandidx},stats.ranksum,pval);

%% correlate peak freq with crs
% testdata = mean(bandpeak((grp == 0 | grp == 1) & ~v2idx,bandidx,:),3);
% [rho,pval] = corr(crs((grp == 0 | grp == 1) & ~v2idx),testdata,'type','spearman');
% fprintf('%s band peak: Spearman rho = %.2f, p = %.3f.\n',bands{bandidx},rho,pval);
%
% figure('Color','white'); hold all
% scatter(crs((grp == 0 | grp == 1) & ~v2idx),testdata);
% lsline
% xlabel('CRS-R score');
% ylabel(sprintf('Peak frequency in %s',bands{bandidx}));

%% correlate power and crs
testdata = mean(bandpower(:,bandidx,:),3);
% [rho,pval] = corr(crs((grp == 0 | grp == 1) & ~v2idx),testdata((grp == 0 | grp == 1) & ~v2idx)*100,'type','spearman');
% fprintf('%s band power: Spearman rho = %.2f, p = %.3f.\n',bands{bandidx},rho,pval);
datatable = sortrows(cat(2,crs((grp == 0 | grp == 1) & ~v2idx),...
    testdata((grp == 0 | grp == 1) & ~v2idx)*100,tennisidx));
mdl = LinearModel.fit(datatable(:,1),datatable(:,2),'RobustOpts','on');
[Fstat,pVal] = fTest(mdl);
fprintf('%s band power: R2 = %.2f, p = %.3f.\n',bands{bandidx},mdl.Rsquared.Adjusted,pVal);

figure('Color','white'); hold all
scatter(datatable(datatable(:,3) == 0,1),datatable(datatable(:,3) == 0,2),'filled');
scatter(datatable(datatable(:,3) == 1,1),datatable(datatable(:,3) == 1,2),'filled','red');
b = mdl.Coefficients.Estimate;
plot(datatable(:,1),b(1)+b(2)*datatable(:,1),'--','Color','black');

set(gca,'FontName',fontname,'FontSize',fontsize);
xlabel('CRS-R score','FontName',fontname,'FontSize',fontsize);
ylabel(sprintf('%s power (%%)',bands{bandidx}),'FontName',fontname,'FontSize',fontsize);
export_fig(gcf,sprintf('figures/crscorr_power_%s.eps',bands{bandidx}));
close(gcf);

futable = sortrows(cat(2,testdata(v1idx)*100,crs(v2idx)-crs(v1idx)));

%% correlate follow-up power with crs
% [rho, pval] = corr(futable(:,1),futable(:,2),'type','spearman');
% fprintf('Follow-up: Spearman rho = %.2f, p = %.3f.\n',rho,pval);
mdl = LinearModel.fit(futable(:,1),futable(:,2),'RobustOpts','on');
[Fstat,pVal] = fTest(mdl);
fprintf('%s follow-up: R2 = %.2f, p = %.3f.\n',bands{bandidx},mdl.Rsquared.Adjusted,pVal);

figure('Color','white');
hold all
scatter(futable(:,1),futable(:,2),'filled');
b = mdl.Coefficients.Estimate;
plot(futable(:,1),b(1)+b(2)*futable(:,1),'--','Color','black');

set(gca,'FontName',fontname,'FontSize',fontsize);
if ~isempty(param.xlim)
    set(gca,'XLim',param.xlim);
end
if ~isempty(param.ylim)
    set(gca,'YLim',param.ylim);
end
xlabel(sprintf('Visit 1 %s power (%%)',bands{bandidx}),'FontName',fontname,'FontSize',fontsize);
if strcmp(param.plotinfo,'on')
    ylabel('Visit 2 - Visit 1 CRS-R','FontName',fontname,'FontSize',fontsize);
else
    ylabel(' ','FontName',fontname,'FontSize',fontsize);
end
export_fig(sprintf('figures/powerfu_%s.eps',bands{bandidx}));
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