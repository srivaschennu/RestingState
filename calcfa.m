function fa = calcfa

loadpaths
loadsubj
% 
% patients = [
%     
% 19262    20110207
% 19277    20110215
% 19829    20110905
% 18744    20110919
% 19655    20110620
% 20112    20111128
% 20174    20120618
% 17680    20121001
% 21348    20120917
% 21636    20130125
% 21675    20130417
% 22248    20130701
% 21415    20121015
% 19348    20110307
% 20466    20120305
% 19219    20110124
% 19306    20110221
% 19447    20110404
% 19475    20110411
% 19551    20110509
% 19757    20110801
% 19953    20111017
% 20054    20111114
% 20255    20120123
% 13676    20120320
% 20800    20120514
% 18872    20110704
% 17853    20110321
% 16656    20111010
% 21482    20121112
% 21677    20130204
% 22117    20130603
% 
% ];

for p = 1:size(patlist,1)
    %     date = num2str(patients(p,2));
    %     fileinfo = dir(sprintf('%sMRI/FA_%d_%s*.nii',filepath,patients(p,1),date(1:6)));
    %     if length(fileinfo) ~= 1
    %         fprintf('Skipping %d\n',patients(p,1));
    %     end
    %     data = niftitomat(sprintf('%sMRI/%s',filepath,fileinfo.name));
    
    load(sprintf('%sMRI/FA_%d.mat',filepath,patlist{p,end}),'data');
    fa(p) = mean(nonzeros(data(:)));
end