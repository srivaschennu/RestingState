% SC 16/11/12 Get numeric values for balls coordinates from string in
% excell sheet
% -------------------------------------------------------------------------
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
[~,~,raw] = xlsread('Networks.xlsx');
netidx = cell2mat(raw(:,2));
doc strtok

% start
networks = cell2mat(raw(:,2));

for roi = 1:size(raw,1)
    [tok,remain] = strtok(raw{roi,4},' ');
    networks(roi,2) = str2double(tok);
    [tok,remain] = strtok(remain(2:end),' ');
    networks(roi,3) = str2double(tok);
    networks(roi,4) = str2double(strtok(remain(2:end),' '));
end
