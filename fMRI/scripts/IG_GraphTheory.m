% SC 16/11/12 Plot Correlation Figure
clear all
% close all
Value=1; %1 for patients 2 for balls out 3 for healthy subjects
Resultsdir = fullfile('/Users/chennu/Work/RestingState','fMRI','results',filesep);
Subj = [1 2 3 5 7 8 12 14 16 19 20 21 23 26 27 28 31 32];
if Value==3;
    Resultsdir = [Resultsdir filesep 'PropRest_'];
    GraphFile = [Resultsdir 'GraphData.mat'];
    WcorFile = [Resultsdir 'Wcor_168_CI.mat'];
    load(WcorFile);
    Subj = 1:length(Wcor);
    Letter = 'D';
elseif Value==2
    GraphFile = [Resultsdir 'Out_graphdata.mat'];
    Letter = 'C';
else
    GraphFile = [Resultsdir 'graphdata.mat'];
    Letter = 'B';
end
WcorFile = [Resultsdir 'Wcor_168_CI_N16.mat'];

load(WcorFile);
%load(GraphFile);

i=1;
for isubj = 1:length(Wcor)
    isubj
    x = [33,54,88,121,142]; %only do 4 Networks
    y = [0 169];
    if Value==3;
        Image = abs(Wcor(1,isubj).sorted_FDR_r);
    elseif Value==2
        Image = abs(Wcor(1,isubj).corrected.sorted_FDR_r);
        ballsin = find(sum(Image,1) ~= 0);
    else
        Image = abs(Wcor(1,isubj).corrected.sorted_FDR_r);
    end
    
    
    for net=1:length(x)-1
        if Value == 2
            netwcor = Image(intersect(ballsin,x(net):x(net+1)-1) ,intersect(ballsin,x(net):x(net+1)-1));
        else
            netwcor = Image(x(net):x(net+1)-1 ,x(net):x(net+1)-1);
        end
        
        GraphData(isubj,1,net) = mean(nonzeros(netwcor(:)));
        GraphData(isubj,2,net) = std(nonzeros(netwcor(:)));
        % weighted
        GraphData(isubj,3,net) = mean(clustering_coef_wu(netwcor));
        GraphData(isubj,4,net) = efficiency_wei(netwcor);
        [Ci Q] = modularity_louvain_und(netwcor);
        GraphData(isubj,5,net) = Q;
        GraphData(isubj,6,net) = max(Ci);
        GraphData(isubj,7,net) = mean(nonzeros(betweenness_wei(1./netwcor))); % centrality
        
        netwcor(netwcor > 0) = 1;
        % unweighted
        GraphData(isubj,8,net) = mean(clustering_coef_bu(netwcor));
        GraphData(isubj,9,net) = efficiency_bin(netwcor);
        [Ci Q] = modularity_louvain_und(netwcor);
        GraphData(isubj,10,net) = Q;
        GraphData(isubj,11,net) = max(Ci);
        GraphData(isubj,12,net) = mean(nonzeros(betweenness_bin(netwcor)));
        
%         net=2;
%         if Value == 2
%             netwcor = Image(intersect(ballsin,x(net):x(net+1)-1) ,intersect(ballsin,x(net):x(net+1)-1));
%         else
%             netwcor = Image(x(net):x(net+1)-1 ,x(net):x(net+1)-1);
%         end
%         graphData(1,i) = mean(nonzeros(netwcor(:)));
%         graphData(2,i) = std(nonzeros(netwcor(:)));
%         % weighted
%         graphData(3,i) = mean(clustering_coef_wu(netwcor));
%         graphData(4,i) = efficiency_wei(netwcor);
%         [Ci Q] = modularity_louvain_und(netwcor);
%         graphData(5,i) = Q;
%         graphData(6,i) = max(Ci);
%         graphData(7,i) = mean(nonzeros(betweenness_wei(1./netwcor)));
%         netwcor(netwcor > 0) = 1;
%         % unweighted
%         graphData(8,i) = mean(clustering_coef_bu(netwcor));
%         graphData(9,i) = efficiency_bin(netwcor);
%         [Ci Q] = modularity_louvain_und(netwcor);
%         graphData(10,i) = Q;
%         graphData(11,i) = max(Ci);
%         graphData(12,i) = mean(nonzeros(betweenness_bin(netwcor)));
    end
end %isubj
% MEAN = mean(graphData,2)

%IG_excell


% sprintf('%0.4f', GraphData)
%  a = round(GraphData*10^4)/10^4
save(GraphFile,'GraphData')