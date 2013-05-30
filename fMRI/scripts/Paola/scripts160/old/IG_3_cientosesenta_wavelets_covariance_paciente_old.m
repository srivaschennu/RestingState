function IG_3_cientosesenta_wavelets_covariance_paciente(direc)

outdir=fullfile(direc,'results');
cd(outdir)


ttt=load('timeseries_cientosesenta8');

for suj=1
    for run=1 
        run 
        scans=ttt.timeseries_cientosesenta(suj).run(run).timeseries;
        clear w_serie
        
        for reg=1:size(scans,2)
            serie_norm=(scans(:,reg)- mean(scans(:,reg)))/std(scans(:,reg));
            [w_serie(:,:,reg), VJ, att] = modwt(serie_norm,[],3);    %filtra                               
        end
        
        %calcula corr
        SC1=1;SC2=2;SC3=3;
        wcorE_3=[];
        for d1=1:size(scans,2)
            for d2=1:size(scans,2)
                [wcorE_1(d1,d2), CI_wcor] = modwt_wcor(w_serie(:,SC1,d1), w_serie(:,SC1,d2));
                [wcorE_2(d1,d2), CI_wcor] = modwt_wcor(w_serie(:,SC2,d1), w_serie(:,SC2,d2));
                [wcorE_3(d1,d2), CI_wcor] = modwt_wcor(w_serie(:,SC3,d1), w_serie(:,SC3,d2));
            end
        end
%        Wcor(suj).run(run).scale1=wcorE_1;
%        Wcor(suj).run(run).scale2=wcorE_2;
       Wcor(suj).run(run).scale3=wcorE_3;
    end
end 
save('Wcor_cientosesenta','Wcor')        
    
    
    
    
    
        