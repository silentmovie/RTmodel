function save_data(T,numexp,N,espsilon,sigma,rtop,rbot,lifespan,z1,z2)
% %% Save z1, z2, lifespan to .mat; Save parameterlist to .txt;
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
Date = datestr(datetime('now'));
NewFolder = Date;
mkdir(NewFolder)
z1mat = ['z1.mat'];
z1mat = fullfile(NewFolder,z1mat);
z2mat = ['z2.mat'];
z2mat = fullfile(NewFolder,z2mat);
parametername = ['parameter.mat'];
parametername = fullfile(NewFolder,parametername);
% lifespanmat = ['lifespan.mat'];
% lifespanmat = fullfile(NewFolder,lifespanmat);
save(z1mat,'z1');
save(z2mat,'z2');
parameter = [N,numexp,rtop,rbot,espsilon,lifespan,sigma];
save(parametername,'parameter');
% save(lifespanmat,'lifespan');

TxtName = ['Zmodel.txt'];
TxtName = fullfile(NewFolder,TxtName);

parameterlist = {
['N = ' num2str(N)],
['number of experiments = ' num2str(numexp)],
['rho of top fluid = ' num2str(rtop)],
['rho of bot fluid = ' num2str(rbot)],
['viscosity = ' num2str(espsilon)],
['lifespan = ' num2str(lifespan)],
['normalization condition number = ' num2str(sigma)],
};
fid = fopen(TxtName,'w');
fmtString = [repmat('%s\t',1,size(parameterlist,2)-1),'%s\n'];
fprintf(fid,fmtString,parameterlist{:});
fclose(fid);

end
