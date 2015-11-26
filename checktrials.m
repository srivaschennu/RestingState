function trialcount = checktrials(basename,settrials)

loadpaths

filesuffix = '_clean';

EEG = pop_loadset('filepath',filepath,'filename',[basename filesuffix '.set']);

trialcount = EEG.trials;

if trialcount < settrials
    warning('Number of trials %d less than %d!',trialcount,settrials);
    return
end

fprintf('Found %d trials.\n',trialcount);

if trialcount > settrials
    EEG = pop_select(EEG,'trial',1:settrials);
    EEG.saved = 'no';
    fprintf('Resaving to %s%s.\n',EEG.filepath,EEG.filename);
    pop_saveset(EEG,'savemode','resave');
end