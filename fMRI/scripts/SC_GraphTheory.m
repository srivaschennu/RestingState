% SC 16/11/12 Get Graph Theory measures
clear all
close all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
WcorFile = [Homedir filesep 'results\Wcor_168_CI.mat']; %_PropRest
GraphFile = [Homedir filesep 'results\graphdata.mat']; %PropRest_
load(WcorFile);
%load(GraphFile);
Subj = [1 2 3 5 7 8 12 14 16 19 20 21 23 26 27 28 31 32];
    x = [33,54,88,121,142]; %only do 4 Networks
    y = [0 169];
    i = 1;
for isubj = Subj%1:length(Wcor)
    Image = abs(Wcor(1,isubj).corrected.sorted_FDR_r);%abs(Wcor(1,isubj).out.sorted_FDR_r);%(Wcor(1,isubj).sorted.FDR_r);%
    for net=1:length(x)-1
         %net
         netwcor = Image(x(net):x(net+1)-1 ,x(net):x(net+1)-1);
         
        graphdata(i,net,1) = mean(nonzeros(netwcor(:)));
        graphdata(i,net,2) = std(nonzeros(netwcor(:)));
        % weighted
        graphdata(i,net,3) = mean(clustering_coef_wu(netwcor));
        graphdata(i,net,4) = efficiency_wei(netwcor);
        [Ci Q] = modularity_louvain_und(netwcor);
        graphdata(i,net,5) = Q;
        graphdata(i,net,6) = max(Ci);
        graphdata(i,net,7) = mean(nonzeros(betweenness_wei(1./netwcor)));
        
        netwcor(netwcor > 0) = 1;
        % unweighted
        graphdata(i,net,8) = mean(clustering_coef_bu(netwcor));
        graphdata(i,net,9) = efficiency_bin(netwcor);
        [Ci Q] = modularity_louvain_und(netwcor);
        graphdata(i,net,10) = Q;
        graphdata(i,net,11) = max(Ci);
        graphdata(i,net,12) = mean(nonzeros(betweenness_bin(netwcor))); 
    end
    i = i+1
end %isubj

 save(GraphFile,'graphdata')