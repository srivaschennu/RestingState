% IG 14/01/2013 Calculate GT measures for EEG
clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');
Resultsdir = [Homedir filesep 'results\'];
load([Resultsdir 'bigmatfmri'])
GraphFile = [Resultsdir 'EEG_GraphData.mat'];%[Homedir filesep 'results\graphdata.mat'];
load(GraphFile)
for ifreq = 1:5
    ifreq
    for isubj = 12:size(bigmat,1)
        isubj
        netwcor(:,:) = bigmat(isubj,ifreq,:,:);
        
        EEGData(isubj,1,ifreq) = mean(netwcor(:));
        EEGData(isubj,2,ifreq) = std(netwcor(:));
        % weighted
        EEGData(isubj,3,ifreq) = mean(clustering_coef_wu(netwcor));
        EEGData(isubj,4,ifreq) = efficiency_wei(netwcor);
        [Ci Q] = modularity_louvain_und(netwcor);
        EEGData(isubj,5,ifreq) = Q;
        EEGData(isubj,6,ifreq) = max(Ci);
        EEGData(isubj,7,ifreq) = mean(nonzeros(betweenness_wei(1./netwcor)));
        netwcor(netwcor > 0) = 1;
        % unweighted
        EEGData(isubj,8,ifreq) = mean(clustering_coef_bu(netwcor));
        EEGData(isubj,9,ifreq) = efficiency_bin(netwcor);
        [Ci Q] = modularity_louvain_und(netwcor);
        EEGData(isubj,10,ifreq) = Q;
        EEGData(isubj,11,ifreq) = max(Ci);
        EEGData(isubj,12,ifreq) = mean(nonzeros(betweenness_bin(netwcor)));
    end %isubj
end %ifreq
save(GraphFile,'EEGData')