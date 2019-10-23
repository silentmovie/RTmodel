function [out1, out2, out3, out4]= Mixingh_new(numexp,N,rtop,rbot,espsilon,s)
%% RT Mixing h-Model
% author: Bohan Zhou
% email: bhzhouzhou@math.ucdavis.edu
% Created Date: 2016/11/28
% Modified Date: 2017/01/16
% Copy Right:
% Reference: R.Granero-Belinchon, S. Shkoller A model of Rayleigh-Taylor
% Mixing
%% Input & Output

%% Examples:

%%
tic;
dx = 2*pi/N; %grid step
x = dx * (-N/2:N/2-1)'; %spatial domain [-pi:pi)
dt = 1e-3; %time step
tend = 10; %terminate time

%% Parameters
g=9.8; %Gravity.
tensor=0; % surface tensor
r = rtop+rbot;
A = (rtop-rbot)/r; % Atwood number
% One derivative
k=[0:N/2-1, 0, -N/2+1:-1];% Modes for an odd derivative (the N/2 mode equals 0)
D=1i*k'; % derivative in Fourier space

% Three derivatives
D3=(1i*k').^3;% three derivatives in Fourier space
clear k

% Square root of the Laplacian
k=[0:N/2, -N/2+1:-1]'; % Modes for an even derivative
L=abs(k);% Square root of the Laplacian in Fourier space. 
clear k

% Laplacian
D2=-L.^2; %Laplacian

% Hilbert transform
k=[0:N/2, -N/2+1:-1]';
H=-1i*k./abs(k);%Hilbert transform in Fourier space. 
H(1)=0;
clear k

% Initial Data:

sigma = 0.0015*2*pi/0.3;      % standard deviation 0.0015*2*pi/0.3
mean = 0;
lifespan=tend/dt+1;

for i=1:numexp
i
n = 50;
randa = sigma*randn(n,1)+mean;  % standard Gaussian Distribution noise
h0norm = pi/100;
h0 = cos(x*(1:n))*randa + sin(x*(1:n))*randa;  % initial graph function
h0 = h0/norm(h0)*h0norm;     
w0 = zeros(N,1); % initial amplitude of vorticity
meanw = trapz(w0)*dx; % integral of the initial vorticity
y0 = [fft(h0);fft(w0)];
[~,y]=ode45(@Mixinghode45,[0:dt:tend],y0,[],D,D2,L,H,D3,A,g,r,meanw,N,espsilon,s,tensor);
lifespan = min(lifespan,length(y(:,1)));
for ii=1:lifespan
    h(ii,:,i)=real(ifft(y(ii,1:N)));
    w(ii,:,i)=real(ifft(y(ii,N+1:end)));
end
h = h(1:lifespan,:,1:i);

end

ttotal= toc;
out1 = h(1:lifespan,:,1:numexp);
out2 = lifespan;
hmax = max(max(max(h(1:lifespan/2,:,:))));
hmin = min(min(min(h(1:lifespan/2,:,:))));
out3 = [hmax, hmin];
out4 = ttotal;
end

