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
cd ..
%% Processo Reale
I = Kr^-1*Bconst*Kr^-1;
FM = Kr^-1*Fv*Kr^-1;
P_Mecc_Num = I^-1.*(s^-1);
P_Mecc = P_Mecc_Num*((eye(6,6)+P_Mecc_Num*FM)^-1);
P_Ele_Num = (s.*La+Ra)^-1*Kt*P_Mecc;
P_Ele_Mecc = P_Ele_Num*((eye(6,6) + P_Ele_Num*Kv)^-1);
P_Real = P_Ele_Mecc.*(s^-1);
for i=1:6
    P_Real(i,i) = minreal(P_Real(i,i));
end
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
Traj = [zeros(len/2,7); tt; Traj];
t1 = linspace(Traj(end,1),0,len);
t2 = linspace(Traj(end,2),0,len);
t3 = linspace(Traj(end,3),0,len);
t4 = linspace(Traj(end,4),0,len);
t5 = linspace(Traj(end,5),0,len);
t6 = linspace(Traj(end,6),0,len);
t7 = linspace(Traj(end,7),0,len);
tt = [t1', t2', t3', t4', t5', t6', t7'];
Traj = [Traj; tt; zeros(len/2,7)];
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
Cv3 = KCV*TCV*KTV*KTP^-1.*s;
Cv = Cv1 + Cv2 + Cv3;
Cv = Cv*((1/314)*eye(6,6).*s + eye(6,6))^-1;

Fv_t = Cv*P_Real*H;
Wv = Cv*P_Real*(eye(6,6)+Fv_t)^-1;
for i=1:6
    Wv(i,i) = minreal(Wv(i,i));
end
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
Ca3 = (KCV*KTV*KCA*TCA+KCA*KTA)*KTP^-1*s;
Ca4 = KCA*TCA*KTA*KTP^-1*s^2;
Ca = Ca1 + Ca2 + Ca3 + Ca4; 
Ca = Ca*((1/314)*eye(6,6).*s + eye(6,6))^-2;
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
% scale = 10;
f1 = TM*KM^-1*s^2;
f2 = KM^-1*s;
Prefilter = (f1+f2)*Ca^-1 + KTP;
Prefilter = Prefilter*((1/314)*eye(6,6).*s + eye(6,6))^-2;
% pr_data = Pr*ones(6,1);
% zpk_data = zpkdata(pr_data);
% real_data = real(cell2mat(zpk_data));
% tau = -1./real_data(1:2:end);
% pole = (diag(tau/scale)*s + eye(6,6))*(diag(tau/scale)*s + eye(6,6));
% 
% Prefilter = Pr*pole^-1;
Prefilter = Prefilter*ones(6,1);

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