% SC 16/11/12 Plot Correlation Figure
clear all
close all
Value=1; %0 for Patients 1 for PropRest 2 for balls out
Homedir = fullfile('C:','Users','Ithabi','Documents');
Subj = [1 2 3 5 7 8 12 14 16 19 20 21];
if Value==1;
    Resultsdir = [Homedir filesep 'results\PropRest_'];
    GraphFile = [Resultsdir 'GraphData.mat'];
    WcorFile = [Resultsdir 'Wcor_168_CI.mat'];
    load(WcorFile);
    Subj = Wcor;
elseif Value==2
    Resultsdir = [Homedir filesep 'results\'];
    GraphFile = [Resultsdir 'Out_graphdata.mat'];
else
    Resultsdir = [Homedir filesep 'results\'];
    GraphFile = [Resultsdir 'graphdata.mat'];
end
WcorFile = [Resultsdir 'Wcor_168_CI.mat'];

load(WcorFile);
%load(GraphFile);

nets=1;
for i = 1:length(Subj)
    x = [33,54,88,121,142]; %only do 4 Networks
    y = [0 169];
    if Value==1;
        Image = abs(Wcor(1,i).sorted_FDR_r);
    elseif Value==2
        isubj=Subj(i);
        x = Wcor(1,isubj).out.x;
        y = Wcor(1,isubj).out.y;
        Image = abs(Wcor(1,isubj).out.sorted_FDR_r);
    else
        isubj=Subj(i);
        Image = abs(Wcor(1,isubj).corrected.sorted_FDR_r);
    end
    
    for net=2 %2 = DMN
        netwcor = Image(x(net):x(net+1)-1 ,x(net):x(net+1)-1);
        graphData(1,i) = mean(nonzeros(netwcor(:)));
        graphData(2,i) = std(nonzeros(netwcor(:)));
        % weighted
        graphData(3,i) = mean(clustering_coef_wu(netwcor));
        graphData(4,i) = efficiency_wei(netwcor);
        [Ci Q] = modularity_louvain_und(netwcor);
        graphData(5,i) = Q;
        graphData(6,i) = max(Ci);
        graphData(7,i) = mean(nonzeros(betweenness_wei(1./netwcor)));
        % unweighted
        graphData(8,i) = mean(clustering_coef_bu(netwcor));
        graphData(9,i) = efficiency_bin(netwcor);
        %graphData(10,i) = mean(nonzeros(betweenness_bin(netwcor)));    
    end
end %isubj
MEAN = mean(graphData,2)
% save(GraphFile,'GraphData')