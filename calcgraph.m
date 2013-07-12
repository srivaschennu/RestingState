function calcgraph(listname)

loadpaths

loadsubj

load chanlist

subjlist = eval(listname);

tvals = 1:-0.05:0.25;

load graphdata_allsubj_pli

for s = 1:size(subjlist,1)
    basename = subjlist{s,1};
    fprintf('Processing %s.',basename);
    
    load([filepath basename 'plifdr.mat']);
    
    [~,sortidx] = sort({chanlocs.labels});
    matrix = matrix(:,sortidx,sortidx);
    pval = pval(:,sortidx,sortidx);
    
    for f = 1:3
        cohmat = squeeze(matrix(f,:,:));
        
%         for thresh = 1:length(tvals)
%             if mean(degrees_und(threshold_proportional(zeromean(cohmat),tvals(thresh)))) < log(size(cohmat,1))
%                 break
%             end
%         end
%         
%         threshcoh = threshold_proportional(zeromean(cohmat),tvals(thresh-1));
%         bincohmat = double(threshcoh ~= 0);
%         fprintf(' %.2f',tvals(thresh-1));
%         
%         %threshold value
%         graph{8,1} = 'threshold';
%         graph{8,2}(s,f) = tvals(thresh-1);
        
        for thresh = 1:length(tvals)
            fprintf(' %d',thresh);
            threshcoh = threshold_proportional(zeromean(cohmat),tvals(thresh));
            bincohmat = double(threshcoh ~= 0);
            
%             %randomisation
%             threshcoh = randmio_und(threshcoh,15);
%             bincohmat = randmio_und(bincohmat,15);
            
            %clustering coeffcient
            graph{1,1} = 'clustering';
            graph{1,2}(s,f,thresh,1:length(chanlocs)) = mean(clustering_coef_wu(threshcoh));
            graph{1,3}(s,f,thresh,1:length(chanlocs)) = mean(clustering_coef_bu(bincohmat));
            
            
            %characteristic path length
            graph{2,1} = 'characteristic path length';
            graph{2,2}(s,f,thresh) = charpath(distance_wei(1./threshcoh));
            graph{2,3}(s,f,thresh) = charpath(distance_bin(bincohmat));
            
            %global efficiency
            graph{3,1} = 'global efficiency';
            graph{3,2}(s,f,thresh) = efficiency_wei(threshcoh);
            graph{3,3}(s,f,thresh) = efficiency_bin(bincohmat);
            
            %%% modularity
            graph{4,1} = 'modularity';
            graph{5,1} = 'modules';
            
            %weighted
            [Ci, Q] = modularity_louvain_und(threshcoh);
            graph{4,2}(s,f,thresh) = Q;
            graph{5,2}(s,f,thresh,1:length(chanlocs)) = Ci;
            
            %modular distance
            graph{7,1} = 'modular distance';
            dist(s,f,thresh) = 0;
            for m = 1:max(Ci)
                distmat = chandist(Ci == m,Ci == m) .* threshcoh(Ci == m,Ci == m);
                dist(s,f,thresh) = dist(s,f,thresh) + mean(mean(distmat));
            end
            graph{7,2}(s,f,thresh) = dist(s,f,thresh) / max(Ci);
            
            
            %binary
            [Ci, Q] = modularity_louvain_und(bincohmat);
            graph{4,3}(s,f,thresh) = Q;
            graph{5,3}(s,f,thresh,1:length(chanlocs)) = Ci;
            
            %modular distance
            dist(s,f,thresh) = 0;
            for m = 1:max(Ci)
                distmat = chandist(Ci == m,Ci == m) .* bincohmat(Ci == m,Ci == m);
                dist(s,f,thresh) = dist(s,f,thresh) + mean(mean(distmat));
            end
            graph{7,3}(s,f,thresh) = dist(s,f,thresh) / max(Ci);
            
            %betweenness (centrality)
            graph{6,1} = 'centrality';
            graph{6,2}(s,f,thresh,1:length(chanlocs)) = betweenness_wei(1./threshcoh);
            graph{6,3}(s,f,thresh,1:length(chanlocs)) = betweenness_bin(bincohmat);
            
        end
    end
    fprintf('\n');
    grp(s,1) = subjlist{s,2};
end

save(sprintf('graphdata_%s_pli.mat',listname), 'graph', 'grp', 'tvals');

