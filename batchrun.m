function batchrun

loadpaths

alpha = 0.05;

ctrllist = {
    %     controls
    
    %     'jenny_restingstate'
    %     %'SaltyWater_restingstate'
    'NW_restingstate'
    'p37_restingstate'
    'p38_restingstate'
    'p40_restingstate'
    'p41_restingstate'
    'p42_restingstate'
    'p43_restingstate'
    'p44_restingstate'
    'p45_restingstate'
    'p46_restingstate'
    'p47_restingstate'
    'p48_restingstate'
    'p49_restingstate'
    % 'p50_restingstate'
    'subj01_restingstate'
    'subj02_restingstate'
    'VS_restingstate'
    'SS_restingstate'
    'SB_restingstate'
    'ML_restingstate'
    'MC_restingstate'
    'JS_restingstate'
    % 'FD_restingstate'
    'ET_restingstate'
    'EP_restingstate'
    % 'CS_restingstate'
    'CL_restingstate'
    'CD_restingstate'
    'AC_restingstate'
    };

patlist = {
    %
    % patients
    
    'p0112_restingstate'
    'p0211V2_restingstate'
    'p0211_restingstate1'
    'p0211_restingstate2'
    'p0311V2_restingstate'
    'p0311_restingstate1'
    'p0311_restingstate2'
    % 'p0411V2_restingstate'
    'p0411_restingstate1'
    % 'p0411_restingstate2'
    'p0510V2_restingstate'
    % 'p0511V2_restingstate'
    % 'p0511_restingstate'
    'p0611_restingstate'
    'p0710V2_restingstate'
    'p0711_restingstate'
    'p0811_restingstate'
    'p0911_restingstate'
    'p1011_restingstate'
    'p1311_restingstate'
    'p1511_restingstate'
    'p1611_restingstate'
    'p1711_restingstate'
    'p1811_restingstate'
    'p1911_restingstate'
    'p2011_restingstate'
    % 'p2111_restingstate'
    
    };

subjlist = cat(1,ctrllist,patlist);

%load distinfo.mat
load chanlist.mat

meanmat = zeros(5,91,91);

for s = 1:length(subjlist)
    basename = subjlist{s};
    fprintf('Processing %s.\n',basename);
    
    %computeic(basename);
    
    
    load([filepath basename 'icohfdr.mat']);
    [sortedchan,sortidx] = sort({chanlocs.labels});

    if ~strcmp(chanlist,cell2mat(sortedchan))
        error('Channel names do not match!');
    end
    
    for f = 1:size(matrix,1)
        icohmat = squeeze(matrix(f,sortidx,sortidx));
        pvals = squeeze(pval(f,sortidx,sortidx));
        chanlocs = chanlocs(sortidx);
        
        meanmat(f,:,:) = squeeze(meanmat(f,:,:)) + icohmat;
        
%         
%         tmp_pvals = pvals(logical(triu(ones(size(pvals)),1)));
%         tmp_coh = icohmat(logical(triu(ones(size(icohmat)),1)));
%         
%         [~, p_masked]= fdr(tmp_pvals,alpha);
%         tmp_pvals(~p_masked) = 1;
%         tmp_coh(tmp_pvals >= alpha) = 0;
%         
%         icohmat = zeros(size(icohmat));
%         icohmat(logical(triu(ones(size(icohmat)),1))) = tmp_coh;
%         icohmat = triu(icohmat,1)+triu(icohmat,1)';
%         
%         matrix(f,:,:) = icohmat;
%         if f == 3
%             plotgraph2(icohmat,chanlocs,degree(f,:),weight(f,:),0.9);
%             saveas(gcf,sprintf('figures/%s_%d.fig', basename, f));
%             close(gcf);
%         end
%     end
%     
%     save([filepath basename 'icohfdr.mat'],'matrix','pval','chanlocs');
% end
%         tvals = 0:0.05:0.3;
%         for t = 1:length(tvals)
%             icohmat = applythresh(icohmat,tvals(t));
%             
%             [Ci, Q] = modularity_louvain_und(icohmat);
%             mod(s,f,t) = Q;
% %            bet(s,f,t) = mean(nonzeros(betweenness_wei(1./icohmat)));
%             
%             dist(s,f,t) = 0;
%             for m = 1:max(Ci)
%                 distmat = chandist(Ci == m,Ci == m) .* (icohmat(Ci == m,Ci == m) > 0);
%                 dist(s,f,t) = dist(s,f,t) + mean(distmat(logical(triu(ones(size(distmat)),1))));
%             end
%             dist(s,f,t) = dist(s,f,t) / max(Ci);
%             
% %             maxci(s,f,t) = max(Ci);
% %             clust(s,f,t) = mean(clustering_coef_wu(icohmat)); %clustering coeffcient
% %             charp(s,f,t) = charpath(distance_wei(1./icohmat)); %characteristic path length with weights
%        end
%         
%         if s > length(ctrllist)
%             grp(s,1) = 2;
%         else
%             grp(s,1) = 1;
%         end
%         
    end
end

meanmat = meanmat ./ length(subjlist);
matrix = meanmat;
save meanmat.mat matrix chanlocs

% save batch.mat grp tvals mod dist %bet maxci clust charp

% function matrix = applythresh(matrix,thresh)
% 
% matrix(matrix < thresh) = 0;
% end