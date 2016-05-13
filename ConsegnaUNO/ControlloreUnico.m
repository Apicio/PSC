close all; clearvars;
%% Inizializzazione dei Parametri
cd utilis 
ParametriMotori
Tf = 1/500; Ff = 1/Tf; T = Tf;
s = tf('s');
load('KM.mat') % Processo
load('TM.mat') % Processo
load('KM.mat') % Processo
load('Fv.mat') % Processo
load('Bconst.mat') % Processo
load('traj.mat') % Traiettorie
load('KTA.mat') % Controllo
load('KTP.mat') % Controllo
load('KTV.mat') % Controllo
load('Prefilter.mat') % Controllo
cd ..
%% Processo Reale
I = Kr^-1*Bconst*Kr^-1;
FM = Kr^-1*Fv*Kr^-1;
P_Mecc_Num = inv(I).*s^-1;
P_Mecc = P_Mecc_Num/(eye(6,6)+FM*P_Mecc_Num);
P_Ele_Num = (s*La+Ra)^-1*Kt*P_Mecc;
P_Ele_Mecc = P_Ele_Num/(eye(6,6) + Kv*P_Ele_Num);
P_Real = P_Ele_Mecc.*s^-1;
H = KTP;
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
num_el = size(Traj,1);
t = 0:Tf:(num_el*Tf-Tf);
%% Unificazione Controllore Velocità
cd utilis 
load('KCPv.mat') % Controllo
load('KCVv.mat') % Controllo
load('KTPv.mat') % Controllo
load('KTVv.mat') % Controllo
load('TCVv.mat') % Controllo
cd ..
Cv1 = KCP*KCV*TCV+KCV*KTV*KTP^-1;
Cv2 = KCP*KCV*s^-1;
Cv3 = KCV*TCV*KTV*KTP^-1*s^-1;
Cv = Cv1 + Cv2 + Cv3;
Fv = Cv*P_Real*H;
Wv = Cv*P_Real/(eye(6,6)+Fv);
W = Wv;
for i=1:6
    sim = lsim(W(i,i),Traj(:,i),t);
    err = sim-Traj(:,i);
    figure, subplot(211), plot(sim,'k','LineWidth',3); hold on; plot(Traj(:,i),'--r','LineWidth',2);
    title(strcat('Retroazione Posizione e Velocità Giunto ',num2str(i)));
    legend('Uscita','Ingresso');
        subplot(212), plot(err), legend('Errore');
end
%% Unificazione Controllore Accelerazione
cd utilis 
load('KCP.mat') % Controllo
load('KCV.mat') % Controllo
load('KTA.mat') % Controllo
load('KTP.mat') % Controllo
load('KTV.mat') % Controllo
load('TCA.mat') % Controllo
load('TCV.mat') % Controllo
load('KCA.mat') % Controllo
cd ..
Ca1 = KCP*KCV*KCA*TCA+KCV*KTV*KCA*KTP^-1;
Ca2 = KCP*KCV*KCA*s^-1;
Ca3 = (KCV*KTV*KCA*TCA+KCA*KTA)*KTP^-1*s^-1;
Ca4 = KCA*TCA*KTA*KTP^-1*s^-2;
Ca = Ca1 + Ca2 + Ca3 + Ca4; 
Fa = Ca*P_Real*H;
Wa = Ca*P_Real/(eye(6,6)+Fa);
W = Wa;
for i=1:6
    sim = lsim(W(i,i),Traj(:,i),t);
    err = sim-Traj(:,i);
    figure,subplot(211), plot(sim,'k','LineWidth',3); hold on; plot(Traj(:,i),'--r','LineWidth',2);
    title(strcat('Retroazione Posizione, Velocità e Accelerazione Giunto ',num2str(i)));
    legend('Uscita','Ingresso');
     subplot(212), plot(err), legend('Errore');
end
%% FeedForward
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