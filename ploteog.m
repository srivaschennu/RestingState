function eogrsd = ploteog(basename)

loadpaths

fontname = 'Helvetica';
fontsize = 16;
ylimits = [0 5];

EEG = pop_loadset('filepath',filepath,'filename',[basename '_eog.set']);

for c = 1:EEG.nbchan
    eogrsd(c,:) = (squeeze(std(EEG.data(c,:,:),[],2)) / mean(squeeze(std(EEG.data(c,:,:),[],2))));
end
eogrsd = mean(eogrsd,1);

% figure('Color','white');
% figpos = get(gcf,'Position');
% 
% % figpos(4) = figpos(4)/3.8;
% figpos(4) = figpos(4)/5;
% 
% set(gcf,'Position',figpos);
% 
% plot(eogrsd,'LineWidth',1);
% 
% set(gca,'YLim',ylimits);
% 
% set(gca,'XTick',[],'YTick',[]);
% % set(gca,'YTick',ylimits,'FontName',fontname,'FontSize',fontsize-2);
% % xlabel('Time (sec)','FontName',fontname,'FontSize',fontsize);
% % ylabel('Norm. SD','FontName',fontname,'FontSize',fontsize);
% 
% box off
% 
% export_fig(gcf,sprintf('figures/%s_eog.eps',basename));
% close(gcf);
