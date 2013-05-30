clear,clc,close all

redes=load(fullfile(dir,'6redes_160rois.txt'));
[redes ordredes]=sort(redes);
%%
cd(fullfile(dir,'Resultados','Resultados_160rois'));
load Wcor_cientosesenta_68.mat;

for run=1:3
    alto=[];bajo=[];
    for jj=1:length(grupo_bajo)
        bajo=cat(3,bajo,Wcor(grupo_bajo(jj)).run(run).scale3(ordredes,ordredes));
        alto=cat(3,alto,Wcor(grupo_alto(jj)).run(run).scale3(ordredes,ordredes));
    end
    ALL_alto(run,:,:,:)=alto;
    ALL_bajo(run,:,:,:)=bajo;
end
A=mean(ALL_alto,4);
B=mean(ALL_bajo,4);

AA = reshape(ALL_alto, 3,160*160,size(grupo_alto,2));
BB = reshape(ALL_bajo, 3,160*160,size(grupo_alto,2));


%%
close all
INDS=[3 1 2];close all
for i=1:3
    INDS(i);
    t=squeeze(A(INDS(i),:,:));
    figure;imagesc(t);caxis([0 0.65 ])
    axis off,axis square
    imprimelineas_160(gcf,'w');
end

for i=1:3
    INDS(i);
    t=squeeze(B(INDS(i),:,:));
    figure;imagesc(t);caxis([0 0.65 ])
    axis off,axis square
    imprimelineas_160(gcf,'w');
end




%% test t por grupo, intracondicion
mapa=[[1 0 0];[.95 .95 .95]; [0 0 1]];
close all

a1=squeeze(AA(1,:,:)); b1=squeeze(BB(1,:,:));
a2=squeeze(AA(2,:,:)); b2=squeeze(BB(2,:,:));
a3=squeeze(AA(3,:,:)); b3=squeeze(BB(3,:,:));

[H,P,CI,STATS]=ttest2(a1',b1'); TT(1,:,:) = reshape(STATS.tstat,160,160);
[H,P,CI,STATS]=ttest2(a2',b2'); TT(2,:,:) = reshape(STATS.tstat,160,160);
[H,P,CI,STATS]=ttest2(a3',b3'); TT(3,:,:) = reshape(STATS.tstat,160,160);

UMB=1.0;
co=['b','r','k'];
for i=1:3
    t=squeeze(TT(i,:,:));
    t= 1*(t<-UMB) -1*(t>UMB);
    figure;imagesc(t);
    axis off,axis square
    colormap(mapa)
    imprimelineas_160(gcf,'w')
    figure(19),hold on
    plot(smooth(-mean(t)),co(i))

    ylim([-0.75 0.75])
    legend({'resting','intero','extero'})
end


%% test t por condicion

% 
% mapa=[[1 0 0];[.95 .95 .95]; [0 0 1]];
% close all
% 
% a1=squeeze(AA(1,:,:)); b1=squeeze(BB(1,:,:));
% a2=squeeze(AA(2,:,:)); b2=squeeze(BB(2,:,:));
% a3=squeeze(AA(3,:,:)); b3=squeeze(BB(3,:,:));
% 
% [H,P,CI,STATS]=ttest2(a2',a3'); TT(1,:,:) = reshape(STATS.tstat,160,160);
% [H,P,CI,STATS]=ttest2(b2',b3'); TT(2,:,:) = reshape(STATS.tstat,160,160);
% UMB=1.0;
% co=['b','r','k'];
% for i=1:2
%     t=squeeze(TT(i,:,:));
%     t= 1*(t<-UMB) -1*(t>UMB);
%     figure;imagesc(t);
%     axis off,axis square
%     colormap(mapa)
%     imprimelineas_160(gcf,'w')
%     figure(19),hold on
%     plot(smooth(-mean(t)),co(i))
%     R(:,i) = -mean(t);
% end
