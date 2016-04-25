close all; clear all;
%% Inizializzazione Parametri
load('Tm.mat'); costanti; MotorParametersBushelessLafert;
KT = diag(Kt); 
KV = diag(kv);
RA = diag(Ra); 
KM = KV^-1;

KCP = diag([1 1 1 1 1 1]); 
KCV = diag([1 1 1 1 1 1]);
KCA = diag([1 1 1 1 1 1]);

TCA = diag([1 1 1 1 1 1]); 
KTV = diag([1 1 1 1 1 1]);
KTP = diag([1 1 1 1 1 1]);
KTA = diag([1 1 1 1 1 1]);

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