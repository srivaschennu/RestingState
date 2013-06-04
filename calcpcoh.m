% coherences
function [coh cohbootall freqsout] = calcicoh(EEG,chann1,chann2)

chann1
chann2 

[coh,mcoh,timesout,freqsout,cohboot,cohangles,...
allcoher,alltfX,alltfY,cohbootall] = ...
pop_newcrossf( EEG, 1, chann1, chann2, [EEG.xmin  EEG.xmax] * 1000, 0 ,...@ 0 dc fait fft au lieu de l'autre. permet de commencer analyse a 0.5Hz. 1 : wavelet dc mieux, commence aussi a 0.5hz comparer
    'type', 'phasecoher','alpha',0.001,'padratio', 1,'plotamp','off','plotphase','off');

% for f = 1:size(coh,1)
%     coh(f,coh(f,:) <= cohboot(f)) = 0;
% end

cohbootall = abs(cohbootall);
end

% calcule cross coherence entre 2 canaux