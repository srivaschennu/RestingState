function testpower(listname,conntype,bandidx,varargin)

loadpaths

param = finputcheck(varargin, {
    'xlim', 'real', [], []; ...
    'ylim', 'real', [], []; ...
    'plotinfo', 'string', {'on','off'}, 'on'; ...
    'legend', 'string', {'on','off'}, 'on'; ...
    'legendposition', 'string', {}, ''; ...
    });

fontname = 'Helvetica';
fontsize = 28;

load(sprintf('%s/%s/alldata_%s_%s.mat',filepath,conntype,listname,conntype));
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
%     'E71'
%     'E76'
%     'E66'
%     'E84'
    };

for e = 1:length(occipital)
    chanidx = find(strcmp(occipital{e},{sortedlocs.labels}));
    if isempty(chanidx)
        error('Channel %s not found!',occipital{e});
    end
    occipital{e} = chanidx;
end
occipital = cell2mat(occipital);

loadsubj
subjlist = allsubj;
crs = cell2mat(subjlist(:,7));
% crs = cell2mat(subjlist(:,3));
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
testdata = mean(mean(allcoh(:,bandidx,:,:),4),3);
% testdata = mean(bandpower(:,bandidx,:),3)*100;

tennisidx = logical(tennis((grp == 0 | grp == 1) & ~v2idx));

% [pval,~,stats] = ranksum(testdata(grp == 2),testdata((grp == 0 | grp == 1) & ~v2idx));
[~,pval,~,stats] = ttest2(testdata(grp == 2),testdata((grp == 0 | grp == 1) & ~v2idx),[],[],'unequal');
fprintf('%s band power: Ctrl - Pat = %.2f, t = %.2f, p = %.3f.\n',...
    bands{bandidx},mean(testdata(grp == 2))-mean(testdata((grp == 0 | grp == 1) & ~v2idx)),...
    stats.tstat,pval);

%% compare vs to mcs patients
% [pval,~,stats] = ranksum(testdata(grp == 1 & ~v2idx),testdata(grp == 0 & ~v2idx));
% [~,pval,~,stats] = ttest2(testdata(grp == 1 & ~v2idx),testdata(grp == 0 & ~v2idx),'Vartype','unequal');
% fprintf('%s band power: MCS - VS = %.2f, t = %.2f, p = %.3f.\n',...
%     bands{bandidx},mean(testdata(grp == 1 & ~v2idx))-mean(testdata(grp == 0 & ~v2idx)),...
%     stats.tstat,pval);

% %% compare power between imagers and non-imagers
% [pval,~,stats] = ranksum(testdata(~tennisidx),testdata(tennisidx));
% fprintf('Imagers vs non-imagers %s band power: Mann-Whitney U = %.2f, p = %.3f.\n',bands{bandidx},stats.ranksum,pval);

% %% correlate peak freq with crs
% peakdata = mean(bandpeak((grp == 0 | grp == 1) & ~v2idx,bandidx,occipital),3);
% % [rho,pval] = corr(crs((grp == 0 | grp == 1) & ~v2idx),testdata,'type','spearman');
% % fprintf('%s band peak: Spearman rho = %.2f, p = %.3f.\n',bands{bandidx},rho,pval);
% 
% datatable = sortrows(cat(2,...
%     crs((grp == 0 | grp == 1) & ~v2idx),...
%     peakdata((grp == 0 | grp == 1) & ~v2idx),...
%     tennisidx,...
%     grp((grp == 0 | grp == 1) & ~v2idx)),...
%     2);
% mdl = LinearModel.fit(datatable(:,2),datatable(:,1),'RobustOpts','on');
% fprintf('%s band peak: R2 = %.2f, p = %.3f.\n',bands{bandidx},mdl.Rsquared.Adjusted,doftest(mdl));
% exmdl = LinearModel.fit(datatable(:,2),datatable(:,1),'RobustOpts','on','Exclude',find(datatable(:,4) == 0));
% fprintf('%s band peak (excl): R2 = %.2f, p = %.3f.\n',bands{bandidx},exmdl.Rsquared.Adjusted,doftest(exmdl));

% figure('Color','white'); hold all
% %VS
% scatter(datatable(datatable(:,4) == 0 & datatable(:,3) == 0,2), ...
%     datatable(datatable(:,4) == 0 & datatable(:,3) == 0,1),'red');
% scatter(datatable(datatable(:,4) == 0 & datatable(:,3) == 1,2), ...
%     datatable(datatable(:,4) == 0 & datatable(:,3) == 1,1),'red','filled');
% %MCS
% scatter(datatable(datatable(:,4) == 1 & datatable(:,3) == 0,2), ...
%     datatable(datatable(:,4) == 1 & datatable(:,3) == 0,1),'blue');
% scatter(datatable(datatable(:,4) == 1 & datatable(:,3) == 1,2), ...
%     datatable(datatable(:,4) == 1 & datatable(:,3) == 1,1),'blue','filled');
% 
% b = mdl.Coefficients.Estimate;
% plot(datatable(:,2),b(1)+b(2)*datatable(:,2),'--','Color','black');
% b = exmdl.Coefficients.Estimate;
% plot(datatable(:,2),b(1)+b(2)*datatable(:,2),'-','Color','black');
% 
% xlabel(sprintf('%s peak (Hz)',bands{bandidx}),'FontName',fontname,'FontSize',fontsize);
% ylabel('CRS-R score','FontName',fontname,'FontSize',fontsize);

