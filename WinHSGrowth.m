function out = WinHSGrowth(FolderName,s,WinLocation,WinCoord,rhobox)
%% Make a Movie for RT Mixing z-Model
% author: Bohan Zhou
% email: bhzhouzhou@math.ucdavis.edu
% Created Date: 2017/03/10
% Modified Date: 2017/03/10
% Copy Right:
% Reference: R.Granero-Belinchon, S. Shkoller A model of Rayleigh-Taylor
% Mixing
%% Read Rhobox
switch nargin
    case 4
        rhoboxname ='rhobox.mat';
        rhoboxname = fullfile(FolderName,rhoboxname);
        rhobox = load(rhoboxname);
        rhobox = rhobox.rhobox;
    case 5
end
%% Read Other Parameters
[z1,z2,N,numexp,rtop,rbot,espsilon,lifespan,~] = read_interface(FolderName);
[xmin,xmax,ymin,ymax] = read_range(FolderName);
xrange = xmax-xmin;
yrange = ymax-ymin;
winbl = WinLocation(1:2);
wintr = WinLocation(3:4);
bot = WinCoord(1);
left = WinCoord(2);
top = bot+WinCoord(3)-1;
right = left+WinCoord(4)-1;
%% Compute H^s norm of window
for i = 1:lifespan
    i
    average = trapz(rhobox(bot:top,left:right,i))*(wintr(1)-winbl(1))/(top-bot);
    average = trapz(average)*(wintr(2)-winbl(2))/(right-left);
    average = average/((wintr(2)-winbl(2))*(wintr(1)-winbl(1)));
    rhoboxBAR = rhobox(bot:top,left:right,i)-average;
    HSgrowth(i) = HdotNorm(rhoboxBAR,s,xrange,yrange);
end
out = HSgrowth;
end