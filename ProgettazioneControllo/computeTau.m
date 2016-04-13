function [ tauMecc, tauAmp ] = computeTau()
%COMPUTETAU Summary of this function goes here
%   Detailed explanation goes here
MotorParametersBushelessLafert;
costanti;
load('Fv.mat');
load('Bconst.mat');
s = 0:10:50;
%tauAmp = L/R
%tauMecc = I/Fm = (bi/kri^2)/(fv/kri^2) = bi/fv
tauAmp = zeros(1,6);
tauMecc = zeros(1,6);
for i=1:6
    tauAmp(i)=La(i)/Ra(i);
    tauMecc(i) = Bconst(i,i)/Fv(i,i); %Non ci interessa l'accoppiamento, stimo solo facendo un confroto fra le tau

end
figure(1), stem(s,tauAmp); hold on; stem(s,tauMecc); legend('tauAmp','tauMecc');

end

