% IG 22/03/13 Calculate weighted Correlation Matrices
load('distMat.mat')
load('Wcor_168_CI_N16.mat')

for isubj = 1:16
    %Wcor(1,isubj).corrected.sorted_Wscale3 = Wcor(1,isubj).corrected.sorted_scale3(1:160,1:160).*distMat;
    Wcor(1,isubj).corrected.sorted_WFDR_r = Wcor(1,isubj).corrected.sorted_FDR_r(1:160,1:160).*distMat;
end
%figure;imagesc(Wcor(1,isubj).corrected.sorted_scale3(1:160,1:160))
% figure;imagesc(Wcor(1,isubj).corrected.sorted_FDR_r(1:160,1:160))
% figure;imagesc(distMat)
% figure;imagesc(Wcor(1,isubj).corrected.sorted_WFDR_r)
%figure;imagesc(Wcor(1,isubj).corrected.sorted_Wscale3)
save('Wcor_168_CI_N16.mat','Wcor')