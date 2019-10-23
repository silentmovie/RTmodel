function out = HdotNorm(rhobox,s,xrange,yrange)
%% Compute H^s norm for a strip domain
% author: Bohan Zhou
% email: bhzhouzhou@math.ucdavis.edu
% Created Date: 2017/03/04
% Modified Date: 2017/03/05
% Copy Right:
% Reference: R.Granero-Belinchon, S. Shkoller A model of Rayleigh-Taylor
% Mixing
%% Input and Output
% Rhobox [,) type matrix 
%
[index2, index1] = size(rhobox);
d1 = xrange/(index1);
d2 = yrange/(index2);
if mod(index2,2)==0
    k1 = [0:index2/2-1, 0, -index2/2+1:-1].';
else
    k1 = [0:(index2-1)/2, -(index2-1)/2:-1].';
end
k1 = 1i*k1;
k1 = k1.^s;
k1(isinf(k1)) = 0;

for i = 1 : index1
    Frhobox(:,i) = k1.*fft(rhobox(:,i))*d2;
end
if mod(index1,2)==0
    k2 = [0:index1/2-1, 0, -index1/2+1:-1].';
else
    k2 = [0:(index1-1)/2, -(index1-1)/2:-1].';
end
k2 = 1i*k2;
k2 = k2.^s;
k2(isinf(k2)) = 0;

for i = 1 : index2
    NewFrhobox(:,i) = k2.*fft(Frhobox(i,:).')*d1;
end
df1 = 1/(d1*index1);
df2 = 1/(d2*index2);
%out = trapz(trapz(Frhobox.*conj(Frhobox))*df1)*df2;
out = trapz(trapz(fftshift(abs(NewFrhobox.')).^2))*df1*df2;
out = sqrt(out);

end
