function ftcoherence(basename)
% matrix with all coherence number for a frequency interval : freq1:freq2

loadpaths

%     if exist([filepath basename 'wplifdr.mat'],'file')
%         fprintf('%s exists. Skipping...\n',[basename 'wplifdr.mat']);
%         continue;
%     end

EEG = pop_loadset('filename',[basename '.set'],'filepath',filepath);

mintrials = 50;
if EEG.trials < mintrials
    error('Need at least %d trials for analysis, only found %d.',mintrials,EEG.trials);
end

load([filepath basename 'spectra.mat'],'freqlist');

chanlocs = EEG.chanlocs;

EEG = convertoft(EEG);
cfg = [];
cfg.output     = 'powandcsd';
cfg.method     = 'mtmfft';
cfg.foilim        = [0.01 40];
cfg.taper = 'hanning';
% cfg.taper = 'dpss';
% cfg.tapsmofrq = 0.3;
cfg.keeptrials = 'yes';
numrand = 50;

EEG = ft_freqanalysis(cfg,EEG);
abscrsspctrm = abs(EEG.crsspctrm);
matrix = zeros(size(freqlist,1),length(chanlocs),length(chanlocs));
bootmat = zeros(size(freqlist,1),length(chanlocs),length(chanlocs),numrand);
coh = zeros(length(chanlocs),length(chanlocs));

wb_h = waitbar(0,'Starting...');
for r = 0:numrand
    if r > 0
        waitbar(r/numrand,wb_h,sprintf('Randomisation %d of %d...',r,numrand));
        randangles = (2*rand(size(EEG.crsspctrm))-1) .* pi;
        EEG.crsspctrm = complex(abscrsspctrm.*cos(randangles),abscrsspctrm.*sin(randangles));
    end
    
    wpli = ft_connectivity_wpli(EEG.crsspctrm,'debias',true,'dojack',false);
    
    for f = 1:size(freqlist,1)
        [~, bstart] = min(abs(EEG.freq-freqlist(f,1)));
        [~, bend] = min(abs(EEG.freq-freqlist(f,2)));
        
        coh(:) = 0;
        coh(logical(tril(ones(size(coh)),-1))) = max(wpli(:,bstart:bend),[],2);
        coh = tril(coh,1)+tril(coh,1)';
        
        if r > 0
            bootmat(f,:,:,r) = coh;
        else
            matrix(f,:,:) = coh;
        end
    end
end
close(wb_h);

save([filepath 'ftdwpli/' basename 'ftdwplifdr.mat'],'matrix','bootmat','chanlocs');
