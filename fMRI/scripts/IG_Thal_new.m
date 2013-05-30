% IG 27/03/13 Make new Timeseries: 160 from original timeseries + 7 new ones (indexing to the right ball)
% recalculate corr matrices from new timeline
% go through all other steps untill GT und Corr calculations

clear all
load('timeseries.mat')
load('Thal_Balls')
for isubj = 1:16
    scansAll = timeseries_168(isubj).timeseries;
    scans = timeseries_168(isubj).timeseries(:,1:160);
    for iball = 1:7
        scans(:,160+iball) = scansAll(:,index(iball,isubj));
    end %iball
    timeseries_168(isubj).ts_thal = scans;
    figure;imagesc(timeseries_168(isubj).ts_thal)
end %isubj
save('timeseries.mat','timeseries_168')