% IG 10/12/12 Take corr values out for all balls out
clear all
close all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
PaolaFile = 'C:\Users\Ithabi\Dropbox\Work\Scripts\Cam\Paola\6redes_168rois.txt';
NetwFile = [Homedir filesep 'results' filesep 'networks.mat'];
WcorFile = [Homedir filesep 'results' filesep 'Wcor_168_CI.mat'];

redes=load(PaolaFile);
load(WcorFile);
load(NetwFile)
LoadBalls

for isubj = [5 7 8 16 19 20 21,1,2,3,12,14]%:22
    isubj
    %     WcorMod = Wcor(1,isubj).scale3;
    %     WcorOut = WcorMod(~ismember(1:size(WcorMod, 1), BallsOut{isubj}), :);
    %     WcorOut = WcorOut(:,~ismember(1:size(WcorMod, 1), BallsOut{isubj}));
    %     Wcor(1,isubj).out.scale3 = WcorOut;
    %     figure;imagesc(WcorOut); colorbar
    
    %     WcorMod = Wcor(1,isubj).CI_up3;
    %     WcorOut = WcorMod(~ismember(1:size(WcorMod, 1), BallsOut{isubj}), :);
    %     WcorOut = WcorOut(:,~ismember(1:size(WcorMod, 1), BallsOut{isubj}));
    %     Wcor(1,isubj).out.CI_up3 = WcorOut;
    %
    %     WcorMod = Wcor(1,isubj).CI_lo3;
    %     WcorOut = WcorMod(~ismember(1:size(WcorMod, 1), BallsOut{isubj}), :);
    %     WcorOut = WcorOut(:,~ismember(1:size(WcorMod, 1), BallsOut{isubj}));
    %     Wcor(1,isubj).out.CI_lo3 = WcorOut;
    
%     redesOut = redes(~ismember(1:size(redes, 1), BallsOut{isubj}), :);
%     save([Homedir filesep 'Subject\redes\' int2str(isubj) '_redes'],'redesOut')
    
    netwOut = networks(~ismember(1:size(networks, 1), BallsOut{isubj}), :);
    save([Homedir filesep 'Subject\redes\' int2str(isubj) '_networks'],'netwOut')
end %isubj

%save(WcorFile,'Wcor')