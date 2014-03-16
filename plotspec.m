function plotspec(basename,freqlist)

loadpaths

bands = {
    'delta'
    'theta'
    'alpha'
    'beta'
    'gamma'
    };

fontname = 'Helvetica';
fontsize = 28;
xlim = [0 45];
ylim = [-30 30];

if exist('freqlist','var') && ~isempty(freqlist)
    save([filepath basename 'spectra.mat'],'freqlist','-append');
else
    specinfo = load([filepath basename 'spectra.mat']);
    fprintf('freqlist = %s\n',mat2str(specinfo.freqlist));
end

specinfo = load([filepath basename 'spectra.mat']);
figure('Name',basename,'Color','white'); hold all
plot(specinfo.freqs,specinfo.spectra','LineWidth',1);
set(gca,'XLim',xlim,'YLim',ylim,'FontSize',fontsize,'FontName',fontname);
xlabel('Frequency (Hz)','FontSize',fontsize,'FontName',fontname);
ylabel('Power (dB)','FontSize',fontsize,'FontName',fontname);
ylimits = ylim;
for f = 1:size(specinfo.freqlist,1)
    
            [~, bstart] = min(abs(specinfo.freqs-specinfo.freqlist(f,1)));
        [~, bstop] = min(abs(specinfo.freqs-specinfo.freqlist(f,2)));

            maxpeakheight = 0;
        for c = 1:size(specinfo.spectra,1)
            [peakheight, peakfreq] = findpeaks(specinfo.spectra(c,bstart:bstop),'npeaks',1);
            if ~isempty(peakheight) && peakheight > maxpeakheight
                bandpeak = specinfo.freqs(bstart-1+peakfreq);
                maxpeakheight = peakheight;
            end                
        end
    line([bandpeak bandpeak],ylim,'LineWidth',1,'LineStyle','--','Color','red');
        
    line([specinfo.freqlist(f,1) specinfo.freqlist(f,1)],ylim,'LineWidth',1,...
        'LineStyle','-.','Color','black');
    line([specinfo.freqlist(f,2) specinfo.freqlist(f,2)],ylim,'LineWidth',1,...
        'LineStyle','-.','Color','black');
    text(specinfo.freqlist(f,1),ylimits(2),...
        sprintf('\\%s',bands{f}),'FontName',fontname,'FontSize',fontsize);
end
box on