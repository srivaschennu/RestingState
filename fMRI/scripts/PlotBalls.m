% IG 19/11/12
% run function to plot balls on 3D space
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
NetwFile = [Homedir filesep 'results' filesep 'networks.mat'];
load(NetwFile)
Subj = [1 2 3 5 7 8 12 14 16 19 20 21];
for i = 6%1:length(Subj)
    isubj = Subj(i);
    Image = abs(Wcor(1,isubj).corrected.sorted_FDR_r);
    SC_plotgraph3(Image,networks(:,1),networks(:,[2 3 4]),0.97)
end