function OneRhobox(FolderName)
rhoboxname ='rhobox.mat';
rhoboxname = fullfile(FolderName,rhoboxname);
rhobox = load(rhoboxname);
rhobox = rhobox.rhobox;
[~,~,N,numexp,rtop,rbot,espsilon,lifespan,~] = read_interface(FolderName);
[xmin,xmax,ymin,ymax] = read_range(FolderName);
xrange = xmax-xmin;
yrange = ymax-ymin;
MovieName = 'Zmodel.avi';
MovieName = fullfile(FolderName,MovieName);
Run_rhobox=VideoWriter(MovieName);
Run_rhobox.FrameRate = 4;
open(Run_rhobox);
for i = 1:lifespan
figure(1)
image([xmin:xrange/(N-1):xmax],[ymin:yrange/(N-1):ymax],rhobox(:,:,i),'CDataMapping','scaled')
caxis([rtop,rbot])
set(gca,'YDir','normal');
xlim([xmin,xmax])
ylim([ymin,ymax])
colormap hot
colorbar
title({['Z Model',' ','i=' num2str(i),'ms'];['N=' num2str(N),' ','numexp=' num2str(numexp),' ','espsilon=' num2str(espsilon)]});
currFrame = getframe(gcf);
writeVideo(Run_rhobox,currFrame); 
end
close(Run_rhobox)