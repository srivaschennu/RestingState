function dataimport_mat(basename)

loadpaths

chanlocmat = 'GSN-HydroCel-128.mat';


fprintf('Loading %s%s.mat.\n',rawpath,basename);
rawdata = load([rawpath basename '.mat']);

EEG = pop_importdata('data',rawdata.(basename)(1:end-1,:),'dataformat','array','setname',[basename '_orig'],...
    'subject',basename,'nbchan',128,'srate',rawdata.samplingRate);

EEG.event = [];
EEG.urevent = [];

EEG = eeg_checkset(EEG);

EEG = fixegilocs(EEG,[chanlocpath 'GSN-HydroCel-129.sfp']);

%%%% PREPROCESSING

% RENAME 10/20 CHANNELS
load([chanlocpath chanlocmat]);
for c = 1:length(idx1020)
    chanidx = strcmp(sprintf('E%d',idx1020(c)),{EEG.chanlocs.labels});
    if sum(chanidx) == 1
        fprintf('Replaced %s with %s.\n',EEG.chanlocs(chanidx).labels,name1020{c});
        EEG.chanlocs(chanidx).labels = name1020{c};
    end
end

% KEEP ONLY 10/20 CHANNELS
%[~,~,chanidx] = intersect(name1020,{EEG.chanlocs.labels});
%EEG = pop_select(EEG,'channel',chanidx);
%fprintf('Keeping %d channels.\n',EEG.nbchan);


% REMOVE EXCLUDED CHANNELS
chanexcl = [1,8,14,17,21,25,32,38,43,44,48,49,56,63,64,68,69,73,74,81,82,88,89,94,95,99,107,113,114,119,120,121,125,126,127,128];
%chanexcl = [];
fprintf('Removing excluded channels.\n');
EEG = pop_select(EEG,'nochannel',chanexcl);

%REDUCE SAMPLING RATE TO 250HZ
if EEG.srate > 250
    fprintf('Downsampling to 250Hz.\n');
    EEG = pop_resample(EEG,250);
elseif EEG.srate < 250
    error('Sampling rate too low!');
end

%KEEP ONLY 10 MINUTES MAX OF DATA
if EEG.xmax > 600
    EEG = pop_select(EEG,'time',[0 600]);
elseif EEG.xmax < 600
    error('Not enough data.');
end

%Filter
hpfreq = 0.5;
lpfreq = 45;
fprintf('Low-pass filtering below %.1fHz...\n',lpfreq);
EEG = pop_eegfilt(EEG, 0, lpfreq, [], [0], 0, 0, 'fir1', 0);
fprintf('High-pass filtering above %.1fHz...\n',hpfreq);
EEG = pop_eegfilt(EEG, hpfreq, 0, [], [0], 0, 0, 'fir1', 0);

%Remove line noise
fprintf('Removing line noise at 50Hz.\n');
EEG = rmlinenoisemt(EEG);

EEG.setname = sprintf('%s_orig',basename);
EEG.filename = sprintf('%s_orig.set',basename);
EEG.filepath = filepath;

EEG = eeg_checkset(EEG);

fprintf('Saving %s%s.\n', EEG.filepath, EEG.filename);
pop_saveset(EEG,'filename', EEG.filename, 'filepath', EEG.filepath);
