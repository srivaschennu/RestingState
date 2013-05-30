% changed by IG 20.03.13 Plot EEG spectogramme
clear all
Resultsdir = fullfile('C:','Users','Ithabi','Documents','results');
load([Resultsdir filesep 'bandpowerfmri.mat']);

fontname = 'Gill Sans';
fontsize = 28;
xlim = [0 45];
ylim = [-30 30];

for isubj = 9%:16
figure('Name','Spectral Plot','Color','white');
plot(specinfo{isubj}.freqs,specinfo{isubj}.spectra','LineWidth',2);
set(gca,'XLim',xlim,'YLim',ylim,'FontSize',fontsize,'FontName',fontname,'FontWeight','bold');
xlabel('Frequency (Hz)','FontSize',fontsize,'FontName',fontname,'FontWeight','bold');
ylabel('Power (dB)','FontSize',fontsize,'FontName',fontname,'FontWeight','bold');

for f = 1:size(specinfo{isubj}.freqlist,1)
    line([specinfo{isubj}.freqlist(f,1) specinfo{isubj}.freqlist(f,1)],ylim,'LineWidth',1,...
        'LineStyle','-.','Color','black');
    line([specinfo{isubj}.freqlist(f,2) specinfo{isubj}.freqlist(f,2)],ylim,'LineWidth',1,...
        'LineStyle','-.','Color','black');
end
%saveas(gcf,['figures/' basename 'spectra.jpg']);
end