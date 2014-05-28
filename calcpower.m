function calcpower(listname,conntype)

loadpaths
loadsubj

subjlist = eval(listname);

load chanlist.mat

for s = 1:size(subjlist,1)
    basename = subjlist{s,1};
    fprintf('Processing %s.\n',basename);
    
    specinfo = load([filepath basename 'allspec.mat']);
    [sortedchan,sortidx] = sort({specinfo.chanlocs.labels});
    if ~strcmp(chanlist,cell2mat(sortedchan))
        error('Channel names do not match!');
    end
    specinfo.allspec = specinfo.allspec(sortidx,:,:);
    specinfo.allspec = 10.^(specinfo.allspec/10);
    
    if s == 1
        bandpower = zeros(size(subjlist,1),size(specinfo.freqlist,1),length(specinfo.chanlocs),60);
    end
    
    for f = 1:size(specinfo.freqlist,1)
        %collate spectral info
        [~, bstart] = min(abs(specinfo.freqs-specinfo.freqlist(f,1)));
        [~, bstop] = min(abs(specinfo.freqs-specinfo.freqlist(f,2)));
        bandpower(s,f,:,1:size(specinfo.allspec,3)) = mean(specinfo.allspec(:,bstart:bstop,:),2);
    end
    for c = 1:size(bandpower,3)
        for t = 1:size(bandpower,4)
            bandpower(s,:,c,t) = bandpower(s,:,c,t)./sum(bandpower(s,:,c,t));
        end
    end
    grp(s,1) = subjlist{s,2};
end
save(sprintf('%s/%s/allspec_%s_%s.mat',filepath,conntype,listname,conntype), 'grp', 'bandpower', 'subjlist');