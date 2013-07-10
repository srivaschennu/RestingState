function batchrun(listname)

loadsubj
loadpaths
subjlist = eval(listname);

for s = 1:length(subjlist)
    basename = subjlist{s};
    
    fprintf('Processing %s.\n',basename);
    
    %     dataimport(basename);
    %     epochdata(basename);
    
%        rejartifacts2([basename '_epochs'],1,4,[],[],1000,500);
    
    %     computeic([basename '_epochs']);
    
%         rejectic(basename,'skip','on');
%         rejartifacts2(basename,2,1);
    
        calcspectra(basename);
        plotspec(basename);
        close(gcf);
    
%     load([filepath basename 'plifdr.mat']);
%     plotgraph(squeeze(matrix(3,:,:)),chanlocs,0.95);
%     saveas(gcf,['figures/' basename 'pligraph.jpg']);
%     close(gcf);
end