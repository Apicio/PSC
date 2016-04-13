close all; clear all;
%% Inizializzazione Parametri
load('Tm.mat'); costanti; MotorParametersBushelessLafert;
KT = diag(Kt); KV = diag(kv); RA = diag(Ra); 
KM = KV^-1; Kpc = diag(ones(6,1)); Kvc = diag(ones(6,1));
Tv = diag(ones(6,1)); Ktv = diag(ones(6,1)); Ktp = diag(ones(6,1));
s = tf('s');
%% Giunto 1 
Cp1 = Kpc(1,1);
Cv1 = (Kvc(1,1)*(s*Tv(1,1)+1))/s;
H1 = Ktp(1,1);
H2 = Ktv(1,1);
G1 = KM(1,1)/(s*(s*Tm(1,1)+1));
G2 = 1/s;