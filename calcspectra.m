function calcspectra(basename)

loadpaths

load freqlist.mat

EEG = pop_loadset([filepath basename '.set']);
chann = EEG.chanlocs;

[spectra,freqs,speccomp,contrib,specstd] = pop_spectopo(EEG,1,[],'EEG','plot','off','percent',100);

save([filepath basename 'spectra.mat'], 'chann', 'freqs', 'spectra', 'specstd', 'freqlist');
