function batchrun(listname)

loadsubj
loadpaths
subjlist = eval(listname);
load freqlist

for s = 1:length(subjlist)
    basename = subjlist{s};
%     batchrun{s,1} = basename;
%     batchrun{s,2} = subjlist{s,2};
    
    fprintf('Processing %s.\n',basename);
    
%     copyfile([filepath basename '.set'],[filepath 'commonfreq/' basename '.set']);
%     copyfile([filepath basename '.fdt'],[filepath 'commonfreq/' basename '.fdt']);
%     copyfile([filepath basename 'pliboot.mat'],[filepath 'commonfreq/' basename 'pliboot.mat']);
%     copyfile([filepath basename 'plifdr.mat'],[filepath 'commonfreq/' basename 'plifdr.mat']);
    
%     EEG = pop_loadset('filepath',filepath,'filename',[basename '.set']);
%     EEG = rereference(EEG,2);
%     pop_saveset(EEG,'savemode','resave');

%         dataimport(basename);
%         epochdata(basename);
    
%            rejartifacts2([basename '_epochs'],1,4,[],[],1000,500);
    
%         computeic([basename '_epochs']);
    
%             rejectic(basename);
    
%     EEG = pop_loadset('filepath',filepath,'filename',[basename '_epochs.set'],'loadmode','info');
%     batchrun{s,3} = sum(EEG.reject.gcompreject);
    
%             rejartifacts2(basename,2,1);
    
%             calcspectra(basename);


%             plotspec(basename);
%             export_fig(gcf,sprintf('figures/%sspectra.eps',basename));
%             close(gcf);
% %     
    %         fix1020(basename);
    
    coherence(basename);
    
%         load([filepath basename 'plifdr.mat']);
%         plotgraph(squeeze(matrix(3,:,:)),chanlocs,'plotqt',0.75,'legend','off');
%         export_fig(gcf,['figures/' basename 'pligraph.tif']);
%         close(gcf);

end
% save batchrun.mat batchrun