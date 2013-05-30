% SC 16/11/12 Plot Correlation Figure
clear all
close all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
Resultsdir = [Homedir filesep 'results\PropRest_']
WcorFile = [Resultsdir 'Wcor_168_CI.mat'];%[Homedir filesep 'results\Wcor_168_CI.mat'];
GraphFile = [Resultsdir 'graphdata.mat'];%[Homedir filesep 'results\graphdata.mat'];
load(WcorFile);
%load(GraphFile);
%Subj = [1 2 3 5 7 8 12 14 16 19 20 21];
nets=1;
for i = 1:length(Wcor)
    %isubj = Subj(i);
    Image = abs(Wcor(1,i).sorted_FDR_r); %abs(Wcor(1,isubj).corrected.sorted_FDR_r);
    x = [33,54,88,121,142]; %only do 4 Networks
    y = [0 169];
    
    %         for net=1:length(x)-1
    %             netwcor = Image(x(net):x(net+1)-1 ,x(net):x(net+1)-1);
    %             graphdata(net,1,i) = mean(nonzeros(netwcor(:)));
    %             graphdata(net,2,i) = std(nonzeros(netwcor(:)));
    %             graphdata(net,3,i) = mean(clustering_coef_wu(netwcor));
    %             graphdata(net,4,i) = efficiency_wei(netwcor);
    %             [Ci Q] = modularity_louvain_und(netwcor);
    %             graphdata(net,5,i) = Q;
    %             graphdata(net,6,i) = max(Ci);
    %             graphdata(net,7,i) = mean(nonzeros(betweenness_wei(1./netwcor)));
    %         end
    %                 for net=1:length(x)-1
    %             netwcor = Image(x(net):x(net+1)-1 ,x(net):x(net+1)-1);
    %             Graphdata(1,net,i) = mean(nonzeros(netwcor(:)));
    %             Graphdata(2,net,i) = std(nonzeros(netwcor(:)));
    %             Graphdata(3,net,i) = mean(clustering_coef_wu(netwcor));
    %             Graphdata(4,net,i) = efficiency_wei(netwcor);
    %             [Ci Q] = modularity_louvain_und(netwcor);
    %             Graphdata(5,net,i) = Q;
    %             Graphdata(6,net,i) = max(Ci);
    %             Graphdata(7,net,i) = mean(nonzeros(betweenness_wei(1./netwcor)));
    %         end
  %%%%%%%% Default For excell
%     for net=1:length(x)-1
%         
%         netwcor = Image(x(net):x(net+1)-1 ,x(net):x(net+1)-1);
%         GraphData(nets,1) = mean(nonzeros(netwcor(:)));
%         GraphData(nets,2) = std(nonzeros(netwcor(:)));
%         GraphData(nets,3) = mean(clustering_coef_wu(netwcor));
%         GraphData(nets,4) = efficiency_wei(netwcor);
% %         [Ci Q] = modularity_louvain_und(netwcor);
% %         GraphData(nets,5) = Q;
% %         GraphData(nets,6) = max(Ci);
% %         GraphData(nets,7) = mean(nonzeros(betweenness_wei(1./netwcor)));
%         nets = nets+1
%     end

%%%%% sorted per network
        for net=2
            netwcor = Image(x(net):x(net+1)-1 ,x(net):x(net+1)-1);
            graphData(1,i) = mean(nonzeros(netwcor(:)));
            graphData(2,i) = std(nonzeros(netwcor(:)));
            graphData(3,i) = mean(clustering_coef_wu(netwcor));
            graphData(4,i) = efficiency_wei(netwcor);
            [Ci Q] = modularity_louvain_und(netwcor);
            graphData(5,i) = Q;
            graphData(6,i) = max(Ci);
            graphData(7,i) = mean(nonzeros(betweenness_wei(1./netwcor)));
        end
end %isubj
% sprintf('%0.4f', GraphData)
%  a = round(GraphData*10^4)/10^4
%save(GraphFile,'graphdata')