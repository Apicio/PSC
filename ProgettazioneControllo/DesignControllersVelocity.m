close all; clear all;
%% Inizializzazione Parametri
load('BconstOurLast.mat');
ParametriMotori
I = Kr^-1*Bconst*Kr^-1;
Tm = I*Ra*Kt^-1*Kv^-1;          %Cosante di tempo sistema
KM = Kv^-1;                     %Guadagno sistema
KTV = diag([900 1 1 1 1 1]);      %Guadagno trasduttore velocità
KTP = diag([3000 1 1 1 1 1]);      %Guadagno trasduttore posizione
KCP = diag([3000 1 1 1 1 1]);    %Guadagno controllore in posizione
KCV = diag([1972 1 1 1 1 1]);    %Guadagno controllore in velocità
TCV = diag([Tm(1,1) 1 1 1 1 1]);  %Costante di tempo controllore
s = tf('s');
%% Giunto 1 
giunto = 1;
F1 = (KM(giunto,giunto)*KCP(giunto,giunto)*KCV(giunto,giunto)*(1+s*TCV(giunto,giunto)))/(s*s*(1+s*Tm(giunto,giunto)));
F2 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
F = F1*KTP(giunto,giunto)*F2;
zpk(F)
%rltool(F)
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