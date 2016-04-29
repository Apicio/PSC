clear all; clc; close all;
%COMPUTETAU Summary of this function goes here
%   Detailed explanation goes here
ParametriMotori
load('Fv.mat');
load('BconstOurLast.mat');
s = 0:10:50;
%tauAmp = L/R
%tauMecc = I/Fm = (bi/kri^2)/(fv/kri^2) = bi/fv
tauAmp = zeros(1,6);
tauMecc = zeros(1,6);
Fm = Kr^-1*Fv*Kr^-1;

for i=1:6
    tauAmp(i)=la(i)/ra(i);
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
    fun = (kt(i)/(ra(i)*Fm(i,i)))*((1/(tauAmp(i)*s +1))*(1/(tauMecc(i)*s+1)));
    margin(fun);
    [~,~,~,Wpm] = margin(fun) 
    hold on
    fun = (kt(i)/(ra(i)*Fm(i,i)))*(1/(tauMecc(i)*s+1));
    margin(fun);
    title(strcat('Giunto-',num2str(i)));
end

