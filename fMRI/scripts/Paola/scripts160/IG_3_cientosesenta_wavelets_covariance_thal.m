% Pabo Bartfeld
% edited by IG, 26.11.12
% calculates the correlation matrix of balls using timeseiries of 168 ROI's
% -------------------------------------------------------------------------
clear;clc
cd(fullfile('C:','Users','Ithabi','Documents','results'))

LoadSubjects
index = [1 2 3 5 8 12 14 16 19 20 21 23 26 27 28 31];
Subj = Subj(index);

ttt=load('timeseries');

for isuj=1:length(Subj)

    scans=ttt.timeseries_168(isuj).ts_thal;
    clear w_serie

    for reg=1:size(scans,2)
        serie_norm=(scans(:,reg)- mean(scans(:,reg)))/std(scans(:,reg));
        [w_serie(:,:,reg), VJ, att] = modwt(serie_norm,[],3);    %filtra
    end

    %calcula corr
    SC3=3;

    for d1=1:size(scans,2)
        d1
        for d2=1:size(scans,2)
            if d1 < d2
                [wcorE_3(d1,d2), CI_wcor_3] = modwt_wcor(w_serie(:,SC3,d1), w_serie(:,SC3,d2));
            elseif d1 > d2
                wcorE_3(d1,d2) = wcorE_3(d2,d1);
            elseif d1 == d2
                wcorE_3(d1,d2) = 1; CI_wcor_3([1 2]) = 1;
            end
            CI_lo_3(d1,d2)=CI_wcor_3(1);
            CI_up_3(d1,d2)=CI_wcor_3(2);
        end
    end
    Wcor(isuj).Subject = Subj{isuj};
    Wcor(isuj).scale3 = wcorE_3;
    Wcor(isuj).CI_lo3 = CI_lo_3;
    Wcor(isuj).CI_up3 = CI_up_3;
end %isuj
save('Wcor_CI','Wcor')





