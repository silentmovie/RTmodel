function MakeMovie(FolderName)
%% Make a Movie for RT Mixing z-Model
% author: Bohan Zhou
% email: bhzhouzhou@math.ucdavis.edu
% Created Date: 2017/03/07
% Modified Date: 2017/03/07
% Copy Right:
% Reference: R.Granero-Belinchon, S. Shkoller A model of Rayleigh-Taylor
% Mixing
%% Read Rhobox
rhoboxname ='rhobox.mat';
rhoboxname = fullfile(FolderName,rhoboxname);
rhobox = load(rhoboxname);
rhobox = rhobox.rhobox;
[~,~,N,numexp,rtop,rbot,espsilon,lifespan,~] = read_interface(FolderName);
%lifespan=421;
[xmin,xmax,ymin,ymax] = read_range(FolderName);
xrange = xmax-xmin;
% ymin = -0.6059;
% ymax = 0.6471;
yrange = ymax-ymin;
%% Manual
%winbl = [-0.1359,0.0707];               % [bottom,left] point
%winbl = [-0.1359,0.18];
%wintr = [-0.07,0.2490];                 % [top,right] point
winbl = [0.01,-1.5];
wintr = [0.2,-1.25];

left = round((winbl(2)-xmin)/xrange*(N-1)+1);
right = round((wintr(2)-xmin)/xrange*(N-1)+1);
bot = round((winbl(1)-ymin)/yrange*(N-1)+1);
top = round((wintr(1)-ymin)/yrange*(N-1)+1);
WinLocation = [winbl,wintr];
WinCoord =[bot,left,top-bot+1,right-left+1];
%% Automatic
% WinSize = [24,32];
% [WinLocation,WinCoord] = FindWindow(FolderName,WinSize,rhobox);
% winbl = WinLocation(1:2);
% wintr = WinLocation(3:4);
% bot = WinCoord(1);
% left = WinCoord(2);
% top = bot+WinCoord(3)-1;
% right = left+WinCoord(4)-1;
%%

growth = WinHSGrowth(FolderName,-1,WinLocation,WinCoord,rhobox);
%growthH1minus(1:lifespan) = HdotNorm(rhobox(1:end-1,1:end-1,1:lifespan),-1,xrange,yrange);
growthL2 = L2Growth(FolderName,rhobox);
%% Pre-Movie
MovieName = 'Zmodel.avi';
MovieName = fullfile(FolderName,MovieName);
Run_rhobox=VideoWriter(MovieName);
Run_rhobox.FrameRate = 4;
open(Run_rhobox)
mingrowth = min(growth);
maxgrowth = max(growth);
% mingrowthH1minus = min(growthH1minus);
% maxgrowthH1minus = max(growthH1minus);
mingrowthL2 = min(growthL2);
maxgrowthL2 = max(growthL2);
timezone = (0:lifespan-1)*0.001;
% figure 1
figure(1)
[~,MaxIndex] = max(growth);
%subplot(2,1,1)
%plot([MaxIndex-1:lifespan-1]*0.001,growth(MaxIndex:lifespan)/growth(MaxIndex))
%title('H^{-1} norm/H^{-1} norm at Max VS TIME')
%subplot(2,1,2)
plot([MaxIndex-1:lifespan-1]*0.001,log(growth(MaxIndex:lifespan)/growth(MaxIndex)))
title('log(H^{-1} norm/H^{-1} norm at Max) VS TIME')
%% Movie
for i = 1:lifespan
figure(2)
subplot(5,1,[1 2])
image([xmin:xrange/(N-1):xmax],[ymin:yrange/(N-1):ymax],rhobox(:,:,i),'CDataMapping','scaled')
caxis([rtop,rbot])
rectangle('Position',[winbl(2),winbl(1),wintr(2)-winbl(2),wintr(1)-winbl(1)],'EdgeColor','b')
set(gca,'YDir','normal');
xlim([xmin,xmax])
ylim([ymin,ymax])
colormap hot
colorbar
title({['Z Model',' ','i=' num2str(i),'ms'];['N=' num2str(N),' ','numexp=' num2str(numexp),' ','espsilon=' num2str(espsilon)]});

subplot(5,1,3)
% axes(ax3)
image([winbl(2):(wintr(2)-winbl(2))/(right-left):wintr(2)],[winbl(1):(wintr(1)-winbl(1))/(top-bot):wintr(1)],rhobox(bot:top,left:right,i),'CDataMapping','scaled')
caxis([rtop,rbot])
set(gca,'YDir','normal');
xlim([winbl(2),wintr(2)])
ylim([winbl(1),wintr(1)])
colormap hot
colorbar
title('Zoom-In')

subplot(5,1,4)
plot(timezone(1:i),growth(1:i))
xlim([0,lifespan-1]*0.001)
ylim([mingrowth,maxgrowth])
title('H^{-1} norm of interested windows')

% subplot(4,1,3)
% plot(timezone(1:i),growthH1minus(1:i))
% xlim([0,lifespan-1]*0.001)
%ylim([mingrowthH1minus,maxgrowthH1minus])
%title('H^{-1} norm of entire region')

subplot(5,1,5)
plot(timezone(1:i),growthL2(1:i))
xlim([0,lifespan-1]*0.001)
ylim([mingrowthL2,maxgrowthL2])
title('L^2 norm of entire region')
 
currFrame = getframe(gcf);
writeVideo(Run_rhobox,currFrame); 

end
close(Run_rhobox)
% figure(3)
% plot(timezone(1:lifespan),growthL2(1:lifespan))
% xlim([0,lifespan-1]*0.001)
% ylim([mingrowthL2,maxgrowthL2])
% title('L^2 norm of entire region')
%end