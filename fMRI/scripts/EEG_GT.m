% IG 14/01/2013 Calculate GT measures for EEG
clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');
Resultsdir = [Homedir filesep 'results\'];
load([Resultsdir 'bigmat'])
Freq = 5; %2=theta 3=alpha

for isubj = 1:12
    netwcor(:,:) = bigmat(isubj,Freq,:,:);
    
    GraphData(isubj,1) = mean(netwcor(:));
    GraphData(isubj,2) = std(netwcor(:));
    % weighted
    GraphData(isubj,3) = mean(clustering_coef_wu(netwcor));
    GraphData(isubj,4) = efficiency_wei(netwcor);
    [Ci Q] = modularity_louvain_und(netwcor);
    GraphData(isubj,5) = Q;
    GraphData(isubj,6) = max(Ci);
    GraphData(isubj,7) = mean(nonzeros(betweenness_wei(1./netwcor)));
    netwcor(netwcor > 0) = 1;
    % unweighted
    GraphData(isubj,8) = mean(clustering_coef_bu(netwcor));
    GraphData(isubj,9) = efficiency_bin(netwcor);
    [Ci Q] = modularity_louvain_und(netwcor);
    GraphData(isubj,10) = Q;
    GraphData(isubj,11) = max(Ci);
    GraphData(isubj,12) = mean(nonzeros(betweenness_bin(netwcor)));
end %isubj