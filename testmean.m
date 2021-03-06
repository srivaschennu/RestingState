function [testdata,grp,v2idx,v1idx,pval1,stats1] = testmean(listname,conntype,bandidx,varargin)

loadpaths

load(sprintf('%s/%s/alldata_%s_%s.mat',filepath,conntype,listname,conntype));

loadsubj
subjlist = allsubj;

param = finputcheck(varargin, {
    'xlim', 'real', [], []; ...
    'xtick', 'real', [], []; ...
    'ylim', 'real', [], []; ...
    'plotinfo', 'string', {'on','off'}, 'on'; ...
    'legend', 'string', {'on','off'}, 'on'; ...
    'legendposition', 'string', {}, ''; ...
    'xlabel', 'string', {}, 'wpli'; ...
    'exclude', 'string', {'on','off'}, 'off'; ...
    });

fontname = 'Helvetica';
fontsize = 28;

% powerdata = load(sprintf('alldata_%s.mat',listname));
% load chanlist

weiorbin = 3;
trange = [0.5 0.1];

crs = cell2mat(subjlist(:,7));
tennis = logical(cell2mat(subjlist(:,4)));

bands = {
    'Delta'
    'Theta'
    'Alpha'
    'Beta'
    'Gamma'
    };

v1idx = zeros(size(subjlist,1),1);
for s = 1:size(subjlist,1)
    if ~isempty(subjlist{s,5})
        v1idx(s) = find(strcmp(subjlist{s,5},subjlist(:,1)));
    end
end
v2idx = logical(v1idx);
v1idx = nonzeros(v1idx);

testdata = squeeze(mean(mean(allcoh(:,bandidx,:,:),4),3));
% testdata = squeeze(bandpower(:,bandidx,:));

%% test patients vs controls group difference
% [pval1,~,stats] = ranksum(testdata(grp == 2),testdata((grp == 0 | grp == 1) & ~v2idx));
[~,pval1,~,stats1] = ttest2(testdata(grp == 2),testdata((grp == 0 | grp == 1) & ~v2idx),[],[],'unequal');
fprintf('%s band: Ctrl %.2f, Pat %.2f, t(%.1f) = %.2f, p = %.3f.\n',...
    bands{bandidx},mean(testdata(grp == 2)),mean(testdata((grp == 0 | grp == 1) & ~v2idx)),stats1.df,stats1.tstat,pval1);

% %% compare vs to mcs patients
% [~,pval2,~,stats2] = ttest2(testdata(grp == 1 & ~v2idx),testdata(grp == 0 & ~v2idx),[],[],'unequal');
% fprintf('MCS vs. VS: t = %.2f, p = %.3f.\n',stats2.tstat,pval2);
% 
% %% compare measure between VS imagers and non-imagers
% % [pval,~,stats] = ranksum(testdata((grp == 0 | grp == 1) & ~v2idx & ~tennis),testdata((grp == 0 | grp == 1) & ~v2idx & tennis));
% [~,pval2,~,stats2] = ttest2(testdata(grp == 0 & ~v2idx & ~tennis),testdata(grp == 0 & ~v2idx & tennis),[],[],'unequal');
% fprintf('VS Imagers vs non-imagers: t = %.2f, p = %.3f.\n',stats2.tstat,pval2);

%% correlate patients with crs scores

datatable = sortrows(cat(2,...
    crs((grp == 0 | grp == 1) & ~v2idx),...
    testdata((grp == 0 | grp == 1) & ~v2idx,:),...
    tennis((grp == 0 | grp == 1) & ~v2idx),...
    grp((grp == 0 | grp == 1) & ~v2idx)),...
    2);
%     powerdata((grp == 0 | grp == 1) & ~v2idx)),...
for c = 1:91
mdl = LinearModel.fit(testdata((grp == 0 | grp == 1) & ~v2idx,c),crs((grp == 0 | grp == 1) & ~v2idx),'RobustOpts','on');
b(c,:) = mdl.Coefficients.Estimate;
pval(c) = doftest(mdl);
end

load chanlist
figure; topoplot(b(:,2),sortedlocs);

