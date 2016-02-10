atlasname = 'Destrieux';
atlasidx = find(strcmp(atlasname,{cortex.Atlas.Name}));
nlocs = length(cortex.Atlas(atlasidx).Scouts);
seedlist = cell2mat({cortex.Atlas(atlasidx).Scouts.Seed});
mnivert = cs_convert(mri,'scs','mni',cortex.Vertices);
mnivert = mnivert * 1000;


cohmat = zeros(nlocs,nlocs);
idx_upper = find(triu(ones(nlocs,nlocs)));
cohmat(idx_upper) = abs(conn.TF);
cohmat(1:nlocs+1:nlocs*nlocs) = 0;
cohmat = triu(cohmat,1)+triu(cohmat,1)';
threshcoh = threshold_proportional(cohmat,0.1);
[Ci,Q] = community_louvain(threshcoh);
deg = sum(threshcoh,1) ./ (size(threshcoh,1)-1);
dlmwrite('threshcoh.edge',threshcoh,'\t');


fid = fopen(sprintf('Node_%s%d.node',atlasname,length(seedlist)),'w');
for s = 1:nlocs
    fprintf(fid,'%f\t%f\t%f\t%d\t%f\t%s\n',...
        mnivert(seedlist(s),:),...
        Ci(s),...
        deg(s),...
        strrep(cortex.Atlas(atlasidx).Scouts(s).Label,' ','_'));
end
fclose(fid);

BrainNet_MapCfg('BrainMesh_ICBM152.nv','Node_Destrieux148.node','threshcoh.edge');