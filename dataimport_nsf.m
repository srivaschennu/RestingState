function dataimport_nsf(basename)

loadpaths

chanlocfile = 'GSN-HydroCel-129.sfp';

filenames = dir(sprintf('%s%s', filepath, basename));

if isempty(filenames)
    error('No files found to import!\n');
end

if length(filenames) > 1
    error('Expected 1 file. Found %d.',length(filenames));
end

fprintf('\nProcessing %s.\n\n', filenames.name);
EEG = pop_readegi(sprintf('%s%s', filepath, filenames.name));

EEG = fixegilocs(EEG,[chanlocpath chanlocfile]);

EEG = eeg_checkset(EEG);

%%%% PRE-PROCESSING

%Remove excluded channels

%chanexcl = [1,8,14,17,21,25,32,38,43,44,48,49,56,63,64,68,69,73,74,81,82,88,89,94,95,99,107,113,114,119,120,121,125,126,127,128];
chanexcl = [];

fprintf('Removing excluded channels.\n');
EEG = pop_select(EEG,'nochannel',chanexcl);

%REDUCE SAMPLING RATE TO 250HZ
if EEG.srate > 250
    fprintf('Downsampling to 250Hz.\n');
    EEG = pop_resample(EEG,250);
elseif EEG.srate < 250
    error('Sampling rate too low!');
end

%Filter
hpfreq = 0.5;
lpfreq = 100;
fprintf('Low-pass filtering below %.1fHz...\n',lpfreq);
EEG = pop_eegfilt(EEG, 0, lpfreq);
fprintf('High-pass filtering above %.1fHz...\n',hpfreq);
EEG = pop_eegfilt(EEG, hpfreq, 0);

%KEEP ONLY 10 MINUTES MAX OF DATA
% if EEG.xmax > 600
%     EEG = pop_select(EEG,'time',[0 600]);
% elseif EEG.xmax < 600
%     error('Not enough data.');
% end

fprintf('Removing line noise using multi-taper filtering.\n');
EEG = rmlinenoisemt(EEG);

epochlength = 10; %sec
events = (1:epochlength:EEG.xmax)';
events = cat(2,repmat({'EVNT'},length(events),1),num2cell(events));
assignin('base','events',events);
EEG = pop_importevent(EEG,'event',events,'fields',{'type','latency'});
evalin('base','clear events');
EEG = pop_epoch(EEG,{'EVNT'},[0 epochlength]);
 
EEG = eeg_detrend(EEG);
EEG = pop_rmbase(EEG,[]);

EEG.setname = [basename '_orig'];
EEG.filename = [basename '_orig.set'];
fprintf('Saving %s%s.\n',EEG.filepath,EEG.filename);
pop_saveset(EEG,'filename', EEG.filename, 'filepath', filepath);