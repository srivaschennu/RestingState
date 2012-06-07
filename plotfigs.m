function plotfigs

loadpaths

load([filepath 'NW_restingstateicohboot']);
load chandist

alpha = 0.05;

for f = 1:size(matrix,1)
    coh = abs(squeeze(matrix(f,:,:)));
    pvals = squeeze(pval(f,:,:));
    
    %% FDR CORRECTION
    tmp_pvals = pvals(logical(triu(ones(size(pvals)),1)));
    tmp_coh = coh(logical(triu(ones(size(coh)),1)));
    
    [~, p_masked]= fdr(tmp_pvals,alpha);
    tmp_pvals(~p_masked) = 1;
    tmp_coh(tmp_pvals >= alpha) = 0;
    
    coh = zeros(size(coh));
    coh(logical(triu(ones(size(coh)),1))) = tmp_coh;
    coh = triu(coh,1)+triu(coh,1)';
    %%
    
    t = 0:25:200;
    for tidx = 1:length(t)
        randcoh = randmio_und(coh,t(tidx));
        cc(tidx) = mean(clustering_coef_wu(randcoh));
        cp(tidx) = charpath(distance_wei(1./randcoh));
    end
    figure; plot(t,cc(1:length(t))); figure; plot(t,cp(1:length(t)));
    
%     [Ci Q] = modularity_louvain_und(coh);
%     max(Ci)
%     Q
%     
%     moddist(f) = 0;
%     for m = 1:max(Ci)
%         moddist(f) = moddist(f) + mean(mean(chandist(Ci == m, Ci == m)));
%     end
%     moddist(f) = moddist(f)/max(Ci);
%     
%     plotgraph(coh,chanlocs,Ci,25);
end