%IG 18/03/13 Delete irrelevant patients out of Variables

clear all

Resultsdir = fullfile('C:','Users','Ithabi','Documents','results');
load([Resultsdir filesep 'Wcor_168_CI.mat']);

A = Wcor(1,1:3);
A(1,4) = Wcor(1,5);
A(1,5) = Wcor(1,8);

j = [12 14 16 19 20 21 23 26 27 28 31];
for i = 6:16
A(1,i) = Wcor(1,j(i-5));
end

clear Wcor;
Wcor = A;
save('Wcor_168_CI_N16','Wcor')

% cut timeseries from 32 subj to 16
index = [1 2 3 5 8 12 14 16 19 20 21 23 26 27 28 31]; 
timeseries_168 = timeseries_168(index);
save('timeseries_168_N16.mat','timeseries_168')