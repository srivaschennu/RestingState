

Subj = [1 2 3 5 7 8 12 14 16 19 20 21];
for i = 1:12
    isubj = Subj(i)

    WcorCorrectedSorted(i).FDR_r = Wcor(1,isubj).corrected.sorted_FDR_r;
end
save('Patients','WcorCorrectedSorted')
% for i = 1:18
%     i
% WcorSorted(i).FDR_r = Wcor(1,i).sorted_FDR_r
% end
% save('HealthySubjects','WcorSorted')