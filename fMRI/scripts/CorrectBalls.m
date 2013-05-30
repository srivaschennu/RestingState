% IG 06/11/12 Set corr values for all balls out to 0
clear all
close all
Homedir = fullfile('C:','Users','Ithabi','Documents');
WcorFile = [Homedir filesep 'results\Wcor_CI.mat'];
load(WcorFile);

LoadBalls
index = [1 2 3 5 8 12 14 16 19 20 21 23 26 27 28 31];
BallsOut = BallsOut(index);
for isubj = 1:length(BallsOut)%[5 7 8 16 19 20 21]%[1,2,3,12,14]%:22
    isubj
    WcorMod = Wcor(1,isubj).scale3;
    for i = BallsOut{isubj}
        WcorMod(:,i)= 0;
        WcorMod(i,:)= 0;
    end %i
    Wcor(1,isubj).corrected.scale3 = WcorMod;
    figure;imagesc(WcorMod); colorbar
end %isubj

save(WcorFile,'Wcor')