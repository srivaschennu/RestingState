function plotspec(basename)

loadpaths

fontname = 'Gill Sans';
fontsize = 28;
xlim = [0 45];
ylim = [-30 30];

specinfo = load([filepath basename 'spectra.mat']);
figure('Name',basename,'Color','white');
plot(specinfo.freqs,specinfo.spectra','LineWidth',2);
set(gca,'XLim',xlim,'YLim',ylim,'FontSize',fontsize,'FontName',fontname,'FontWeight','bold');
xlabel('Frequency (Hz)','FontSize',fontsize,'FontName',fontname,'FontWeight','bold');
ylabel('Power (dB)','FontSize',fontsize,'FontName',fontname,'FontWeight','bold');

for f = 1:size(specinfo.freqlist,1)
    line([specinfo.freqlist(f,1) specinfo.freqlist(f,1)],ylim,'LineWidth',1,...
        'LineStyle','-.','Color','black');
end