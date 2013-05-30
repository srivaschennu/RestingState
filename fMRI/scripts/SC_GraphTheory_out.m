% SC 16/11/12 Get Graph Theory measures
clear all
close all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
WcorFile = [Homedir filesep 'results\Wcor_168_CI.mat']; %_PropRest
GraphFile = [Homedir filesep 'results\graphdataOut.mat']; %PropRest_
load(WcorFile);
load(GraphFile);
Subj = [1 2 3 5 7 8 12 14 16 19 20 21];
for isubj = Subj%1:length(Wcor)
    isubj
    Image = abs(Wcor(1,isubj).out.sorted_FDR_r);%(Wcor(1,isubj).sorted.FDR_r);%abs(Wcor(1,isubj).corrected.sorted_FDR_r);
    x = Wcor(1,isubj).out.x; %[33,54,88,121,142]; %only do 4 Networks
    y = Wcor(1,isubj).out.y; %[0 169];
    
    for net=1:length(x)-1
         net
         netwcor = Image(x(net):x(net+1)-1 ,x(net):x(net+1)-1);
         
        graphdata(isubj,net,1) = mean(nonzeros(netwcor(:)));
        graphdata(isubj,net,2) = std(nonzeros(netwcor(:)));
        % weighted
        graphdata(isubj,net,3) = mean(clustering_coef_wu(netwcor));
        graphdata(isubj,net,4) = efficiency_wei(netwcor);
        [Ci Q] = modularity_louvain_und(netwcor);
        graphdata(isubj,net,5) = Q;
        graphdata(isubj,net,6) = max(Ci);
        graphdata(isubj,net,7) = mean(nonzeros(betweenness_wei(1./netwcor)));
        % unweighted
        graphdata(isubj,net,8) = mean(clustering_coef_bu(netwcor));
        graphdata(isubj,net,9) = efficiency_bin(netwcor);
        graphdata(isubj,net,10) = mean(nonzeros(betweenness_bin(netwcor))); 
    end
end %isubj

save(GraphFile,'graphdata')