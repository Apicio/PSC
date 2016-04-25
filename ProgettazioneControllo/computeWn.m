%clc; clear all; close all;
pos_inf = [-2.9671   -3.0543    -1.5708    -3.6652    -2.2689    -43.9823]; %m m radx6
pos_sup = [2.9671    1.1345     1.3963     3.6652     2.2689     50.2655]; %m m radx6
dqmaxcomau = [2.433 2.7925 2.9671 7.8534 6.5443 9.5986]; %velocita' massime ai giunti m/s m/s rad/sx6
ddqmaxcomau = [20 20 20 35 45 45]; %accelerazioni massime ai giunti m/s^2 m/s^2 rad/s^2x6dTraj
%% Calcolo Wn
%Utilizziamo la costante temporale del motore per poter calcolare Wn
% Tm = (Bconst_i*Ra)/(Kt*Kv)
load('BconstOurLast.mat');
MotorParametersBushelessLafert
costanti;
Ra(2) = 58.95;
kt = [0.7; 1.04; 0.7; 0.51; 0.51; 0.51];
KT = diag(kt); KV = diag(kv); RA = diag(Ra); 
Tm = zeros(6,1); Wn = zeros(1,6); Tg = zeros(1,6);
Kr = diag(kr);
I = Kr^-1*Bconst*Kr^-1;
Tm = I*diag(Ra)*KT^-1*KV^-1;
%Tg = Tm*abs(Kr^-1); %% Da Motori a Giunti, non si è ancora capito se è giusto.
Wn = Tm^-1;