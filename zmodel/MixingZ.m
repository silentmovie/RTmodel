function [out1, out2, out3]= MixingZ(numexp,N,rtop,rbot,espsilon,visorder,sigma,T )
%% RT Mixing z-model
%
% author: Rafael Granero-Belinchon, Bohan Zhou
% email: rgranero@math.ucdavis.edu, bhzhouzhou@math.ucdavis.edu
% Created Date: 2016/01/16
% Modified Date: 2017/01/26
% Copy Right:
% Reference: R.Granero-Belinchon, S. Shkoller A model of Rayleigh-Taylor
% Mixing
%% Input & Output

%% Examples:


%% Physical parameters in the problem
dx = 2*pi/N; %grid step
x = dx * (-N/2:N/2-1).'; %spatial domain [-pi:pi)
h0 = zeros(N,1);
dt = 1e-3;
tend = 0.5;
count = 0;
%% Parameters
r=rtop+rbot;%rho^++rho-
A=(rtop-rbot)/r;%Atwood number
g=-1*9.8*2*pi/0.3; %Gravity. POSITIVE for pointing downward gravity field!!
tensor=0; % surface tensor
%% One derivative
k=[0:N/2-1, 0, -N/2+1:-1];%Modes for an odd derivative (the N/2 mode equals 0)
D=1i*k.';%derivative in Fourier space

%% Three derivatives
D3=(1i*k.').^3;%three derivatives in Fourier space
clear k

%% Square root of the Laplacian
k=[0:N/2, -N/2+1:-1].';%Modes for an even derivative
L=abs(k);%Square root of the Laplacian in Fourier space. 
clear k

%% Laplacian
D2=-L.^2; %Laplacian

%% Hilbert transform
k=[0:N/2, -N/2+1:-1].';
H=-1i*k./abs(k);%Hilbert transform in Fourier space. 
H(1)=0;
clear k

%% New Initial Data
% angle=5.7*2*pi/360; %in radians
% h0(x<-pi/2) = tan(angle)*(x(x<-pi/2)+pi);
% h0(x>pi/2) = tan(angle)*(x(x>pi/2)-pi);
% h0((x<=pi/2)&(x>=-pi/2)) = -tan(angle)*x((x<=pi/2)&(x>=-pi/2));
%h0 = sin(x);
%% Cycle Initial Data
% angle = (1:N)*2*pi/N;
% x = cos(angle);
% y = sin(angle);
% Perturbation
mean = 0;
lifespan=tend/dt+1;

while(count<numexp)
    
n=1; %number of modes
randa = sigma*randn(n,1)+mean;

noise = cos(x*(1:n))*randa*10 + sin(x*(1:n))*randa*10;
SSS=trapz(noise.*noise)*dx;
noise=noise/sqrt(SSS);
noise=sigma*noise;

h00=h0+noise;       %h00 is initial curve after addint noise
%h00 = h0;
ht=zeros(length(x),1); %Velocity
w0=2*real(ifft(H.*fft(ht)));%amplitude of the vorticity 
%(that solves C-2Hht=w where C is any constant)
y0=[fft(ht);fft(h00);fft(w0)];
%% Advancing in time
[~,y]=ode45(@Mixingzode45,[0:dt:tend],y0,[],D,D2,L,H,D3,A,g,N,espsilon,visorder,tensor);

if T>=0 && length(y(:,1))<T
    continue
end
count = count + 1
lifespan = min(lifespan,length(y(:,1)));
y = y.';
deltaz1 = real(ifft(y(1:N,1:lifespan)));
z1(:,1:lifespan,count)=x*ones(1,lifespan) + deltaz1;
z2(:,1:lifespan,count)=real(ifft(y(N+1:2*N,1:lifespan)));
w = real(ifft(y(2*N+1:end,1:lifespan)));
z1 = z1(:,1:lifespan,1:count);
z2 = z2(:,1:lifespan,1:count);
clear y;
end

out1 = z1(:,1:lifespan,1:numexp);
out2 = z2(:,1:lifespan,1:numexp);
out3 = lifespan;



