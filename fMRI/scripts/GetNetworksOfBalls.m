%IG 20/11/12 Read which balls are out
clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
[~,~,bbal] = xlsread([Homedir filesep 'Project/Networks.xlsx']);
LoadBalls12
for isubj=1:12
    balls = BallsOut{isubj}
    for inet=1:length(balls)
        Subj{inet,isubj} = bbal(balls(inet),2)
    end %inet
    %All{isubj,:} = Subj
end %isubj