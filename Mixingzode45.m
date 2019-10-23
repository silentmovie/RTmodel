function Ftotal=Mixingzode45(T,yold,D,D2,L,H,D3,A,g,N,espsilon,visorder,tensor)
%% RT Mixing z-model
%
% author: Rafael Granero-Belinchon, Bohan Zhou
% email: rgranero@math.ucdavis.edu, bhzhouzhou@math.ucdavis.edu
% Created Date: 2016/01/16
% Modified Date: 2017/01/19
% Copy Right:
% Reference: R.Granero-Belinchon, S. Shkoller A model of Rayleigh-Taylor
% Mixing
%% Input & Output

%% Examples:

%% In this file we compute the RHS for this equation

deltaz1old=yold(1:N); %perturbation from being a graph
z2old=yold(N+1:2*N); %second coordinate of the interface
wold=yold(2*N+1:end); %amplitude of vorticity

A1=1+real(ifft(D.*deltaz1old));
A2=real(ifft(D.*z2old));

G=(A1).^2+(A2).^2;

RHS1=0.5*fft(real(ifft((H.*wold))).*(-A2./G))+espsilon*D2.*deltaz1old; %RHS for the height function z_1
RHS2=0.5*fft(real(ifft(H.*wold)).*(A1./G))+espsilon*D2.*z2old; %RHS for the height function z_2

N1=2*A*g*fft(A2); %Linear term due to gravity
N3=(-A/2)*D.*fft((1./G).*real(ifft(H.*fft(real(ifft(wold)).*real(ifft(H.*wold))))));
N7=D2.*wold;
RHS3=N1+N3+espsilon*N7;%RHS for the vorticity

Ftotal=[RHS1;RHS2;RHS3];
