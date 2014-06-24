function eogimport(basename)

loadpaths

filenames = dir(sprintf('%s%s*', filepath, basename));

if isempty(filenames)
    error('No files found to import!\n');
end

mfffiles = filenames(logical(cell2mat({filenames.isdir})));
if length(mfffiles) > 1
    error('Expected 1 MFF recording file. Found %d.\n',length(mfffiles));
else
    filename = mfffiles.name;
    fprintf('\nProcessing %s.\n\n', filename);
    EEG = pop_readegimff(sprintf('%s%s', filepath, filename));
end

eogchan = [
    25 127 %left
    8 126 %right
    ];

eogdata = zeros(size(eogchan,1),EEG.pnts);
for chanidx = 1:size(eogchan,1)
    eogdata(chanidx,:) = EEG.data(eogchan(chanidx,1),:) - EEG.data(eogchan(chanidx,2),:);
    EEG.chanlocs(chanidx) = EEG.chanlocs(eogchan(chanidx,1));
    EEG.chanlocs(chanidx).labels = sprintf('EOG%d-%d',eogchan(chanidx,1),eogchan(chanidx,2));
end

EEG = pop_select(EEG,'channel',1:size(eogchan,1));
EEG.data = eogdata;

%KEEP ONLY 10 MINUTES MAX OF DATA
if EEG.xmax > 600
    EEG = pop_select(EEG,'time',[0 600]);
elseif EEG.xmax < 600
    warning('%s: Not enough data.',basename);
end

EEG = pop_eegfiltnew(EEG,1,3);

epochlength = 1; %sec

events = (0:epochlength:EEG.xmax)';
events = cat(2,repmat({'EVNT'},length(events),1),num2cell(events));
assignin('base','events',events);

EEG = pop_importevent(EEG,'event',events,'fields',{'type','latency'});
evalin('base','clear events');
EEG = eeg_checkset(EEG,'makeur');
EEG = eeg_checkset(EEG,'eventconsistency');

fprintf('\nSegmenting into %d sec epochs.\n',epochlength);
EEG = pop_epoch(EEG,{'EVNT'},[0 epochlength]);

EEG.setname = sprintf('%s_eog',basename);
EEG.filename = sprintf('%s_eog.set',basename);
EEG.filepath = filepath;

EEG = eeg_checkset(EEG);

fprintf('Saving %s%s.\n', EEG.filepath, EEG.filename);
pop_saveset(EEG,'filename', EEG.filename, 'filepath', EEG.filepath);





