% IG 22/01/13 Correlate eeg bandpower of channelgroups to fMRI GT measures
changroups = {{'O1' 'O2'} {'E19' 'E4'}};

banddata = zeros(length(specinfo),length(changroups));
for ifreq = 1:5
    for isubj = 1:length(specinfo)
        for icg = 1:length(changroups)
            changroup = changroups{icg};
            [~,chanidx] = ismember(changroup,{specinfo{isubj}.chann.labels});
            banddata(isubj,icg,ifreq) = mean(bandpower(isubj,ifreq,chanidx),3);
        end %icg
    end %isubj
end %ifreq 