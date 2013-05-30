%IG 15/01/13 take correlation of bandpower average and GT measures
clear all
Resultsdir = fullfile('C:','Users','Ithabi','Documents','results');
cd(Resultsdir)
fidex = [Resultsdir filesep 'Corr.xlsx']; % filename
Value = {'B';'C';'D';'E';'F'};
Value2 = {'H';'I';'J';'K';'L'};
load('graphdata.mat')
load('bandpowerfmri.mat')
L=0;

index = [1 2 4 6 7 8 12 13 14 16];

for inet = 1:4
    inet
    patdata = GraphData(inet:4:end,:); % takes FP for each subject
    patdata = patdata(index,:);
    for ifreq = 1:5
        bandsave(:,:) = bandpower(:,ifreq,:);
        banddata = mean(bandsave,2);
        banddata = banddata(index,:);
        for imes = 1:12 % for all the GT measures
            [r,p] = corrcoef(banddata,patdata(:,imes));    
            xlswrite(fidex,p(2),8,[Value{ifreq} int2str(imes+2+L)]);
            xlswrite(fidex,r(2),8,[Value2{ifreq} int2str(imes+2+L)]);
        end % imes
    end %ifreq
    L=L+14;
end %inet
