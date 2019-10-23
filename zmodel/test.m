N = 2^9;
z1=(-N/2:N/2-1)*2*pi/N;
z1=z1';
z2=sin(2*z1);
numexp = 1;
xmin = min(z1);
xmax = max(z1);
xrange = xmax-xmin;
ymin = min(z2);
ymax = max(z2);
yrange = max(z2)-min(z2);
rtop=0.66;
rbot=1.89;
rhobox = MakeRhobox(z1,z2,numexp,N,yrange,ymin,rtop,rbot);
image([-pi/2:pi/N:pi/2],[ymin:yrange/N:ymax],rhobox,'CDataMapping','scaled')
caxis([rtop,rbot])
set(gca,'YDir','normal');
xlim([-pi/2,pi/2])
ylim([ymin,ymax])
colormap hot
colorbar
out = HdotNorm(rhobox,-1,xrange,yrange)
