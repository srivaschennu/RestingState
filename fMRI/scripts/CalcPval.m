% IG 16/10/12 Calculate P-values
clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
Paoladir = [Homedir filesep 'scripts/Cam/Paola'];
WcorFile = [Homedir filesep 'results\Wcor_168_CI.mat'];
load(WcorFile);
redes=load(fullfile(Paoladir,'6redes_168rois.txt'));

for isubj = 1:3
    r = Wcor(1,isubj).scale3; % Correlation
    l = Wcor(1,isubj).CI_lo3; % Lower Confidence Interval
    u = Wcor(1,isubj).CI_up3; % Upper Confidence Interval
    
    SE = (u-l)/(2*1.96);            % Standard Error
    M = (u+l)/2;                    % Mean
    t = (r-M)/SE;                   % T-value
    p = exp(-0.717*t - 0.416*t^2);  % P-value
    
    % correction for multiple comparisons
    [p_fdr, p_masked] = fdr(p);
    
    % sort matrixes
    [dum sortidx]=sort(redes);
    sortedr = r(sortidx,sortidx);
    sortedp = p(sortidx,sortidx);
    sortedp_fdr = p_fdr(sortidx,sortidx);
    
    % save
    Wcor(1,isubj).pVal2 = p;
    Wcor(1,isubj).sorted.scale3 = sortedr;
    Wcor(1,isubj).sorted.pVal3 = sortedp;
    Wcor(1,isubj).sorted.fdr3 = sortedp_fdr;
end
%save(WcorFile,'Wcor')

% get index of non-sig p-values. let the r values of those indices be 0



% preal = real(p);
% TF = isreal(preal); % check if preal has imaginary content. 1 --> real; 0 --> imaginary
% tf = isnumeric(preal); % check if preal is numeric. 1 --> numeric
% prealvector = reshape(preal,1,28224); % makes a vector of the array
% FDR = mafdr(prealvector);