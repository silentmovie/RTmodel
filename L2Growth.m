function out = L2Growth(FolderName,rhobox)
%% Make a Movie for RT Mixing z-Model
% author: Bohan Zhou
% email: bhzhouzhou@math.ucdavis.edu
% Created Date: 2017/03/09
% Modified Date: 2017/03/09
% Copy Right:
% Reference: R.Granero-Belinchon, S. Shkoller A model of Rayleigh-Taylor
% Mixing
%% Read Rhobox
switch nargin
    case 1
        rhoboxname ='rhobox.mat';
        rhoboxname = fullfile(FolderName,rhoboxname);
        rhobox = load(rhoboxname);
        rhobox = rhobox.rhobox;
    case 2
end
%% Read Other Parameters
[z1,z2,N,numexp,rtop,rbot,espsilon,lifespan,~] = read_interface(FolderName);
[xmin,xmax,ymin,ymax] = read_range(FolderName);
xrange = xmax-xmin;
yrange = ymax-ymin;
%dx = xrange/(N-1);               Verify Parsavel's Thm
%dy = yrange/(N-1);
%% Compute L2 norm of entire region
rhobox=rhobox(1:end-1,1:end-1,:);
for i = 1:lifespan
    i
    %L1growth(i) = sqrt(trapz(trapz(abs(rhobox(:,:,i)).^2))*dx*dy);
    L2growth(i) = HdotNorm(rhobox(:,:,i),0,xrange,yrange);
end
out = L2growth;
%plot(0:lifespan-1,L1growth-L2growth)
end