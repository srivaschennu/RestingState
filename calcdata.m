function calcdata(listname)

loadpaths
loadsubj

subjlist = eval(listname);

load chanlist.mat

tvals = 0.5:-0.025:0.025;

bandpower = zeros(size(subjlist,1),5,91);
bandpeak = zeros(size(subjlist,1),5);
allcoh = zeros(length(subjlist),5,length(tvals),91,91);
degree = zeros(length(subjlist),5,length(tvals),91);

for s = 1:size(subjlist,1)
    basename = subjlist{s,1};
    fprintf('Processing %s.\n',basename);
    
    specinfo = load([filepath basename 'spectra.mat']);
    [sortedchan,sortidx] = sort({specinfo.chann.labels});
    if ~strcmp(chanlist,cell2mat(sortedchan))
        error('Channel names do not match!');
    end
    specinfo.spectra = specinfo.spectra(sortidx,:);
    specinfo.spectra = 10.^(specinfo.spectra/10);
    specinfo.specstd = specinfo.specstd(sortidx,:);
    specinfo.specstd = 10.^(specinfo.specstd/10);
    
    load([filepath basename 'plifdr.mat']);
    [sortedchan,sortidx] = sort({chanlocs.labels});
    if ~strcmp(chanlist,cell2mat(sortedchan))
        error('Channel names do not match!');
    end
    matrix = matrix(:,sortidx,sortidx);
    
    for f = 1:size(matrix,1)
        cohmat = squeeze(matrix(f,:,:));
        
        [~, bstart] = min(abs(specinfo.freqs-specinfo.freqlist(f,1)));
        [~, bstop] = min(abs(specinfo.freqs-specinfo.freqlist(f,2)));
        bandpower(s,f,:) = mean(specinfo.spectra(:,bstart:bstop),2);
        
        [maxpow, maxfreq] = max(specinfo.spectra(:,bstart:bstop),[],2);
        [~,maxchan] = max(maxpow);
        bandpeak(s,f) = specinfo.freqs(bstart-1+maxfreq(maxchan));
        
        for thresh = 1:length(tvals)
            threshcoh = threshold_proportional(zeromean(cohmat),tvals(thresh));
            bincohmat = double(threshold_proportional(cohmat,tvals(thresh)) ~= 0);
            
            allcoh(s,f,thresh,:,:) = bincohmat;
            degree(s,f,thresh,:) = degrees_und(bincohmat);
        end
        
    end
    for c = 1:size(bandpower,3)
        bandpower(s,:,c) = bandpower(s,:,c)./sum(bandpower(s,:,c));
    end
    grp(s,1) = subjlist{s,2};
end
save(sprintf('alldata_%s.mat',listname), 'grp', 'bandpower', 'bandpeak', 'allcoh', 'subjlist', 'degree');