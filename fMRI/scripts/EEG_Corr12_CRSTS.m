% IG 22/03/2013 CRS Correlations with Timeseries
clear all
load('timeseries_168_N16.mat')
load('CRS_Data.mat')
load('DOC_data.mat')
load('networks.mat')

% do correlation for mean activity over whole brain
for isubj = 1:length(timeseries_168)
    TS_subjMean(isubj,1) = mean(timeseries_168(isubj).timeseries(:));
end %isubj

[r,p] = corrcoef(TS_subjMean,CRS);
[r,p] = corrcoef(TS_subjMean,DOC);

index = [1 2 4 6 7 8 12 13 14 16]; % for using only TBI patients
[r,p] = corrcoef(TS_subjMean(index),CRS(index));
[r,p] = corrcoef(TS_subjMean(index),DOC(index));


% do correlation for mean activity per network
for inet = 1:7
    for isubj = 1:length(timeseries_168)
        NetTS = (timeseries_168(isubj).timeseries_sorted(:,networks == inet)); % 3 is for DMN
        NetTSmean(isubj,1) = mean(NetTS(:));
    end %isubj
    [r,p] = corrcoef(NetTSmean,CRS);P_CRS(inet) = p(2);
    [r,p] = corrcoef(NetTSmean,DOC);P_DOC(inet) = p(2);
    
    index = [1 2 4 6 7 8 12 13 14 16]; % for using only TBI patients
    [r,p] = corrcoef(NetTSmean(index),CRS(index));P_TBI_CRS(inet) = p(2);
    [r,p] = corrcoef(NetTSmean(index),DOC(index));P_TBI_DOC(inet) = p(2);
end % inet
P_TBI_CRS
P_TBI_DOC

% %plotting
% for isubj = 1:length(timeseries_168)
% figure;
% imagesc(timeseries_168(isubj).timeseries_sorted(:,networks == 3)) % 3 is for DMN
% colorbar; caxis([200 1000]);
% end %isubj
% 
% % unnecessary
% for isubj = 1:length(timeseries_168)
%     TS_subjMean(isubj,1) = mean(timeseries_168(isubj).timeseries_sorted(:));
% end %isubj