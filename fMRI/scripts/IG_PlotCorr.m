%IG 15/10/12 Plot Correlation
Networks = {'Cing';'FP';'DMN';'SM';'Occ';'Cer';'Thal'};
cd('C:\Users\Ithabi\Documents\results')
load sortedWcor.mat
imagesc(sortedWcor)
hold on
x = [33,54,88,121,142,161,168];
y = [0 169];
for i = 1:6
line([x(i) x(i)],y)
line(y,[x(i) x(i)])
end
legend(Networks)
 %   saveas(gcf,[Homedir '\Figures\PropRestCorr\' int2str(isubj) '.jpg'])

% fix Colorbar! to compare different subjects