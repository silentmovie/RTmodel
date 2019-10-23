function [out] = build_wall(dim,index1,index2,rbot)
% author: Bohan Zhou
% email: bhzhouzhou@math.ucdavis.edu
% Created Date: 2017/01/22
% Modified Date: 2017/01/24
% Copy Right:
% Reference: R.Granero-Belinchon, S. Shkoller A model of Rayleigh-Taylor
% Mixing
%% Input & Output
% index1: row index
% index2: column index
%% Examples:

%% This is Main Function

A = zeros(dim);
outindex1 = index1(1);
outindex2 = index2(1);
for j = 1:length(index1)-1
     N = max(abs(index1(j+1)-index1(j)),abs(index2(j+1)-index2(j)));
     increment1 = zeros(1,N);
     increment2 = zeros(1,N);
     increment1(1:N) = index1(j) + (1:N)*(index1(j+1)-index1(j))/N;
     increment2(1:N) = index2(j) + (1:N)*(index2(j+1)-index2(j))/N;
     outindex1 = [outindex1,increment1];
     outindex2 = [outindex2,increment2];
end
outindex1 = round(outindex1);
outindex2 = round(outindex2);
A(sub2ind(dim,outindex1,outindex2)) = rbot;
if outindex2(end) < dim(1)
    A(outindex1(end),outindex2(end):dim(1)) = rbot;
end
if outindex2(1) > 1
    A(outindex1(1),1:outindex2(1)) = rbot;
end
out = A;
end

