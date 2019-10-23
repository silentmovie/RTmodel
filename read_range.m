function [xmin,xmax,ymin,ymax] = read_range(FolderName)
% %% Read Range from saved data;
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
rangename ='range.mat';
rangename = fullfile(FolderName,rangename);
range = load(rangename);
range = range.range;
xmin = range(1);
xmax = range(2);
ymin = range(3);
ymax = range(4);
end