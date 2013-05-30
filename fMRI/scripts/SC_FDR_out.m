clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
WcorFile = [Homedir filesep 'results\Wcor_168_CI.mat'];
load(WcorFile);
alpha = 0.05;
Subj = [1 2 3 5 7 8 12 14 16 19 20 21];
for isubj = [5 7 8 16 19 20 21,1,2,3,12,14] % Subj%2:length(Wcor)%
    isubj
    pvals = Wcor(1,isubj).out.pVal; % Wcor(1,isubj).pVal;
    coh = Wcor(1,isubj).out.scale3; % coh = coherence
    
    tmp_pvals = pvals(logical(triu(ones(size(pvals)),1))); %takes upper triangle of both corr and pval
    tmp_coh = coh(logical(triu(ones(size(coh)),1))); %coh=correlation values
    
    [~, p_masked]= fdr(tmp_pvals,alpha);%make vector from matrix
    tmp_pvals(~p_masked) = 1; %wherever mask is 0 p will be set to 1
    tmp_coh(tmp_pvals >= alpha) = 0; %setting background noise to 0
    
    coh = zeros(size(coh));
    coh(logical(triu(ones(size(coh)),1))) = tmp_coh;
    coh = triu(coh,1)+triu(coh,1)';
    
    pvals = zeros(size(pvals));
    pvals(logical(triu(ones(size(pvals)),1))) = tmp_pvals;
    pvals = triu(pvals,1)+triu(pvals,1)';
    
    Wcor(1,isubj).out.FDR_p = pvals;
    Wcor(1,isubj).out.FDR_r = coh;
end %isubj
save(WcorFile,'Wcor')