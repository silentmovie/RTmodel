function [out1, out2] = FindWindow(FolderName,WinSize,rhobox)
% %% Load Data and Find Windows for RT Mixing z-Model and 
% % author: Bohan Zhou
% % email: bhzhouzhou@math.ucdavis.edu
% % Created Date: 2017/03/07
% % Modified Date: 2017/03/07
% % Copy Right:
% % Reference: R.Granero-Belinchon, S. Shkoller A model of Rayleigh-Taylor
% % Mixing
% %% Input & Output
% Winsize=[#Row,#Column];
% %% Examples:
%
%% Read Rhobox
switch nargin
    case 2
        rhoboxname ='rhobox.mat';
        rhoboxname = fullfile(FolderName,rhoboxname);
        rhobox = load(rhoboxname);
        rhobox = rhobox.rhobox;
    case 3
end
%% Read Other Parameters
[z1,z2,N,numexp,rtop,rbot,espsilon,lifespan,~] = read_interface(FolderName);
[xmin,xmax,ymin,ymax] = read_range(FolderName);
xrange = xmax-xmin;
yrange = ymax-ymin;
numRow = WinSize(1);
numColn = WinSize(2);
%%
rhoboxBAR = abs(rhobox(:,:,lifespan)-(rtop+rbot)/2);
switch nargin
    case 1   % Find largest windows with H^-1 norm of rho-avearge as min.
             % Peeding
    otherwise   % Find suitable windows of given size
        convRhobox = conv2(rhoboxBAR(round(N/2):end,:).^2,ones(WinSize),'valid');
        %convRhobox = conv2(rhoboxBAR.^2,ones(WinSize),'valid');
        [~,j] = min(min(convRhobox));
        [~,i] = min(convRhobox(:,j));
        i = round(N/2)+i-1;
end
winbl(1) = yrange/(N-1)*(i-1)+ymin;
wintr(1) = yrange/(N-1)*(i+numRow-1-1) +ymin;
winbl(2) = xrange/(N-1)*(j-1)+xmin;
wintr(2) = xrange/(N-1)*(j+numColn-1-1) + xmin;
out1 = [winbl,wintr];
out2 = [i,j,numRow,numColn];
end
