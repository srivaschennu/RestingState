clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
WcorFile = [Homedir filesep 'results\Wcor_CI.mat'];
load(WcorFile);

for s = 1:length(Wcor)%[5 7 8 16 19 20 21]%[1,2,3,12,14]%
    for i = 1:size(Wcor(s).corrected.scale3,1)
        for j = 1:size(Wcor(s).corrected.scale3,1)
            se = (Wcor(s).CI_up3(i,j) - Wcor(s).CI_lo3(i,j)) / (2*1.96);
            tstat = Wcor(s).corrected.scale3(i,j)/se;
            Wcor(s).corrected.pVal(i,j) = exp(-0.717*tstat - 0.416*tstat^2);
        end
    end
end
save(WcorFile,'Wcor')