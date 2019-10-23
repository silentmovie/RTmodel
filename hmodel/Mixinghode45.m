function changeofy=Mixinghode45(T,yold,D,D2,L,H,D3,A,g,r,meanw,N,espsilon,s,tensor)
%% RT Mixing h-Model ode45
% author: Bohan Zhou
% email: bhzhouzhou@math.ucdavis.edu
% Created Date: 2016/11/28
% Modified Date: 2016/12/05
% Copy Right:
% Reference: R.Granero-Belinchon, S. Shkoller A model of Rayleigh-Taylor
% Mixing
%% Input & Output

%% Examples:

%% Advance in time
hold = yold(1:N);
wold = yold(N+1:end);
RHS1 = 0.5 * H.*wold;

T1 = 2*A*g* D.*hold;

T2 = 2*tensor/r* D3.*hold;

T3 = meanw* D.*(fft(real(ifft(wold))/4/pi.*real(ifft(D2.*hold))));

T4 = A/4/pi*meanw* D.*L.*wold;

T5 = A/2* L.*fft(real(ifft(wold)).*real(ifft(H.*wold)));

T6 = espsilon* L.^s.*wold;

RHS2 = T1+T2-T3+T4-T5-T6;

changeofy = [RHS1;RHS2];
