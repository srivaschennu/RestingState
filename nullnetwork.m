function nullnetwork

% create a null network based on thresholded iCoh matrixes
% ITER = nb of randomization

namelist = {
    
%%     controls

% % 'jenny_restingstate'
% % 'SaltyWater_restingstate'
'NW_restingstate'
'p37_restingstate'
'p38_restingstate'
'p40_restingstate'
'p41_restingstate'
'p42_restingstate'
'p43_restingstate'
'p44_restingstate'
'p45_restingstate'
'p46_restingstate'
'p47_restingstate'
'p48_restingstate'
'p49_restingstate'
% % 'p50_restingstate'
'subj01_restingstate'
'subj02_restingstate'
'VS_restingstate'
'SS_restingstate'
'SB_restingstate'
'ML_restingstate'
'MC_restingstate'
'JS_restingstate'
% % 'FD_restingstate'
'ET_restingstate'
'EP_restingstate'
% % 'CS_restingstate'
'CL_restingstate'
'CD_restingstate'
'AC_restingstate'
%
% %% patients
%
'p0112_restingstate'
'p0211V2_restingstate'
'p0211_restingstate1'
'p0211_restingstate2'
'p0311V2_restingstate'
'p0311_restingstate1'
'p0311_restingstate2'
% % 'p0411V2_restingstate'
'p0411_restingstate1'
% % 'p0411_restingstate2'
'p0510V2_restingstate'
% % 'p0511V2_restingstate'
% % 'p0511_restingstate'
'p0611_restingstate'
'p0710V2_restingstate'
'p0711_restingstate'
'p0811_restingstate'
'p0911_restingstate'
'p1011_restingstate'
'p1311_restingstate'
'p1511_restingstate'
'p1611_restingstate'
'p1711_restingstate'
'p1811_restingstate'
'p1911_restingstate'
'p2011_restingstate'
% % 'p2111_restingstate'

};
ITER=15;
for subjidx = 1:size(namelist)
    basename = namelist{subjidx};
    
    load(['C:\Users\Eleonore\Documents\MATLAB\RSpcohicoh\icoh\' basename 'icohbootabs.mat']);
    
    nullnet=zeros(5,200,91,91);
    
    for fidx = 1:5
        matrix=squeeze(mat(fidx,:,:));
        
        for loop=1:200
            W0 = null_model_und_sign(matrix,ITER);
            nullnet(fidx,loop,:,:)=W0;
        end
        
    end
    save([basename '_null200.mat'],'nullnet', 'ITER');
end
end
