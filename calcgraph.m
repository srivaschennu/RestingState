function calcgraph

loadpaths

alpha = 0.05;

ctrllist = {
    %     controls
    
    %     'jenny_restingstate'
    %     %'SaltyWater_restingstate'
    'NW_restingstate'  3  25
    'p37_restingstate'  3  25
    'p38_restingstate'  3  25
    'p40_restingstate'  3  25
    'p41_restingstate'  3  25
    'p42_restingstate'  3  25
    'p43_restingstate'  3  25
    'p44_restingstate'  3  25
    'p45_restingstate'  3  25
    'p46_restingstate'  3  25
    'p47_restingstate'  3  25
    'p48_restingstate'  3  25
    'p49_restingstate'  3  25
    % 'p50_restingstate'
    'subj01_restingstate'  3    25
    'subj02_restingstate'  3    25
    'VS_restingstate'  3  25
    'SS_restingstate'  3  25
    'SB_restingstate'  3  25
    'ML_restingstate'  3  25
    'MC_restingstate'  3  25
    'JS_restingstate'  3  25
    % 'FD_restingstate'
    'ET_restingstate'  3  25
    'EP_restingstate'  3  25
    % 'CS_restingstate'
    'CL_restingstate'  3  25
    'CD_restingstate'  3  25
    'AC_restingstate'  3  25
    };

patlist = {
    %
    % patients
    
    'p0112_restingstate'	1   9
    'p0211V2_restingstate'	2   16
    %'p0211_restingstate1'
    'p0211_restingstate2'   2   14
    'p0311V2_restingstate'  0   8
    %'p0311_restingstate1'
    'p0311_restingstate2'   0   7
    % 'p0411V2_restingstate'
    'p0411_restingstate1'   0   7
    % 'p0411_restingstate2'
    'p0510V2_restingstate'  0   7
    % 'p0511V2_restingstate'
    % 'p0511_restingstate'
    'p0611_restingstate'    2   10
    'p0710V2_restingstate'  1   14
    'p0711_restingstate'    2   15
    'p0811_restingstate'    1   10
    'p0911_restingstate'    1   10
    'p1011_restingstate'    1   10
    'p1311_restingstate'    0   8
    'p1511_restingstate'    2   10
    'p1611_restingstate'    0   7
    'p1711_restingstate'    2   19
    'p1811_restingstate'    1   12
    'p1911_restingstate'    1   9
    'p2011_restingstate'    1   8
    % 'p2111_restingstate'
    'p0212_restingstate'    1   12
    'p0312_restingstate'    1   8
    'p1811v2_restingstate'  2   15
    };

fmrilist = {
    'p0211_restingstate2'   2   14
    'p1711_restingstate'    2   19
    'p0112_restingstate'	1   9
    'p0711_restingstate'    2   15
%    'p0211V2_restingstate'	2   16
    'p0311_restingstate2'   0   7
    'p0911_restingstate'    1   10
    'p1311_restingstate'    0   8
    'p1611_restingstate'    0   7
    'p1911_restingstate'    1   9
    'p2011_restingstate'    1   8
    'p0312_restingstate'    1   8
    'p0512_restingstate'    0   0
    'p1511v2_restingstate'  0   0
    'p71v3_restingstate'    0   0
    'p0712_restingstate'    0   0
    'p1012_restingstate'    0   0
%    'p1311v2_restingstate'  0   0
    };

%subjlist = cat(1,ctrllist,patlist);
%subjlist = ctrllist;
%subjlist = patlist;
subjlist = fmrilist;

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
    
    %     [sortedchan,sortidx] = sort({chanlocs.labels});
    %     chanlocs = chanlocs(sortidx);
    %
    %    chandist = ichandist(chanlocs);
    % %     chandist = chandist/max(chandist(:));
    %
    %         if ~strcmp(chanlist,cell2mat(sortedchan))
    %             error('Channel names do not match!');
    %         end
    
    
    bigchanlocs{s} = chanlocs;
    
    for f = 1:size(matrix,1)
        cohmat = squeeze(matrix(f,:,:));
        pvals = squeeze(pval(f,:,:));
        
        %         cohmat = squeeze(matrix(f,sortidx,sortidx));
        %         pvals = squeeze(pval(f,sortidx,sortidx));
        
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
        %
        %         tvals = 0;%0:0.05:0.3;
        %         for t = 1:length(tvals)
        %             %cohmat = applythresh(cohmat,tvals(t));
        %
        %                         [Ci, Q] = modularity_louvain_und(cohmat);
        %                         mod(s,f,t) = Q;
        %                         modi(s,f,:) = Ci;
        %                         bet(s,f,:) = betweenness_wei(1./cohmat);
        %                         meanbet(s,f) = mean(nonzeros(bet(s,f,:)));
        %
        %                         dist(s,f,t) = 0;
        %                         for m = 1:max(Ci)
        %                             distmat = chandist(Ci == m,Ci == m);% .* (cohmat(Ci == m,Ci == m) > 0);
        %                             dist(s,f,t) = dist(s,f,t) + mean(mean(distmat));
        %                         end
        %                         dist(s,f,t) = dist(s,f,t) / max(Ci);
        %
        %                         maxci(s,f,t) = max(Ci);
        %                         clust(s,f,:) = clustering_coef_wu(cohmat); %clustering coeffcient
        %             %characteristic path length and efficiency with weights
        %                         [charp(s,f,t) eff(s,f,t)] = charpath(distance_wei(1./cohmat));
        %         end
    end
    %grp(s,1) = subjlist{s,2};
    
end

%meanmat = meanmat ./ length(subjlist);
%matrix = meanmat;
%save meanmat.mat matrix chanlocs

%spectra = meanspectra ./ length(subjlist);
%save('meanspectra.mat','spectra','bandpower','grp');

%save batch.mat grp bandpower clust modi bet meanbet tvals charp eff mod dist maxci %wdcorr %chanlocs
save bigmatfmri.mat bigmat subjlist bigchanlocs
% save bandpowerfmri.mat bandpower specinfo
% save distinfofmri.mat degree weight