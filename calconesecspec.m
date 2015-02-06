function calconesecspec(basename)

loadpaths
load freqlist.mat

EEG = pop_loadset('filepath',filepath,'filename',[basename '.set']);
chanlocs = EEG.chanlocs;

procdata = reshape(EEG.data,EEG.nbchan,EEG.pnts*EEG.trials);

for e = 1:EEG.srate:size(procdata,2)-EEG.srate
    if e == 1
        [spectra, freqs] = spectopo(procdata(:,e:e+EEG.srate),0,EEG.srate,'plot','off');
        allspec = [];
        
        wb_h = waitbar(e/EEG.trials,sprintf('Calculating spectrum of epoch %d',e),'Name',mfilename);
    else
        waitbar(e/EEG.trials,wb_h,sprintf('Calculating spectrum of epoch %d',e));
    end
    [~,spectra] = evalc('spectopo(procdata(:,e:e+EEG.srate),0,EEG.srate,''plot'',''off'')');
    allspec = cat(3,allspec,spectra);
end
close(wb_h);

save([filepath basename 'onesecspec.mat'], 'chanlocs', 'freqs', 'allspec', 'freqlist');