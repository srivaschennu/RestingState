%SC 13.12.12 t-test and anova on mean

Homedir = fullfile('C:','Users','Ithabi','Documents');
Resultsdir = [Homedir filesep 'results\'];
cd(Resultsdir)

Value = {'B';'C';'D';'E'};

% xlswrite(filename,Array,sheet,range) range: C1:C2
fidex = [Resultsdir 'T-test.xlsx']; % filename


for j = 1:4 % FP,DMN, SM, OCC
    % load patient and control data
    load('graphdata.mat')
    patdata = GraphData(j:4:end,:); % takes FP for each subject
    load('PropRest_GraphData.mat')
    ctrldata = GraphData(j:4:end,:);
    
    for i = 10:12 % for all the GT measures
        [p,h] = ranksum(ctrldata(:,i),patdata(:,i)) %t-test: Wilcoxon rank sum test; Test the hypothesis of equal medians for two independent unequal-sized samples.
        %anova1(cat(1,ctrldata(:,i),patdata(:,i)),cat(1,ones(size(ctrldata,1),1),2*ones(size(patdata,1),1)))
        xlswrite(fidex,h,1,[Value{j} int2str(i+2)]);
    end % i
end % j


