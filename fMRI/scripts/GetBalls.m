%IG 19/11/12 Read which balls are out
clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
[~,~,bbal] = xlsread([Homedir filesep 'Project/Networks.xlsx'],7);
BallPosition = bbal(1:2,3:14)'
for isubj = 3:14
    bal = bbal(3:170,isubj);
    b = cell2mat(bal);
    Ballposition = find(b~=0);
    BallPosition{isubj-2,3,:} = Ballposition'
    BallsGout{isubj,:} = Ballposition'
end
%save BallPosition.mat BallPosition