load distinfo.mat

load meanmat_ctrl

alpha = squeeze(matrix(3,:,:));
plotqt = quantile(nonzeros(alpha),0.75);
alpha = applythresh(alpha,plotqt);
plotgraph2(alpha,chanlocs,degree(3,:),weight(3,:),0.95);
