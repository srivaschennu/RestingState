function calcgraph(listname)

loadpaths

loadsubj

load chanlist

subjlist = eval(listname);

% degree = zeros(5,length(subjlist)*91);
% weight = zeros(5,length(subjlist)*91*91);

tvals = 1-(0:0.05:0.75);

for s = 1:size(subjlist,1)
    basename = subjlist{s,1};
    fprintf('Processing %s.',basename);
    
    
    load([filepath basename 'icohfdr.mat']);
    
    [~,sortidx] = sort({chanlocs.labels});
    matrix = matrix(:,sortidx,sortidx);
    pval = pval(:,sortidx,sortidx);
    
    for f = 1:3
        cohmat = squeeze(matrix(f,:,:));
        
        %         bincohmat = double(cohmat ~= 0);
        
        %         for thresh = 1:length(tvals)
        %             if mean(degrees_und(applythresh(cohmat,tvals(thresh)))) < log(size(cohmat,1))
        %                 break
        %             end
        %         end
        %         cohmat = applythresh(cohmat,tvals(thresh-1));
        
        for thresh = 1:length(tvals)
            fprintf(' %d',thresh);
            threshcoh = threshold_proportional(zeromean(cohmat),tvals(thresh));
            %bincohmat = double(threshcoh ~= 0);
            
            %clustering coeffcient
            graph{1,1} = 'clustering';
            graph{1,2}(s,f,thresh) = mean(clustering_coef_wu(threshcoh));
%             graph{1,3}(s,f,thresh) = mean(clustering_coef_bu(bincohmat));
            
            
            %characteristic path length and efficiency
            graph{2,1} = 'efficiency';
            graph{2,2}(s,f,thresh) = efficiency_wei(threshcoh);
%             graph{2,3}(s,f,thresh) = efficiency_bin(bincohmat);
            
            %%% modularity
            graph{3,1} = 'modularity';
            graph{4,1} = 'num modules';
            
            %weighted
            [Ci, Q] = modularity_louvain_und(threshcoh);
            graph{3,2}(s,f,thresh) = Q;
            graph{4,2}(s,f,thresh) = max(Ci);
            
            %modular distance
            graph{6,1} = 'modular distance';
            dist(s,f,thresh) = 0;
            for m = 1:max(Ci)
                distmat = chandist(Ci == m,Ci == m);% .* (threshcoh(Ci == m,Ci == m) > 0);
                dist(s,f,thresh) = dist(s,f,thresh) + mean(mean(distmat));
            end
            graph{6,2}(s,f,thresh) = dist(s,f,thresh) / max(Ci);
            
            
%             %binary
%             [Ci, Q] = modularity_louvain_und(bincohmat);
%             graph{3,3}(s,f,thresh) = Q;
%             graph{4,3}(s,f,thresh) = max(Ci);
%             
%             %modular distance
%             dist(s,f,thresh) = 0;
%             for m = 1:max(Ci)
%                 distmat = chandist(Ci == m,Ci == m);% .* (threshcoh(Ci == m,Ci == m) > 0);
%                 dist(s,f,thresh) = dist(s,f,thresh) + mean(mean(distmat));
%             end
%             graph{6,3}(s,f,thresh) = dist(s,f,thresh) / max(Ci);
            
            %betweenness (centrality)
            graph{5,1} = 'centrality';
            graph{5,2}(s,f,thresh) = median(nonzeros(betweenness_wei(1./threshcoh)));
%             graph{5,3}(s,f,thresh) = median(nonzeros(betweenness_bin(bincohmat)));
        end
    end
    fprintf('\n');
    grp(s,1) = subjlist{s,2};
end

save(sprintf('graphdata_%s.mat',listname), 'graph', 'grp', 'tvals');

