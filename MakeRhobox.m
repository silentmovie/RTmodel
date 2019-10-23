function out = MakeRhobox(z1,z2,numexp,N,yrange,ymin,rtop,rbot)
%% Align Density for RT Mixing z-Model
% author: Bohan Zhou
% email: bhzhouzhou@math.ucdavis.edu
% Created Date: 2017/02/22
% Modified Date: 2017/03/07
% Copy Right:
% Reference: R.Granero-Belinchon, S. Shkoller A model of Rayleigh-Taylor
% Mixing
%% Input & Output

%% Examples:

%%

out = zeros(N,N);
for i = 1 : numexp
    newrhobox = zeros(N,N);
    index1 = (N-1)/yrange*(z2(:,i)-ymin)+1;     % row index; ymin-->1 ymax-->N
    index1 = round(index1);
    index2 = (N-1)/pi*(z1(:,i)+pi/2)+1;         % column index;
    index2 = round(index2);
    ind = find(index2<=N);
    IND = find(index2>=1);
    ind = intersect(ind,IND);
    index1 = index1(ind);
    index2 = index2(ind);
    TOP = min(N,max(index1)+2);    % 2 is manual margin
    BOT = max(1,min(index1)-2);
    %newrhobox = build_wall(size(newrhobox),index1,index2,rbot);
    newrhobox = logical(build_wall(size(newrhobox),index1,index2,1));
    newrhobox(BOT:TOP,:) = imfill(newrhobox(BOT:TOP,:),[1,TOP-BOT+1]);
    newrhobox(1:BOT-1,:) = 1;
    newrhobox = double(newrhobox);
    newrhobox(newrhobox==0) = rtop;
    newrhobox(newrhobox==1) = rbot;
    out = out + newrhobox;
end

out = out/numexp;

end