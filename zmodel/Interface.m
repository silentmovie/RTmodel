% %% Compute interface for RT Mixing z-Model and save data
% % author: Bohan Zhou
% % email: bhzhouzhou@math.ucdavis.edu
% % Created Date: 2017/03/07
% % Modified Date: 2017/03/07
% % Copy Right:
% % Reference: R.Granero-Belinchon, S. Shkoller A model of Rayleigh-Taylor
% % Mixing
% %% Input & Output
% 
% %% Examples:
% 
%% This is Main Function
%% Parameters
clear;
clc;
numexp = 1;
N = 2^9;
dx = pi/N;
rtop=0.66;
rbot=1.89;
espsilon = 0.15;
%espsilon = 0; 
visorder = 2;
sigma = 0.001*pi;
T = 460;                % interested time node T>0

%% PDE solver
[z1, z2, lifespan]= MixingZ(numexp,N,rtop,rbot,espsilon,visorder,sigma,T);

%% Saving
save_data(T,numexp,N,espsilon,sigma,rtop,rbot,lifespan,z1,z2)
