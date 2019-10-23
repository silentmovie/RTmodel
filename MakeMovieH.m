%% Make Movie for RT Mixing h-Model
% author: Bohan Zhou
% email: bhzhouzhou@math.ucdavis.edu
% Created Date: 2017/01/16
% Modified Date: 2017/01/26
% Copy Right:
% Reference: R.Granero-Belinchon, S. Shkoller A model of Rayleigh-Taylor
% Mixing
%% Input & Output

%% Examples:

%% This is Main Function
clear;
clc;
numexp = 5;
N = 2^7;
rtop = 2;
rbot = 1;
espsilon = 0.008;
s = 3;
[h, lifespan, hrange, ttotal]= Mixingh_new(numexp,N,rtop,rbot,espsilon,s);
hmax = hrange(1);
hmin = hrange(2);
rhobox = zeros(N,N);

Date = datestr(datetime('now'));
Run_rhobox=VideoWriter(['Hmodel_',Date,'.avi']);
Run_rhobox.FrameRate = 12;
parameterlist = {
['N = ' num2str(N)],
['number of experiments = ' num2str(numexp)],
['rho of top fluid = ' num2str(rtop)],
['rho of bot fluid = ' num2str(rbot)],
['viscosity = ' num2str(espsilon)],
['viscosity = ' num2str(s)],
['lifespan = ' num2str(lifespan)],
};
fid = fopen(['Zmodel',' ',Date,'.txt'],'w');
fmtString = [repmat('%s\t',1,size(parameterlist,2)-1),'%s\n'];
fprintf(fid,fmtString,parameterlist{:});
fclose(fid);

open(Run_rhobox)
for ii= 1 : 10 : lifespan/2
    ii
    for i = 1 : numexp
    index = (h(ii,:,i)-hmin)*(N-1)/(hmax-hmin)+1;
    index = round(index);
    for jj=1:N
        if index(jj) >= N
            rhobox(:,jj) = rhobox(:,jj) + rbot;
        else if index(jj) <=0
                rhobox(:,jj) = rhobox(:,jj) + rtop;
            else
            rhobox(1:index(jj),jj) = rhobox(1:index(jj),jj) + rbot;
            rhobox(index(jj)+1:end,jj)= rhobox(index(jj)+1:end,jj) + rtop;
    
            end
        end
    end
    end
    rhobox = rhobox/numexp;
    image([-3:6/(N-1):3],[hmin:(hmax-hmin)/(N-1):hmax],rhobox(:,:),'CDataMapping','scaled')
    set(gca,'YDir','normal');
    xlim([-3,3])
    ylim([hmin,hmax])
    colorbar
    title({['H Model',' ','i=' num2str(ii),'ms'];['N=' num2str(N),' ','numexp=' num2str(numexp),' ','espsilon=' num2str(espsilon),' ','viscosity order=' num2str(s)]});
    currFrame = getframe(gcf);
    writeVideo(Run_rhobox,currFrame);
    
    rhobox = zeros(N,N);
        
end
close(Run_rhobox)