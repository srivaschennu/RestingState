Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
Resultsdir = [Homedir filesep 'results\'];
WcorFile = [Resultsdir 'Wcor_168_CI.mat'];
for i = 1:22
Wcor(1,i).Subject=A(1,i).Subject;
Wcor(1,i).scale3=A(1,i).scale3;
Wcor(1,i).CI_lo3=A(1,i).CI_lo3;
Wcor(1,i).CI_up3=A(1,i).CI_up3;
Wcor(1,i).corrected=A(1,i).corrected;
end
save(WcorFile,'Wcor')