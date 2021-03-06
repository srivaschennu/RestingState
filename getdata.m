function getdata

loadpaths
loadsubj

%subjlist = cat(1,ctrllist,patlist);
%subjlist = ctrllist;
subjlist = patlist;
% subjlist = fmrilist;

allcoh = zeros(length(subjlist),5,91,91);
degree = zeros(5,length(subjlist)*91);
weight = zeros(5,length(subjlist)*91*91);
bandpower = zeros(size(subjlist,1),5,91);

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
            
    load([filepath basename 'icohfdr.mat']);
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
        
        allcoh(s,f,:,:) = cohmat;
        degree(f,(s-1)*91+1:s*91) = mean(cohmat,1);
        weight(f,(s-1)*91*91+1:s*91*91) = cohmat(:)';
        
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
    end
%     for c = 1:size(bandpower,3)
%         bandpower(s,:,c) = bandpower(s,:,c)./sum(bandpower(s,:,c));
%     end
    grp(s,1) = subjlist{s,2};    
end

save alldata.mat grp bandpower allcoh subjlist