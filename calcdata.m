function calcdata(listname)

loadpaths
loadsubj

subjlist = eval(listname);

allcoh = zeros(length(subjlist),5,91,91);
degree = zeros(length(subjlist),5,91);
bandpower = zeros(size(subjlist,1),5,91);
bandpeak = zeros(size(subjlist,1),5);

load chanlist.mat

for s = 1:size(subjlist,1)
    basename = subjlist{s,1};
    fprintf('Processing %s.\n',basename);

    specinfo = load([filepath basename 'spectra.mat']);
    [sortedchan,sortidx] = sort({specinfo.chann.labels});
    if ~strcmp(chanlist,cell2mat(sortedchan))
        error('Channel names do not match!');
    end
    specinfo.spectra = specinfo.spectra(sortidx,:);
    specinfo.specstd = specinfo.specstd(sortidx,:);
            
    load([filepath basename 'plifdr.mat']);
    [sortedchan,sortidx] = sort({chanlocs.labels});
    if ~strcmp(chanlist,cell2mat(sortedchan))
        error('Channel names do not match!');
    end
    matrix = matrix(:,sortidx,sortidx);
    
%     specinfo.spectra = 10.^(specinfo.spectra/10);
    
    %     figure;
    %     plot(specinfo.freqs,specinfo.spectra');
    %     set(gca,'XLim',[0 45]);
    %     saveas(gcf,sprintf('figures/%sspectra.jpg',basename));
    %     close(gcf);
    
    %     meanspectra = meanspectra + specinfo.spectra;
    for f = 1:size(matrix,1)
        cohmat = squeeze(matrix(f,:,:));
        cohmat = zeromean(cohmat);
        
        allcoh(s,f,:,:) = cohmat;
        degree(s,f,:) = degrees_und(cohmat);%mean(cohmat,1);
        
        %cohmat = applythresh(cohmat,0.2);
        
        %meanmat(f,:,:) = squeeze(meanmat(f,:,:)) + cohmat;
        
        %                 cc = corrcoef([abs(zscore(cohmat(logical(triu(ones(size(cohmat)),1))))) ...
        %                 abs(zscore(chandist(logical(triu(ones(size(chandist)),1))))) ]);
        %                 wdcorr(s,f) = cc(1,2);
        
        
        %         wdcorr(s,f) = mean(mean( abs( zscore(cohmat(logical(triu(ones(size(cohmat)),1)))) .* ...
        %             zscore(chandist(logical(triu(ones(size(chandist)),1)))) ) ));
        
        
        [~, bstart] = min(abs(specinfo.freqs-specinfo.freqlist(f,1)));
        [~, bstop] = min(abs(specinfo.freqs-specinfo.freqlist(f,2)));
        bandpower(s,f,:) = mean(specinfo.spectra(:,bstart:bstop),2);
        
        [maxpow, maxfreq] = max(specinfo.spectra(:,bstart:bstop),[],2);
        [~,maxchan] = max(maxpow);
        bandpeak(s,f) = specinfo.freqs(bstart-1+maxfreq(maxchan));
    end
    for c = 1:size(bandpower,3)
        bandpower(s,:,c) = bandpower(s,:,c) + abs(min(bandpower(s,:,c)));
        bandpower(s,:,c) = bandpower(s,:,c)./sum(bandpower(s,:,c));
    end
    grp(s,1) = subjlist{s,2};    
end
save(sprintf('alldata_%s.mat',listname), 'grp', 'bandpower', 'bandpeak', 'allcoh', 'subjlist', 'degree');