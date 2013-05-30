% IG 06/11/12 Look at correlation values for balls out of cortex subject 16656
clear all
close all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
load([Homedir filesep 'results\Wcor_168_CI.mat']);
load([Homedir filesep 'results\timeseries_168.mat']);

BallsIn = [92,106,108,115,118,126,152];
BallsEdge = [47,90,93,98,109,112,113,120,127,138,142,145,156,157,160];
BallsAll = sort([BallsIn BallsEdge]);

figure;imagesc(Wcor(1,2).scale3); colorbar
figure;imagesc(Wcor(1,2).scale3(BallsIn,:)); colorbar
figure;imagesc(Wcor(1,2).scale3(BallsEdge,:)); colorbar
figure;imagesc(Wcor(1,2).scale3(BallsAll,:)); colorbar
figure;imagesc(Wcor(1,2).sorted.scale3); colorbar

WcorMod = Wcor(1,2).scale3;
for i = BallsAll
    WcorMod(:,i)= 0;
    WcorMod(i,:)= 0;
end %i
figure;imagesc(WcorMod); colorbar

mWcor = mean(mean(Wcor(1,2).scale3))
WcorMod = Wcor(1,2).scale3;
for i = BallsAll
    WcorMod(:,i)= mWcor;
    WcorMod(i,:)= mWcor;
end %i
figure;imagesc(WcorMod); colorbar

plot(Wcor(1,2).scale3(BallsIn,:)')
plot(Wcor(1,2).scale3(BallsEdge,:)')
plot(Wcor(1,2).scale3')

Rmin = min(Wcor(1,2).scale3);
Rmax = max(Wcor(1,2).scale3);

plot(Rmin)

TS = timeseries_168(1,2).timeseries;
figure; plot(TS)
figure; imagesc(TS)
set(gca,'XTick',BallsAll) % set values for x-axis
set(gca,'XTickLabel','E')

mTS = mean(mean(TS));
TSmod = TS;
for i = BallsAll
TSmod(:,i) = mTS;
end %i
figure
imagesc(TSmod)
set(gca,'XTick',BallsAll) % set values for x-axis
set(gca,'XTickLabel','E')