% IS Gantner 15/11/2012
close all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
Filesdir = [Homedir filesep 'Subject' filesep 'Movement_rp'];
F = spm_select('FPList', Filesdir,'rp.*\.txt$');

for i=1:22
    figure
    mp = load(F(i,:));
    plot(mp); title(F(i,50:63)); %axis([0 length(mp) -3 3])
    %saveas (gcf,[Homedir filesep 'Figures' filesep 'Movement' filesep Subj{subj} '.fig'])
end