%% correlate power and crs
% [rho,pval] = corr(crs((grp == 0 | grp == 1) & ~v2idx),testdata((grp == 0 | grp == 1) & ~v2idx),'type','spearman');
% fprintf('%s band power: Spearman rho = %.2f, p = %.3f.\n',bands{bandidx},rho,pval);

datatable = sortrows(cat(2,...
    crs((grp == 0 | grp == 1) & ~v2idx),...
    testdata((grp == 0 | grp == 1) & ~v2idx),...
    tennisidx,...
    grp((grp == 0 | grp == 1) & ~v2idx)),...
    2);
mdl = LinearModel.fit(datatable(:,2),datatable(:,1),'RobustOpts','on');
fprintf('%s band power: R2 = %.2f, p = %.3f.\n',bands{bandidx},mdl.Rsquared.Adjusted,doftest(mdl));
% exmdl = LinearModel.fit(datatable(:,2),datatable(:,1),'RobustOpts','on','Exclude',find(datatable(:,4) == 0 & datatable(:,3) == 1));
% fprintf('%s band power (excl): R2 = %.2f, p = %.3f.\n',bands{bandidx},exmdl.Rsquared.Adjusted,doftest(exmdl));

figure('Color','white'); hold all
%VS
% legendoff(scatter(datatable(datatable(:,4) == 0 & datatable(:,3) == 0,2), ...
%     datatable(datatable(:,4) == 0 & datatable(:,3) == 0,1),'red'));
% legendoff(scatter(datatable(datatable(:,4) == 0 & datatable(:,3) == 1,2), ...
%     datatable(datatable(:,4) == 0 & datatable(:,3) == 1,1),'red','filled'));
legendoff(scatter(datatable(datatable(:,4) == 0,2),datatable(datatable(:,4) == 0,1),'red','filled'));
%MCS
% legendoff(scatter(datatable(datatable(:,4) == 1 & datatable(:,3) == 0,2), ...
%     datatable(datatable(:,4) == 1 & datatable(:,3) == 0,1),'blue'));
% legendoff(scatter(datatable(datatable(:,4) == 1 & datatable(:,3) == 1,2), ...
%     datatable(datatable(:,4) == 1 & datatable(:,3) == 1,1),'blue','filled'));
legendoff(scatter(datatable(datatable(:,4) == 1,2),datatable(datatable(:,4) == 1,1),'blue','filled'));

b = mdl.Coefficients.Estimate;
plot(datatable(:,2),b(1)+b(2)*datatable(:,2),'-','Color','black',...
    'Display',sprintf('R^2 = %.2f, p = %.3f',mdl.Rsquared.Adjusted,doftest(mdl)));
% b = exmdl.Coefficients.Estimate;
% plot(datatable(:,2),b(1)+b(2)*datatable(:,2),'--','Color','black',...
%     'Display',sprintf('R^2 = %.2f, p = %.3f',exmdl.Rsquared.Adjusted,doftest(exmdl)));

set(gca,'FontName',fontname,'FontSize',fontsize);
if ~isempty(param.xlim)
    set(gca,'XLim',param.xlim);
end
if ~isempty(param.ylim)
    set(gca,'YLim',param.ylim);
end
xlabel(sprintf('%s power (%%)',bands{bandidx}),'FontName',fontname,'FontSize',fontsize);
if strcmp(param.plotinfo','on')
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
export_fig(gcf,sprintf('figures/crscorr_power_%s.eps',bands{bandidx}));
close(gcf);

futable = sortrows(cat(2,...
    crs(v2idx)-crs(v1idx),...
    testdata(v1idx)),...
    2);

% %% correlate follow-up power with crs
% % [rho, pval] = corr(futable(:,1),futable(:,2),'type','spearman');
% % fprintf('Follow-up: Spearman rho = %.2f, p = %.3f.\n',rho,pval);
% mdl = LinearModel.fit(futable(:,2),futable(:,1),'RobustOpts','off');
% fprintf('%s follow-up: R2 = %.2f, p = %.3f.\n',bands{bandidx},mdl.Rsquared.Adjusted,doftest(mdl));
% 
% figure('Color','white');
% hold all
% legendoff(scatter(futable(:,2),futable(:,1),'filled'));
% b = mdl.Coefficients.Estimate;
% plot(futable(:,2),b(1)+b(2)*futable(:,2),'-','Color','black',...
%     'Display',sprintf('R^2 = %.2f, p = %.3f',mdl.Rsquared.Adjusted,doftest(mdl)));
% 
% set(gca,'FontName',fontname,'FontSize',fontsize);
% if ~isempty(param.xlim)
%     set(gca,'XLim',param.xlim);
% end
% if ~isempty(param.ylim)
%     set(gca,'YLim',param.ylim);
% end
% xlabel(sprintf('Visit 1 %s power (%%)',bands{bandidx}),'FontName',fontname,'FontSize',fontsize);
% if strcmp(param.plotinfo,'on')
%     ylabel('Visit 2 - Visit 1 CRS-R','FontName',fontname,'FontSize',fontsize);
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
% export_fig(sprintf('figures/powerfu_%s.eps',bands{bandidx}));
% close(gcf);
end