clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
WcorFile = [Homedir filesep 'results\Wcor_168_CI.mat']; %_PropRest 
load(WcorFile);

for s = [5 7 8 16 19 20 21,1,2,3,12,14]%1:length(Wcor)
    s
    Var = Wcor(s).out.scale3; %Wcor(s).scale3
    UpCI = Wcor(s).out.CI_up3;
    LoCI = Wcor(s).out.CI_lo3;
    for i = 1:size(Var,1)
        for j = 1:size(Var,1)
            se = (UpCI(i,j) - LoCI(i,j)) / (2*1.96);
            tstat = Var(i,j)/se;
            Wcor(s).out.pVal(i,j) = exp(-0.717*tstat - 0.416*tstat^2);
        end
    end
end
save(WcorFile,'Wcor')