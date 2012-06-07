function preprocess(basename)

loadpaths

EEG = pop_loadset('filepath',filepath,'filename',[basename '_orig.set']);
 
EEG = eeg_detrend(EEG);
EEG = pop_rmbase(EEG,[]);


epochlength = 10; %sec
events = (1:epochlength:EEG.xmax)';
events = cat(2,repmat({'EVNT'},length(events),1),num2cell(events));
assignin('base','events',events);
EEG = pop_importevent(EEG,'event',events,'fields',{'type','latency'});
evalin('base','clear events');
EEG = pop_epoch(EEG,{'EVNT'},[0 epochlength]);

EEG.setname = [basename '_epochs'];
EEG.filename = [basename '_epochs.set'];
fprintf('Saving %s%s.\n',EEG.filepath,EEG.filename);
pop_saveset(EEG,'filename', EEG.filename, 'filepath', filepath);

%rejartifacts([basename '_epochs'],1000,500,0,1,2,4);


%EEG = pop_loadset('filepath',filepath,'filename',[basename '_epochs.set']);

% KEEP ONLY 10/20 CHANNELS
%load([chanlocpath 'GSN-HydroCel-128.mat'],'name1020');
%[~,~,chanidx] = intersect(name1020,{EEG.chanlocs.labels});

%EEG = pop_select(EEG,'channel',chanidx);
%fprintf('Keeping %d channels.\n',EEG.nbchan);

%pop_saveset(EEG,'savemode','resave');

end