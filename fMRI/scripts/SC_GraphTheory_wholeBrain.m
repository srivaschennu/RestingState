% SC 16/11/12 Get Graph Theory measures
clear all
close all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
WcorFile = [Homedir filesep 'results\Wcor_168_CI.mat']; %_PropRest
GraphWholeBrain = [Homedir filesep 'results\GraphWholeBrain.mat']; %PropRest_
load(WcorFile);
%load(GraphFile);
Subj = [1 2 3 5 7 8 12 14 16 19 20 21];
    x = [33,54,88,121,142]; %only do 4 Networks
    y = [0 169];
for isubj = 1:12%Subj%1:length(Wcor)
    i = Subj(isubj)
    Image = abs(Wcor(1,i).corrected.sorted_FDR_r);%abs(Wcor(1,isubj).out.sorted_FDR_r);%(Wcor(1,isubj).sorted.FDR_r);%
    netwcor = Image;
    %for net=1:length(x)-1
         %net
         %netwcor = Image(x(net):x(net+1)-1 ,x(net):x(net+1)-1);
         
        graphdata(isubj,1) = mean(nonzeros(netwcor(:)));
        graphdata(isubj,2) = std(nonzeros(netwcor(:)));
        % weighted
        graphdata(isubj,3) = mean(clustering_coef_wu(netwcor));
        graphdata(isubj,4) = efficiency_wei(netwcor);
        [Ci Q] = modularity_louvain_und(netwcor);
        graphdata(isubj,5) = Q;
        graphdata(isubj,6) = max(Ci);
        graphdata(isubj,7) = mean(nonzeros(betweenness_wei(1./netwcor)));
        
        % unweighted
        netwcor(netwcor > 0) = 1;
        graphdata(isubj,8) = mean(clustering_coef_bu(netwcor));
        graphdata(isubj,9) = efficiency_bin(netwcor);
        [Ci Q] = modularity_louvain_und(netwcor);
        graphdata(isubj,10) = Q;
        graphdata(isubj,11) = max(Ci); 
        graphdata(isubj,12) = mean(nonzeros(betweenness_bin(netwcor))); 
   % end
end %isubj

 save(GraphWholeBrain,'graphdata')