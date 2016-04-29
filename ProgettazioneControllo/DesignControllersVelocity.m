close all; clearvars;
%% Inizializzazione Parametri
load('BconstOurLast.mat');
ParametriMotori
I = Kr^-1*Bconst*Kr^-1;
Tm = I*Ra*Kt^-1*Kv^-1;          %Cosante di tempo sistema
KM = Kv^-1;                     %Guadagno sistema
% syms z w ktv kp ktp km kv ktp
% eq1 = 2*z/w - ktv/(kp*ktp)
% eq2 = w^2 - kp*km*ktp*kv
% S = solve(eq1,eq2,'kp,kv')
% S.kp = (ktv*w)/(2*ktp*z)
% S.kv = (2*w*z)/(km*ktv)

Z = diag([1 1 1 1 1 1]);
W = diag([100 1 1 1 1 1]);
KTV = diag([100 1 1 1 1 1]);                          %Guadagno trasduttore velocità
KTP = diag([100 1 1 1 1 1]);                          %Guadagno trasduttore posizione
KCP = diag([(KTV(1,1)*W(1,1))/(2*KTP(1,1)*Z(1,1)),... %Guadagno controllore in posizione
            (KTV(2,2)*W(2,2))/(2*KTP(2,2)*Z(2,2)),...
            (KTV(3,3)*W(3,3))/(2*KTP(3,3)*Z(3,3)),...
            (KTV(4,4)*W(4,4))/(2*KTP(4,4)*Z(4,4)),...
            (KTV(5,5)*W(5,5))/(2*KTP(5,5)*Z(5,5)),...
            (KTV(6,6)*W(6,6))/(2*KTP(6,6)*Z(6,6))]);    
KCV = diag([(2*W(1,1)*Z(1,1))/(KM(1,1)*KTV(1,1)),...
            (2*W(2,2)*Z(2,2))/(KM(2,2)*KTV(2,2)),...
            (2*W(3,3)*Z(3,3))/(KM(3,3)*KTV(3,3)),...
            (2*W(4,4)*Z(4,4))/(KM(4,4)*KTV(4,4)),...
            (2*W(5,5)*Z(5,5))/(KM(5,5)*KTV(5,5)),...
            (2*W(6,6)*Z(6,6))/(KM(6,6)*KTV(6,6))]);   %Guadagno controllore in velocità
TCV = diag([Tm(1,1) Tm(2,2) Tm(3,3) Tm(4,4) Tm(5,5) Tm(6,6)]);  %Costante di tempo controllore
XR = KCP*KTP*KCV;
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