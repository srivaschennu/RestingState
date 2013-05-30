% SC 16/11/12 Calculate GT measures on distance weighted correlation matrix
clear all
% close all
Value=1; %1 for patients 2 for balls out 3 for healthy subjects
Resultsdir = fullfile('C:','Users','Ithabi','Documents','results',filesep);
if Value==3;
    Resultsdir = [Resultsdir filesep 'PropRest_'];
    GraphFile = [Resultsdir 'GraphData.mat'];
    WcorFile = [Resultsdir 'Wcor_168_CI.mat'];
    load(WcorFile);
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
load(GraphFile);

nets=1;
i=1;
for isubj = 1:length(Wcor);
    isubj
    x = [33,54,88,121,142]; %only do 4 Networks
    y = [0 169];
    if Value==3;
        Image = abs(Wcor(1,isubj).sorted_FDR_r);
    elseif Value==2
        Image = abs(Wcor(1,isubj).corrected.sorted_FDR_r);
        ballsin = find(sum(Image,1) ~= 0);
    else
        Image = abs(Wcor(1,isubj).corrected.sorted_WFDR_r);
    end
    
    
    for net=1:length(x)-1
        if Value == 2
            netwcor = Image(intersect(ballsin,x(net):x(net+1)-1) ,intersect(ballsin,x(net):x(net+1)-1));
        else
            netwcor = Image(x(net):x(net+1)-1 ,x(net):x(net+1)-1);
        end
        
        GraphData(nets,1) = mean(nonzeros(netwcor(:)));
        GraphData(nets,2) = std(nonzeros(netwcor(:)));
        % weighted
        GraphData(nets,3) = mean(clustering_coef_wu(netwcor));
        GraphData(nets,4) = efficiency_wei(netwcor);
        [Ci Q] = modularity_louvain_und(netwcor);
        GraphData(nets,5) = Q;
        GraphData(nets,6) = max(Ci);
        GraphData(nets,7) = mean(nonzeros(betweenness_wei(1./netwcor))); % centrality
        
        netwcor(netwcor > 0) = 1;
        % unweighted
        GraphData(nets,8) = mean(clustering_coef_bu(netwcor));
        GraphData(nets,9) = efficiency_bin(netwcor);
        [Ci Q] = modularity_louvain_und(netwcor);
        GraphData(nets,10) = Q;
        GraphData(nets,11) = max(Ci);
        GraphData(nets,12 ) = mean(nonzeros(betweenness_bin(netwcor)));
        
        nets = nets+1;
        
        net=2;
        if Value == 2
            netwcor = Image(intersect(ballsin,x(net):x(net+1)-1) ,intersect(ballsin,x(net):x(net+1)-1));
        else
            netwcor = Image(x(net):x(net+1)-1 ,x(net):x(net+1)-1);
        end
        graphData(1,i) = mean(nonzeros(netwcor(:)));
        graphData(2,i) = std(nonzeros(netwcor(:)));
        % weighted
        graphData(3,i) = mean(clustering_coef_wu(netwcor));
        graphData(4,i) = efficiency_wei(netwcor);
        [Ci Q] = modularity_louvain_und(netwcor);
        graphData(5,i) = Q;
        graphData(6,i) = max(Ci);
        graphData(7,i) = mean(nonzeros(betweenness_wei(1./netwcor)));
        netwcor(netwcor > 0) = 1;
        % unweighted
        graphData(8,i) = mean(clustering_coef_bu(netwcor));
        graphData(9,i) = efficiency_bin(netwcor);
        [Ci Q] = modularity_louvain_und(netwcor);
        graphData(10,i) = Q;
        graphData(11,i) = max(Ci);
        graphData(12,i) = mean(nonzeros(betweenness_bin(netwcor)));
    end
    i = i+1;
    
end %isubj
MEAN = mean(graphData,2)

%IG_excell

WGraphData = GraphData;

% sprintf('%0.4f', GraphData)
%  a = round(GraphData*10^4)/10^4
save(GraphFile,'WGraphData')