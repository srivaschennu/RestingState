clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');
WcorFile = [Homedir filesep 'results\Wcor_168_CI_N16.mat'];% Wcor_168_CI_PropRest.mat'];
load(WcorFile);

for s = 1:length(Wcor)
    for i = 1:size(Wcor(s).scale3,1)
        for j = 1:size(Wcor(s).scale3,1)
            se = (Wcor(s).CI_up3(i,j) - Wcor(s).CI_lo3(i,j)) / (2*1.96);
            tstat = Wcor(s).scale3(i,j)/se;
            Wcor(s).pVal(i,j) = exp(-0.717*tstat - 0.416*tstat^2);
        end
    end
end
save(WcorFile,'Wcor')


% Wcor(1,isubj).corrected.sorted_Wscale3
% for s = 1:length(Wcor)
%     for i = 1:size(Wcor(s).corrected.sorted_Wscale3,1)
%         for j = 1:size(Wcor(s).corrected.sorted_Wscale3,1)
%             se = (Wcor(s).CI_up3(i,j) - Wcor(s).CI_lo3(i,j)) / (2*1.96);
%             tstat = Wcor(s).scale3(i,j)/se;
%             Wcor(s).pVal(i,j) = exp(-0.717*tstat - 0.416*tstat^2);
%         end
%     end
% end
% save(WcorFile,'Wcor')