% fprintf('%s: R2 = %.2f, p = %.3f.\n',bands{bandidx},mdl.Rsquared.Adjusted,doftest(mdl));
% exmdl = LinearModel.fit(datatable(:,2),datatable(:,1),'RobustOpts','on','Exclude',find(datatable(:,4) == 0));
% fprintf('%s (excl): R2 = %.2f, p = %.3f.\n',bands{bandidx},exmdl.Rsquared.Adjusted,doftest(exmdl));

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
% legendoff(scatter(datatable(datatable(:,4) == 0,2),datatable(datatable(:,4) == 0,1),'red','filled'));
%MCS
legendoff(scatter(datatable(datatable(:,4) == 1 & datatable(:,3) == 0,2), ...
    datatable(datatable(:,4) == 1 & datatable(:,3) == 0,1),'blue'));
legendoff(scatter(datatable(datatable(:,4) == 1 & datatable(:,3) == 1,2), ...
    datatable(datatable(:,4) == 1 & datatable(:,3) == 1,1),'blue','filled'));
% legendoff(scatter(datatable(datatable(:,4) == 1,2),datatable(datatable(:,4) == 1,1),'blue','filled'));

p0311idx = 1;
legendoff(scatter(testdata(p0311idx),crs(p0311idx),100,'black','LineWidth',2));
p1611idx = 3;
legendoff(scatter(testdata(p1611idx),crs(p1611idx),100,'black','LineWidth',2));

b = mdl.Coefficients.Estimate;
plot(datatable(:,2),b(1)+b(2)*datatable(:,2),'-','Color','black',...
    'Display',sprintf('R^2 = %.2f, p = %.3f',mdl.Rsquared.Adjusted,doftest(mdl)));
b = exmdl.Coefficients.Estimate;
plot(datatable(datatable(:,4) == 1,2),b(1)+b(2)*datatable(datatable(:,4) == 1,2),'--','Color','black',...
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

export_fig(sprintf('figures/crscorr_mean_%s.eps',bands{bandidx}));
close(gcf);

futable = sortrows(cat(2,...
    crs(v2idx)-crs(v1idx),...
    testdata(v1idx)),...
    2);
%     powerdata(v1idx)),...

% %% correlate follow-ups
% % [rho, pval] = corr(futable(:,1),futable(:,2),'type','spearman');
% % fprintf('Follow-up: Spearman rho = %.2f, p = %.3f.\n',rho,pval);
% 
% mdl = LinearModel.fit(futable(:,2),futable(:,1),'RobustOpts','off');
% fprintf('%s follow-up: R2 = %.2f, p = %.3f.\n',bands{bandidx},mdl.Rsquared.Adjusted,doftest(mdl));
% % powmdl = LinearModel.fit(futable(:,[2 3]),futable(:,1),'RobustOpts','off');
% % fprintf('%s follow-up with power: R2 = %.2f, p = %.3f.\n',bands{bandidx},powmdl.Rsquared.Adjusted,doftest(powmdl));
% 
% figure('Color','white');
% hold all
% legendoff(scatter(futable(:,2),futable(:,1),'filled'));
% 
% b = mdl.Coefficients.Estimate;
% plot(futable(:,2),b(1)+b(2)*futable(:,2),'-','Color','black',...
%     'Display',sprintf('R^2 = %.2f, p = %.3f',mdl.Rsquared.Adjusted,doftest(mdl)));
% % b = powmdl.Coefficients.Estimate;
% % plot(futable(:,2),b(1)+b(2)*futable(:,2),'--','Color','black',...
% %     'Display',sprintf('R^2 = %.2f, p = %.3f',powmdl.Rsquared.Adjusted,doftest(powmdl)));
% 
% set(gca,'FontName',fontname,'FontSize',fontsize);
% if ~isempty(param.xlim)
%     set(gca,'XLim',param.xlim);
% end
% if ~isempty(param.ylim)
%     set(gca,'YLim',param.ylim);
% end
% xlabel(sprintf('Visit1 %s %s',bands{bandidx},measure),'FontName',fontname,'FontSize',fontsize);
% if strcmp(param.plotinfo,'on')
%     ylabel('V2 CRS-R - V1 CRS-R','FontName',fontname,'FontSize',fontsize);
% else
%     ylabel(' ','FontName',fontname,'FontSize',fontsize);
% end
% if strcmp(param.legend,'on')
%     leg_h = legend('show');
%     if isempty(param.legendposition)
%         set(leg_h,'Location','Best');
%     else
%         set(leg_h,'Location',param.legendposition);
%     end
%     txt_h = findobj(leg_h,'type','text');
%     set(txt_h,'FontSize',fontsize-6,'FontWeight','bold')
%     legend('boxoff');
% end
% 
% export_fig(sprintf('figures/measurefu_%s_%s.eps',measure,bands{bandidx}));
% close(gcf);
% 
end