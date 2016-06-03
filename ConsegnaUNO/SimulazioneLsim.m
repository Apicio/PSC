close all; clearvars;
%% Inizializzazione Parametri
cd utilis
ParametriMotori
load('KCP.mat') % Controllo
load('KM.mat') % Processo
load('KCV.mat') % Controllo
load('KTA.mat') % Controllo
load('KTP.mat') % Controllo
load('KTV.mat') % Controllo
load('TCA.mat') % Controllo
load('TCV.mat') % Controllo
load('TM.mat') % Processo
load('W.mat') % Controllo
load('XR.mat') % Controllo
load('Z.mat') % Controllo
load('KCA.mat') % Controllo
load('KM.mat') % Processo
load('traj.mat') % Traiettorie
load('Bconst.mat') % Processo
load('Fv.mat') % Processo
load('u_out.mat')
Tf = 1/500; Ff = 1/Tf; T = Tf;
s = tf('s');
%% Modifica traiettoria per farla partire da zero
len = 10000;
t1 = linspace(0,Traj(1,1),len);
t2 = linspace(0,Traj(1,2),len);
t3 = linspace(0,Traj(1,3),len);
t4 = linspace(0,Traj(1,4),len);
t5 = linspace(0,Traj(1,5),len);
t6 = linspace(0,Traj(1,6),len);
t7 = linspace(0,Traj(1,7),len);
tt = [t1', t2', t3', t4', t5', t6', t7'];
Traj = [tt; Traj];
%% Processo Reale
I = Kr^-1*Bconst*Kr^-1;
FM = Kr^-1*Fv*Kr^-1;
% P_Mecc_Num = inv(I).*s^-1;
% P_Mecc = P_Mecc_Num/(eye(6,6)+FM*P_Mecc_Num);
% P_Ele_Num = (s*La+Ra)^-1*Kt*P_Mecc;
% P_Ele_Mecc = P_Ele_Num/(eye(6,6) + Kv*P_Ele_Num);
% P_Real = P_Ele_Mecc.*s^-1;
P_Mecc_Num = I^-1.*(s^-1);
P_Mecc = P_Mecc_Num*((eye(6,6)+P_Mecc_Num*FM)^-1);
P_Ele_Num = (s.*La+Ra)^-1*Kt*P_Mecc;
P_Ele_Mecc = P_Ele_Num*((eye(6,6) + P_Ele_Num*Kv)^-1);
P_Real = P_Ele_Mecc.*(s^-1);
P_Acc = P_Ele_Mecc/(eye(6,6) + P_Ele_Mecc*KTA*KCA*(eye(6,6)+s*TCA));
P_Acc = P_Acc.*s^-1;
%% Verifica di Robustezza
x100 = 0.20;
ParametriMotori
r = randi([-1 1],1,6);
r = diag(r);
Bconst = Bconst + Bconst.*x100.*r;
I = Kr^-1*Bconst*Kr^-1;
TM = I*Ra*Kt^-1*Kv^-1;          %Cosante di tempo sistema
KM = Kv^-1;                     %Guadagno sistema

Fv_att = Fv + Fv.*x100.*r;
FM = Kr^-1*Fv_att*Kr^-1;
%% Simulazione Retroazione posizione + velocità
Cv = (KCP*KCV/s)*(s*TCV+eye(6,6));
Hv = KTP*(eye(6,6) + (s*KTV)/(KCP*KTP));
Pv = KM/(s*(eye(6,6)+s*TM));
Fv = Cv*P_Real*Hv;
Wv = minreal((Hv^-1)/(eye(6,6)+Fv^-1));
W = Wv;
num_el = size(Traj,1);
t = 0:Tf:(num_el*Tf-Tf);
for i=1:6
    sim = lsim(W(i,i),Traj(:,i),t);
    err = sim-Traj(:,i);
    figure, subplot(211), plot(sim,'k','LineWidth',3); hold on; plot(Traj(:,i),'--r','LineWidth',2);
    title(strcat('Retroazione Posizione e Velocità Giunto ',num2str(i)));
    legend('Uscita','Ingresso');
        subplot(212), plot(err), legend('Errore');
end
%% Simulazione con retroazione posizione + velcità + accel
Ga = KM/((eye(6,6)+KM*KCA*KTA)*(eye(6,6)+s*TM*((eye(6,6)+KM*KCA*KTA*(TCA/TM))/(eye(6,6)+KM*KCA*KTA))));
Pa = Ga/s;
Ca = KCP*KCV*KCA*((eye(6,6)+s*TCA)/(s));
Ha = KTP*(eye(6,6) + (s*KTV)/(KCP*KTP));
Fa = Ca*P_Acc*Ha;
Wa = minreal((Ha^-1)/(eye(6,6)+Fa^-1));
W = Wa;
for i=1:6
    sim = lsim(W(i,i),Traj(:,i),t);
    err = sim-Traj(:,i);
    figure,subplot(211), plot(sim,'k','LineWidth',3); hold on; plot(Traj(:,i),'--r','LineWidth',2);
    title(strcat('Retroazione Posizione, Velocità e Accelerazione Giunto ',num2str(i)));
    legend('Uscita','Ingresso');
     subplot(212), plot(err), legend('Errore');
end
%% Simulazione con feedforward, retroazione pos+vel+acc
load('Prefilter.mat')
Wa = Wa*ones(6,1);
Wff = Prefilter.*Wa;
for i=1:6
    sim = lsim(Wff(i),Traj(:,i),t);
    err = sim-Traj(:,i);
    figure,subplot(211), plot(sim,'k','LineWidth',3); hold on; plot(Traj(:,i),'--r', 'LineWidth',2);
    title(strcat('FeedForward Posizione, Velocità e Accelerazione Giunto ',num2str(i)));
    legend('Uscita','Ingresso');
    subplot(212), plot(err), legend('Errore'); 
end
