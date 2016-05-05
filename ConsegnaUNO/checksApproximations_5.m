clearvars; clc; close all;
%COMPUTETAU Summary of this function goes here
%   Detailed explanation goes here
cd utilis
ParametriMotori
load('Fv.mat');
load('Bconst.mat');
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

pos_inf = [-2.9671   -3.0543    -1.5708    -3.6652    -2.2689    -43.9823]; %m m radx6
pos_sup = [2.9671    1.1345     1.3963     3.6652     2.2689     50.2655]; %m m radx6
dqmaxcomau = [2.433 2.7925 2.9671 7.8534 6.5443 9.5986]; %velocita' massime ai giunti m/s m/s rad/sx6
ddqmaxcomau = [20 20 20 35 45 45]; %accelerazioni massime ai giunti m/s^2 m/s^2 rad/s^2x6dTraj
%% Calcolo Wn
%Utilizziamo la costante temporale del motore per poter calcolare Wn
Tm = zeros(6,1); Wn = zeros(1,6); Tg = zeros(1,6);
I = Kr^-1*Bconst*Kr^-1;
Tm = I*Ra*Kt^-1*Kv^-1;
%Tg = Tm*abs(Kr^-1); %% Da Motori a Giunti, non si è ancora capito se è giusto.
Wn = Tm^-1

%% Approssimazione retroazione
kv
k = Fm*Ra*Kt^-1;
[k(1,1) k(2,2) k(3,3) k(4,4) k(5,5) k(6,6)]