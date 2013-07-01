function calcgraph

loadpaths

alpha = 0.05;

loadsubj

%subjlist = cat(1,ctrllist,patlist);
%subjlist = ctrllist;
subjlist = patlist;
% subjlist = fmrilist;

%load distinfo.mat
load chanlist.mat

% meanmat = zeros(5,91,91);
%
% meanspectra = zeros(91,513);

bet = zeros(size(subjlist,1),5,91);
clust = zeros(size(subjlist,1),5,91);
modi = zeros(size(subjlist,1),5,91);
bandpower = zeros(size(subjlist,1),5,91);

bigmat = zeros(length(subjlist),5,91,91);
degree = zeros(5,length(subjlist)*91);
weight = zeros(5,length(subjlist)*91*91);

for s = 1:size(subjlist,1)
    basename = subjlist{s,1};
    fprintf('Processing %s.\n',basename);
    
    specinfo{s} = load([filepath basename 'spectra.mat']);
    
    %     figure;
    %     plot(specinfo{s}.freqs,specinfo{s}.spectra');
    %     set(gca,'XLim',[0 45]);
    %     saveas(gcf,sprintf('figures/%sspectra.jpg',basename));
    %     close(gcf);
    
    %     meanspectra = meanspectra + specinfo{s}.spectra;
    
    load([filepath basename 'icohfdr.mat']);
    
    [sortedchan,sortidx] = sort({chanlocs.labels});
    chanlocs = chanlocs(sortidx);
    %
    %    chandist = ichandist(chanlocs);
    % %     chandist = chandist/max(chandist(:));
    %
    %         if ~strcmp(chanlist,cell2mat(sortedchan))
    %             error('Channel names do not match!');
    %         end
    
    
    bigchanlocs{s} = chanlocs;
    
    for f = 1:size(matrix,1)
        cohmat = squeeze(matrix(f,sortidx,sortidx));
        pvals = squeeze(pval(f,sortidx,sortidx));
        
        bigmat(s,f,:,:) = cohmat;
        degree(f,(s-1)*91+1:s*91) = mean(cohmat,1);
        weight(f,(s-1)*91*91+1:s*91*91) = cohmat(:)';
        
        %cohmat = applythresh(cohmat,0.2);
        
        %meanmat(f,:,:) = squeeze(meanmat(f,:,:)) + cohmat;
        
        %                 cc = corrcoef([abs(zscore(cohmat(logical(triu(ones(size(cohmat)),1))))) ...
        %                 abs(zscore(chandist(logical(triu(ones(size(chandist)),1))))) ]);
        %                 wdcorr(s,f) = cc(1,2);
        
        
        %         wdcorr(s,f) = mean(mean( abs( zscore(cohmat(logical(triu(ones(size(cohmat)),1)))) .* ...
        %             zscore(chandist(logical(triu(ones(size(chandist)),1)))) ) ));
        
        
        [~, bstart] = min(abs(specinfo{s}.freqs-specinfo{s}.freqlist(f,1)));
        [~, bstop] = min(abs(specinfo{s}.freqs-specinfo{s}.freqlist(f,2)));
        bandpower(s,f,:) = mean(specinfo{s}.spectra(:,bstart:bstop),2);
        
                tvals = 0;%0:0.05:0.3;
                for t = 1:length(tvals)
                    %cohmat = applythresh(cohmat,tvals(t));
        
                                [Ci, Q] = modularity_louvain_und(cohmat);
                                mod(s,f,t) = Q;
                                modi(s,f,:) = Ci;
                                bet(s,f,:) = betweenness_wei(1./cohmat);
                                meanbet(s,f) = mean(nonzeros(bet(s,f,:)));
        
                                dist(s,f,t) = 0;
                                for m = 1:max(Ci)
                                    distmat = chandist(Ci == m,Ci == m);% .* (cohmat(Ci == m,Ci == m) > 0);
                                    dist(s,f,t) = dist(s,f,t) + mean(mean(distmat));
                                end
                                dist(s,f,t) = dist(s,f,t) / max(Ci);
        
                                maxci(s,f,t) = max(Ci);
                                clust(s,f,:) = clustering_coef_wu(cohmat); %clustering coeffcient
                    %characteristic path length and efficiency with weights
                                [charp(s,f,t) eff(s,f,t)] = charpath(distance_wei(1./cohmat));
                end
    end
    grp(s,1) = subjlist{s,2};
end

%meanmat = meanmat ./ length(subjlist);
%matrix = meanmat;
%save meanmat.mat matrix chanlocs

%spectra = meanspectra ./ length(subjlist);
%save('meanspectra.mat','spectra','bandpower','grp');

save bigmat.mat grp bandpower clust modi bet meanbet tvals charp eff mod dist maxci %wdcorr %chanlocs
save bigmat.mat bigmat subjlist bigchanlocs
% save bandpowerfmri.mat bandpower specinfo
% save distinfofmri.mat degree weight