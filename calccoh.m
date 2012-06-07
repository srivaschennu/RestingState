function calccoh(basename)

loadpaths

EEG = pop_loadset('filepath',filepath,'filename',[basename '.set']);
load([filepath basename 'spectr.mat'],'freqlist');

coher = zeros(size(freqlist,1),EEG.nbchan,EEG.nbchan);

for chan1 = 48%1:EEG.nbchan
    for chan2 = 1:EEG.nbchan
        
        if chan1 == chan2
            continue;
        end
        
        fprintf('\n\n%s: estimating coherence between channels %d and %d.\n\n',basename,chan1,chan2);
        [abscoh,~,~,freqsout,~,cohangle] = pop_newcrossf( EEG, 1, chan1, chan2, [EEG.times(1)  EEG.times(end)], ...
            0 ,'alpha',0.01,'type', 'coher','plotamp','off','plotphase','off','padratio',1);
        %coh = abscoh;
        coh = abscoh .* sin(cohangle);
        
        coh = mean(coh,2);
        
        for fl = 3%1:size(freqlist,1)
            firstidx = find(min(abs(freqlist(fl,1) - freqsout)) == abs(freqlist(fl,1) - freqsout));
            lastidx = find(min(abs(freqlist(fl,2) - freqsout)) == abs(freqlist(fl,2) - freqsout));
            
            coher(fl,chan1,chan2) = mean(coh(firstidx:lastidx));
        end
    end
end

chanlocs = EEG.chanlocs;
save([filepath basename 'coher.mat'],'coher','chanlocs');

