bardata = zeros(5,3);
errdata = zeros(5,3);
for g = 1:3
    bardata(:,g) = mean(bandpower(grp == g-1,:))';
    errdata(:,g) = std(bandpower(grp == g-1,:))'/sqrt(sum(grp == g-1));
end

figure('Name',mfilename,'Color','white');
barweb(bardata,errdata, [], {'delta','theta','alpha','beta','gamma'}, ...
    [], [], [], [], [], {'VS','MCS','Control'}, 1, []);
set(gca,'YLim',[-6 17],'FontName','Gill Sans','FontSize',16,'FontWeight','bold');
xlabel('Frequency bands','FontName','Gill Sans','FontSize',16,'FontWeight','bold');
ylabel('Band power (dB)','FontName','Gill Sans','FontSize',16,'FontWeight','bold');