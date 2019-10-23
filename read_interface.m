function [z1,z2,N,numexp,rtop,rbot,espsilon,lifespan,sigma] = read_interface(FolderName)
% %% Read z1,z2,N,lifespan,numexp from saved data;
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
z1name ='z1.mat';
z2name ='z2.mat';
parametername = 'parameter.mat';
z1name = fullfile(FolderName,z1name);
z2name = fullfile(FolderName,z2name);
parametername = fullfile(FolderName,parametername);
z1 = load(z1name);
z2 = load(z2name);
parameter = load(parametername);
z1 = z1.z1;
z2 = z2.z2;
parameter = parameter.parameter;
N = parameter(1);
numexp = parameter(2);
rtop = parameter(3);
rbot = parameter(4);
espsilon = parameter(5);
lifespan = parameter(6);
sigma = parameter(7);
end

