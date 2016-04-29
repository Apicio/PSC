close all; clear all;
%% Inizializzazione Parametri
load('BconstOurLast.mat');
ParametriMotori
I = Kr^-1*Bconst*Kr^-1;
Tm = I*Ra*Kt^-1*Kv^-1;          %Cosante di tempo sistema
KM = Kv^-1;                     %Guadagno sistema

KCP = diag([3000 1 1 1 1 1]); % Guadagno controllore in posizione
KCV = diag([2027 1 1 1 1 1]); % Guadagno controllore in velocità
KCA = diag([1 1 1 1 1 1]); % Guadagno controllore in accelerazione
KTV = diag([900 1 1 1 1 1]); % Guadagno trasduttore in velocità
KTP = diag([3000 1 1 1 1 1]); % Guadagno trsduttore in posizione
KTA = diag([1 1 1 1 1 1]); % Guadagno trasduttore in accelerazione
TCA = diag([Tm(1,1) 1 1 1 1 1]); % Costante di tempo controllore accelerazione
s = tf('s');
%% Giunto 1 
giunto = 1;
F0 = (1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto)*(TCA(giunto,giunto)/Tm(giunto,giunto)))/(1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto));
F1 = KCP(giunto,giunto)*KCA(giunto,giunto)*KCV(giunto,giunto);
F2 = (1+s*TCA(giunto,giunto))/(s);
F3 = KM(giunto,giunto)/((1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto))*(1+s*Tm(giunto,giunto)*F0));
F4 = KTP(giunto,giunto)/s;
F5 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
F = F1*F2*F3*F4*F5;
zpk(F)
rltool(F)
%% Giunto 2 
giunto = 2;
F0 = (1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto)*(TCA(giunto,giunto)/Tm(giunto,giunto)))/(1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto));
F1 = KCP(giunto,giunto)*KCA(giunto,giunto)*KCV(giunto,giunto);
F2 = (1+s*TCA(giunto,giunto))/(s);
F3 = KM(giunto,giunto)/((1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto))*(1+s*Tm(giunto,giunto)*F0));
F4 = KTP(giunto,giunto)/s;
F5 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
F = F1*F2*F3*F4*F5;
rltool(F)
%% Giunto 3 
giunto = 3;
F0 = (1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto)*(TCA(giunto,giunto)/Tm(giunto,giunto)))/(1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto));
F1 = KCP(giunto,giunto)*KCA(giunto,giunto)*KCV(giunto,giunto);
F2 = (1+s*TCA(giunto,giunto))/(s);
F3 = KM(giunto,giunto)/((1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto))*(1+s*Tm(giunto,giunto)*F0));
F4 = KTP(giunto,giunto)/s;
F5 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
F = F1*F2*F3*F4*F5;
rltool(F)
%% Giunto 4 
giunto = 4;
F0 = (1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto)*(TCA(giunto,giunto)/Tm(giunto,giunto)))/(1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto));
F1 = KCP(giunto,giunto)*KCA(giunto,giunto)*KCV(giunto,giunto);
F2 = (1+s*TCA(giunto,giunto))/(s);
F3 = KM(giunto,giunto)/((1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto))*(1+s*Tm(giunto,giunto)*F0));
F4 = KTP(giunto,giunto)/s;
F5 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
F = F1*F2*F3*F4*F5;
rltool(F)
%% Giunto 5 
giunto = 5;
F0 = (1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto)*(TCA(giunto,giunto)/Tm(giunto,giunto)))/(1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto));
F1 = KCP(giunto,giunto)*KCA(giunto,giunto)*KCV(giunto,giunto);
F2 = (1+s*TCA(giunto,giunto))/(s);
F3 = KM(giunto,giunto)/((1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto))*(1+s*Tm(giunto,giunto)*F0));
F4 = KTP(giunto,giunto)/s;
F5 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
F = F1*F2*F3*F4*F5;
rltool(F)
%% Giunto 6 
giunto = 6;
F0 = (1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto)*(TCA(giunto,giunto)/Tm(giunto,giunto)))/(1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto));
F1 = KCP(giunto,giunto)*KCA(giunto,giunto)*KCV(giunto,giunto);
F2 = (1+s*TCA(giunto,giunto))/(s);
F3 = KM(giunto,giunto)/((1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto))*(1+s*Tm(giunto,giunto)*F0));
F4 = KTP(giunto,giunto)/s;
F5 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
F = F1*F2*F3*F4*F5;
rltool(F)