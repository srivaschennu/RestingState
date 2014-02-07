function ftcoherence(basename)
% matrix with all coherence number for a frequency interval : freq1:freq2

loadpaths

alpha = 0.05;

%     if exist([filepath basename 'wplifdr.mat'],'file')
%         fprintf('%s exists. Skipping...\n',[basename 'wplifdr.mat']);
%         continue;
%     end

EEG = pop_loadset('filename',[basename '.set'],'filepath',filepath);
load([filepath basename 'spectra.mat'],'freqlist');

chanlocs = EEG.chanlocs;
matrix=zeros(size(freqlist,1),EEG.nbchan,EEG.nbchan); % size(freqlist,1) lines ; EEG.nbchan columns ; EEG.nbchan time this table
coh = zeros(EEG.nbchan,EEG.nbchan);

EEG = convertoft(EEG);
cfg = [];
cfg.output     = 'powandcsd';
cfg.method     = 'mtmfft';
cfg.foilim        = [0.1 40];
% cfg.taper = 'rectwin';
cfg.taper = 'dpss';
cfg.tapsmofrq = 0.3;
cfg.keeptrials = 'yes';

EEG = ft_freqanalysis(cfg,EEG);
wpli = ft_connectivity_wpli(EEG.crsspctrm,'debias',true,'dojack',false);

for f = 1:size(freqlist,1)
    [~, bstart] = min(abs(EEG.freq-freqlist(f,1)));
    [~, bend] = min(abs(EEG.freq-freqlist(f,2)));
    
    coh(:) = 0;
    coh(logical(tril(ones(size(coh)),-1))) = mean(wpli(:,bstart:bend),2);
    coh = tril(coh,1)+tril(coh,1)';
    matrix(f,:,:) = coh;
end

save([filepath basename 'wplifdr.mat'],'matrix','chanlocs');
