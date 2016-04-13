close all; clear all;
%% Inizializzazione Parametri
load('Tm.mat'); costanti; MotorParametersBushelessLafert;
KT = diag(Kt); 
KV = diag(kv); 
RA = diag(Ra); 
KM = KV^-1; 
KCP = diag([1 1 1 1 1 1]); 
KCV = diag([1 1 1 1 1 1]);
TCV = diag([100 1 1 1 1 1]); 
KTV = diag([1 1 1 1 1 1]);
KTP = diag([1 1 1 1 1 1]);
s = tf('s');
%% Giunto 1 
giunto = 1;
F1 = (KM(giunto,giunto)*KCP(giunto,giunto)*KCV(giunto,giunto)*(1+s*TCV(giunto,giunto)))/(s*s*(1+s*Tm(giunto,giunto)));
F2 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
F = F1*KTP(giunto,giunto)*F2;
rltool(F)
%% Giunto 2 
giunto = 2;
F1 = (KM(giunto,giunto)*KCP(giunto,giunto)*KCV(giunto,giunto)*(1+s*TCV(giunto,giunto)))/(s*s*(1+s*Tm(giunto,giunto)));
F2 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
F = F1*KTP(giunto,giunto)*F2;
rltool(F)
%% Giunto 3 
giunto = 3;
F1 = (KM(giunto,giunto)*KCP(giunto,giunto)*KCV(giunto,giunto)*(1+s*TCV(giunto,giunto)))/(s*s*(1+s*Tm(giunto,giunto)));
F2 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
F = F1*KTP(giunto,giunto)*F2;
rltool(F)
%% Giunto 4 
giunto = 4;
F1 = (KM(giunto,giunto)*KCP(giunto,giunto)*KCV(giunto,giunto)*(1+s*TCV(giunto,giunto)))/(s*s*(1+s*Tm(giunto,giunto)));
F2 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
F = F1*KTP(giunto,giunto)*F2;
rltool(F)
%% Giunto 5 
giunto = 5;
F1 = (KM(giunto,giunto)*KCP(giunto,giunto)*KCV(giunto,giunto)*(1+s*TCV(giunto,giunto)))/(s*s*(1+s*Tm(giunto,giunto)));
F2 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
F = F1*KTP(giunto,giunto)*F2;
rltool(F)
%% Giunto 6 
giunto = 6;
F1 = (KM(giunto,giunto)*KCP(giunto,giunto)*KCV(giunto,giunto)*(1+s*TCV(giunto,giunto)))/(s*s*(1+s*Tm(giunto,giunto)));
F2 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
F = F1*KTP(giunto,giunto)*F2;
rltool(F)