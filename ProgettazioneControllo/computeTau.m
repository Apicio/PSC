function [ tauMecc, tauAmp ] = computeTau()
%COMPUTETAU Summary of this function goes here
%   Detailed explanation goes here
MotorParametersBushelessLafert;
costanti;
load('Fv.mat');
load('Bconst2.mat');
s = 0:10:50;
%tauAmp = L/R
%tauMecc = I/Fm = (bi/kri^2)/(fv/kri^2) = bi/fv
tauAmp = zeros(1,6);
tauMecc = zeros(1,6);
for i=1:6
    tauAmp(i)=La(i)/Ra(i);
    tauMecc(i) = Bconst(i,i)/Fv(i,i); %Non ci interessa l'accoppiamento, stimo solo facendo un confroto fra le tau

end
figure
stem(tauAmp,'r')
hold on
stem(tauMecc,'b')
legend('tauAmp','tauMecc');
s = tf('s');

for i=1:6
    figure
    fun = (1/(tauAmp(i)*s +1))*(1/(tauMecc(i)*s+1));
    bode (fun);
    hold on
    fun = (1/(tauMecc(i)*s+1));
    bode (fun);
    title(strcat('Giunto-',num2str(i)));
end
end

