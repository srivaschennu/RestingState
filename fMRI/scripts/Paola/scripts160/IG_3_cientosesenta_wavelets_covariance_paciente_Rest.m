% Pabo Bartfeld
% edited by IG, 26.11.12
% calculates the correlation matrix of balls using timeseiries of 168 ROI's
% -------------------------------------------------------------------------
clear;clc
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
%LoadSubjects
Subj = {'080116';'080211';'080213';'080215';'080216';'080220';'080226';'080228';'080229';'080301';'080310';'080318';'080912';'080915';'080918';'080919';'080922';'080923'};

outdir=fullfile(Homedir,'results');
cd(outdir)

Timeseries = 'timeseries_168_PropRest'; %'timeseries_168';
ttt=load(Timeseries);

for isuj=1%:length(Subj)

    scans=ttt.timeseries_168(isuj).timeseries;
    clear w_serie

    for reg=1:size(scans,2)
        serie_norm=(scans(:,reg)- mean(scans(:,reg)))/std(scans(:,reg));
        [w_serie(:,:,reg), VJ, att] = modwt(serie_norm,[],3);    %filtra
    end

    %calcula corr
    SC1=1;SC2=2;SC3=3;

    for d1=1:size(scans,2)
        d1
        for d2=1:size(scans,2)

            if d1 < d2
                [wcorE_1(d1,d2), CI_wcor_1] = modwt_wcor(w_serie(:,SC1,d1), w_serie(:,SC1,d2));
                [wcorE_2(d1,d2), CI_wcor_2] = modwt_wcor(w_serie(:,SC2,d1), w_serie(:,SC2,d2));
                [wcorE_3(d1,d2), CI_wcor_3] = modwt_wcor(w_serie(:,SC3,d1), w_serie(:,SC3,d2));
            elseif d1 > d2
                wcorE_1(d1,d2) = wcorE_1(d2,d1);
                wcorE_2(d1,d2) = wcorE_2(d2,d1);
                wcorE_3(d1,d2) = wcorE_3(d2,d1);
            elseif d1 == d2
                wcorE_1(d1,d2) = 1; CI_wcor_1([1 2]) = 1;
                wcorE_2(d1,d2) = 1; CI_wcor_2([1 2]) = 1;
                wcorE_3(d1,d2) = 1; CI_wcor_3([1 2]) = 1;
            end
            CI_lo_1(d1,d2)=CI_wcor_1(1);
            CI_up_1(d1,d2)=CI_wcor_1(2);
            CI_lo_2(d1,d2)=CI_wcor_2(1);
            CI_up_2(d1,d2)=CI_wcor_2(2);
            CI_lo_3(d1,d2)=CI_wcor_3(1);
            CI_up_3(d1,d2)=CI_wcor_3(2);
        end
    end
    Wcor(isuj).Subject = Subj{isuj};
    Wcor(isuj).scale1 = wcorE_1; %what are 1 & 2 for?
    Wcor(isuj).scale2 = wcorE_2;
    Wcor(isuj).scale3 = wcorE_3;
    Wcor(isuj).CI_lo1 = CI_lo_1;
    Wcor(isuj).CI_up1 = CI_up_1;
    Wcor(isuj).CI_lo2 = CI_lo_2;
    Wcor(isuj).CI_up2 = CI_up_2;
    Wcor(isuj).CI_lo3 = CI_lo_3;
    Wcor(isuj).CI_up3 = CI_up_3;
end %isuj
save('Wcor_168_CI','Wcor')





