function calcallspec(basename)

loadpaths
load freqlist.mat

EEG = pop_loadset('filepath',filepath,'filename',[basename '.set']);
chanlocs = EEG.chanlocs;

for e = 1:EEG.trials
    if e == 1
        [spectra, freqs] = spectopo(EEG.data(:,:,e),EEG.pnts,EEG.srate,'plot','off');
        allspec = zeros(EEG.nbchan,size(spectra,2),EEG.trials);
        
        wb_h = waitbar(e/EEG.trials,sprintf('Calculating spectrum of epoch %d',e),'Name',mfilename);
    else
        waitbar(e/EEG.trials,wb_h,sprintf('Calculating spectrum of epoch %d',e));
    end
    [~,allspec(:,:,e)] = evalc('spectopo(EEG.data(:,:,e),EEG.pnts,EEG.srate,''plot'',''off'')');
end
close(wb_h);

save([filepath basename 'allspec.mat'], 'chanlocs', 'freqs', 'allspec', 'freqlist');