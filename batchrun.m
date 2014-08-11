function batchrun(listname)

loadsubj
loadpaths
subjlist = eval(listname);
% load freqlist

for s = 1:length(subjlist)
    basename = subjlist{s};
    batchres{s,1} = basename;
    batchres{s,2} = subjlist{s,2};
    
    fprintf('Processing %s.\n',basename);
%     copyfile([filepath basename '.set'],[filepath 'copy/' basename '.set']);
%     copyfile([filepath basename '.fdt'],[filepath 'copy/' basename '.fdt']);
%     copyfile([filepath basename 'spectra.mat'],[filepath 'copy/' basename 'spectra.mat']);
%     calcftspec(basename);
%     ftcoherence(basename);
    
%     copyfile([filepath basename '.set'],[filepath 'commonfreq/' basename '.set']);
%     copyfile([filepath basename '.fdt'],[filepath 'commonfreq/' basename '.fdt']);
%     copyfile([filepath basename 'pliboot.mat'],[filepath 'commonfreq/' basename 'pliboot.mat']);
%     copyfile([filepath basename 'plifdr.mat'],[filepath 'commonfreq/' basename 'plifdr.mat']);
    
    EEG = pop_loadset('filepath',filepath,'filename',[basename '.set'],'loadmode','info');
    batchres{s,3} = EEG.trials;
    
%     EEG = rereference(EEG,2);
%     pop_saveset(EEG,'savemode','resave');

%         dataimport(basename);

% eogimport(basename);

% eogrsd = ploteog(basename);
% anovdata(s,1) = mean(eogrsd(1:round(length(eogrsd)/2)));
% anovdata(s,2) = mean(eogrsd(round(length(eogrsd)/2)+1:end));

%         epochdata(basename);
    
%            rejartifacts2([basename '_epochs'],1,4,[],[],1000,500);
    
%         computeic([basename '_epochs']);
    
%             rejectic(basename);
    
%     EEG = pop_loadset('filepath',filepath,'filename',[basename '_epochs.set'],'loadmode','info');
%     batchres{s,3} = sum(EEG.reject.gcompreject);
    
%             rejartifacts2(basename,2,1);
    
%             calcallspec(basename);
% 
% 
%             plotspec(basename);
%             export_fig(gcf,sprintf('figures/%sspectra.eps',basename));
%             close(gcf);
% %     
    %         fix1020(basename);
    
%     coherence(basename);
    
%         load([filepath 'wpli/' basename 'wplifdr.mat']);
%         cohmat = squeeze(matrix(3,:,:));
%         cohmat(isnan(cohmat)) = 0;
%         cohmat = threshold_proportional(cohmat,0.3);
% %         plotgraph(cohmat,chanlocs,'plotqt',0.7,'legend','off');
%         figure; imagesc(cohmat); set(gca,'XTick',[],'YTick',[]); colorbar
%         export_fig(gcf,['figures/' basename 'wplicohmat.eps'],'-opengl');
%         close(gcf);

%                 javaaddpath('/Users/chennu/Work/mffimport/MFF-1.0.d0004.jar');
%                 filenames = dir(sprintf('%s%s*', filepath, basename));
%                 mfffiles = filenames(logical(cell2mat({filenames.isdir})));
%                 filename = mfffiles.name;
%     
%                 fprintf('Reading information from %s%s.\n',filepath,filename);
%                 mffinfo = read_mff_info([filepath filename]);
%                 mffdate = sscanf(mffinfo.date,'%d-%d-%d');
%                 batchres{s,2} = sprintf('%02d/%02d/%04d',mffdate(3),mffdate(2),mffdate(1));
%     
%                 fprintf('Reading subject information from %s%s.\n',filepath,filename);
%                 subjinfo{s} = read_mff_subj([filepath filename]);
%                 subjinfo{s}.basename = basename;
%                 if isfield(subjinfo{s},'Gender')
%                     if strcmp(subjinfo{s}.Gender,'false')
%                         subjinfo{s}.Gender = 'M';
%                     else
%                         subjinfo{s}.Gender = 'F';
%                     end
%                     if strcmp(subjinfo{s}.Handedness,'false')
%                         subjinfo{s}.Handedness = 'Right';
%                     else
%                         subjinfo{s}.Handedness = 'Left';
%                     end
%                 end

end
% rmanova(anovdata);
% for s = 1:length(subjinfo)
%     fprintf('%s\t',subjinfo{s}.basename);
%     if isfield(subjinfo{s},'Age')
%         fprintf('%s\t%s\t%s',subjinfo{s}.Age,subjinfo{s}.Gender,subjinfo{s}.Handedness);
%     end
%     fprintf('\n');
% end

save batchres.mat batchres