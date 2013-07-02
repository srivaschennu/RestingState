function calcgraph

loadpaths

loadsubj

load chanlist

%subjlist = cat(1,ctrllist,patlist);
%subjlist = ctrllist;
% subjlist = patlist;
subjlist = fmrilist;

% degree = zeros(5,length(subjlist)*91);
% weight = zeros(5,length(subjlist)*91*91);

for s = 1:size(subjlist,1)
    basename = subjlist{s,1};
    fprintf('Processing %s.\n',basename);
    
    
    load([filepath basename 'icohfdr.mat']);
    
    [~,sortidx] = sort({chanlocs.labels});
    matrix = matrix(:,sortidx,sortidx);
    pval = pval(:,sortidx,sortidx);
    
    for f = 1:size(matrix,1)
        cohmat = squeeze(matrix(f,:,:));
        
        %         degree(f,(s-1)*91+1:s*91) = mean(cohmat,1);
        %         weight(f,(s-1)*91*91+1:s*91*91) = cohmat(:)';
        
%         tvals = 0:0.01:1;
%         for t = 1:length(tvals)
%             if mean(degrees_und(applythresh(cohmat,tvals(t)))) < log(size(cohmat,1))
%                 break
%             end
%         end
%         cohmat = applythresh(cohmat,tvals(t-1));
        thresh = 1;
        
        %clustering coeffcient
        graph{1,1}(s,f,thresh) = mean(clustering_coef_wu(cohmat));
        graph{1,2} = 'clustering';
        
        %characteristic path length and efficiency with weights
        [~, graph{2,1}(s,f,thresh)] = charpath(distance_wei(1./cohmat));
        graph{2,2} = 'efficiency';
        
        %modularity
        [Ci, Q] = modularity_louvain_und(cohmat);
        graph{3,1}(s,f,thresh) = Q;
        graph{3,2} = 'modularity';
        graph{4,1}(s,f,thresh) = max(Ci);
        graph{4,2} = 'num modules';
        
        %betweenness (centrality)
        graph{5,1}(s,f,thresh) = median(nonzeros(betweenness_wei(1./cohmat)));
        graph{5,2} = 'centrality';
        
        %modular distance
        dist(s,f,thresh) = 0;
        for m = 1:max(Ci)
            distmat = chandist(Ci == m,Ci == m);% .* (cohmat(Ci == m,Ci == m) > 0);
            dist(s,f,thresh) = dist(s,f,thresh) + mean(mean(distmat));
        end
        graph{6,1}(s,f,thresh) = dist(s,f,thresh) / max(Ci);
        graph{6,2} = 'modular distance';
    end
    grp(s,1) = subjlist{s,2};
end

save graphdata.mat graph grp %tvals

