% IG 12.12.12: subscript:  save info in excell file
% -------------------------------------------------------------------------
% % xlswrite(filename,Array,sheet,range) range: C1:C2
% fidex = [Resultsdir 'GT_new.xls']; % filename
% xlswrite(fidex,GraphData,Value,'C3');

% % writing out the values per subject
% Sheet = Value+4;
% i = 3;
% k = 1;
% for j=1:18
% xlswrite(fidex,GraphData(k:k+3,:),Sheet,['C' int2str(i)]);
% i = i+5;
% k = k+4;
% end

% writing out per network
Sheet = Value+5;
xlswrite(fidex,graphData,Sheet,'B2');

% writing out means
xlswrite(fidex,MEAN,9,[Letter '2']);