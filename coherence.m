
function coherence
% matrix with all coherence number for a frequency interval : freq1:freq2

loadpaths

alpha = 0.05;

namelist = {
    
% %     controls
%
% 'jenny_restingstate'
% %'SaltyWater_restingstate'
% 'NW_restingstate'
% 'p37_restingstate'
% 'p38_restingstate'
% 'p40_restingstate'
% 'p41_restingstate'
% 'p42_restingstate'
% 'p43_restingstate'
% 'p44_restingstate'
% 'p45_restingstate'
% 'p46_restingstate'
% 'p47_restingstate'
% 'p48_restingstate'
% 'p49_restingstate'
% % 'p50_restingstate'
% 'subj01_restingstate'
% 'subj02_restingstate'
% 'VS_restingstate'
% 'SS_restingstate'
% 'SB_restingstate'
% 'ML_restingstate'
% 'MC_restingstate'
% 'JS_restingstate'
% % 'FD_restingstate'
% 'ET_restingstate'
% 'EP_restingstate'
% % 'CS_restingstate'
% 'CL_restingstate'
% 'CD_restingstate'
% 'AC_restingstate'
%
% %
% % patients
%
% 'p0112_restingstate'
% 'p0211V2_restingstate'
% 'p0211_restingstate1'
% 'p0211_restingstate2'
% 'p0311V2_restingstate'
% 'p0311_restingstate1'
% 'p0311_restingstate2'
% % % 'p0411V2_restingstate'
% 'p0411_restingstate1'
% % % 'p0411_restingstate2'
% 'p0510V2_restingstate'
% % % 'p0511V2_restingstate'
% % % 'p0511_restingstate'
% 'p0611_restingstate'
% 'p0710V2_restingstate'
% 'p0711_restingstate'
% 'p0811_restingstate'
% 'p0911_restingstate'
% 'p1011_restingstate'
% 'p1311_restingstate'
% 'p1511_restingstate'
% 'p1611_restingstate'
% 'p1711_restingstate'
% 'p1811_restingstate'
% 'p1911_restingstate'
% 'p2011_restingstate'
% % % 'p2111_restingstate'

% 'p0212_restingstate'
% 'p0312_restingstate'
% %'p0512_restingstate' %bad
% 'p1811v2_restingstate'

    'p0211_restingstate2'   2   14
    'p1711_restingstate'    2   19
    'p0112_restingstate'	1   9
    'p0711_restingstate'    2   15
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

};



for subjidx = 1:size(namelist,1)
    basename = namelist{subjidx,1};
    
    load([filepath basename 'spectra.mat']);
%    load([filepath basename 'icohboot.mat']);
    
    EEG = pop_loadset('filename',[basename '.set'],'filepath',filepath);
    
    chanlocs = EEG.chanlocs;
    specdata = load([filepath basename 'spectra.mat']);
    freqlist=specdata.freqlist;
    
    
    matrix=zeros(size(freqlist,1),EEG.nbchan,EEG.nbchan); % size(freqlist,1) lines ; EEG.nbchan columns ; EEG.nbchan time this table
    pval=zeros(size(freqlist,1),EEG.nbchan,EEG.nbchan);
    
    % matrixcoherence of each pair of electrodes
    for chann1=1:EEG.nbchan
        for chann2=1:EEG.nbchan
            if chann1 < chann2
                [cohall, cohbootall, freqsout] = calcpli(EEG,chann1,chann2);
                
                for fidx = 1:size(freqlist,1)
                    [matrix(fidx,chann1,chann2) pval(fidx,chann1,chann2)] = ...
                        bandcoh(freqlist(fidx,1),freqlist(fidx,2),cohall,cohbootall,freqsout);
                end
            elseif chann1 > chann2
                matrix(:,chann1,chann2)=-(matrix(:,chann2,chann1));
                pval(:,chann1,chann2) = pval(:,chann2,chann1);
                
            end
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        save([filepath basename 'pliboot.mat'],'matrix','pval','chanlocs');
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    
    
    %%% FDR correction
    for f = 1:size(freqlist,1)
        coh = abs(squeeze(matrix(f,:,:)));
        pvals = squeeze(pval(f,:,:));
        
        tmp_pvals = pvals(logical(triu(ones(size(pvals)),1)));
        tmp_coh = coh(logical(triu(ones(size(coh)),1)));
        
        [~, p_masked]= fdr(tmp_pvals,alpha);
        tmp_pvals(~p_masked) = 1;
        tmp_coh(tmp_pvals >= alpha) = 0;
        
        coh = zeros(size(coh));
        coh(logical(triu(ones(size(coh)),1))) = tmp_coh;
        coh = triu(coh,1)+triu(coh,1)';
        
        pvals = zeros(size(pvals));
        pvals(logical(triu(ones(size(pvals)),1))) = tmp_pvals;
        pvals = triu(pvals,1)+triu(pvals,1)';
        
        matrix(f,:,:) = coh;
        pval(f,:,:) = pvals;
    end
    save([filepath basename 'plifdr.mat'],'matrix','pval','chanlocs');
    
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    get the matrixes symetric
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% for subjidx = 1:size(namelist)
%     basename = namelist{subjidx};
%
%
%     load(['C:\Users\Eleonore\Documents\MATLAB\RSpcohicoh\icoh\' basename 'icoh.mat']);
%     specdata = load(['C:\Users\Eleonore\Documents\MATLAB\RSspectra\' basename 'spectra.mat']);
%     freqlist=specdata.freqlist;
%
%      a=triu(a,1)+triu(a,1)'; attention notation mauvaise, mais manip �
%      faire

%     end
%     save([basename 'icohsym.mat'],'matr','chanlocs');
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    get absolute values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% for subjidx = 1:size(namelist)
%     basename = namelist{subjidx};
%
%     load(['C:\Users\Eleonore\Documents\MATLAB\RSpcohicoh\icoh\' basename 'icohboot.mat']);
%     specdata = load(['C:\Users\Eleonore\Documents\MATLAB\RSspectra\' basename 'spectra.mat']);
%     freqlist=specdata.freqlist;
%
%     mat=zeros(size(freqlist,1),91,91);
%
%     for fidx = 1:size(freqlist,1)
%         mat(fidx,:,:)=abs(matrix(fidx,:,:));
%     end
%
%     save([basename 'icohbootabs.mat'],'mat','chanlocs');
% end
