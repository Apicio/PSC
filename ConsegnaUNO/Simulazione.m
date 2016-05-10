close all; clearvars;
%% Inizializzazione Parametri
cd utilis
ParametriMotori
load('KCP.mat')
load('KCV.mat')
load('KTA.mat')
load('KTP.mat')
load('KTV.mat')
load('TCA.mat')
load('W.mat')
load('XR.mat')
load('Z.mat')
load('KCA.mat')
load('KM.mat')
load('traj.mat')
load('Bconst.mat')
load('Fv.mat')
load('u_out.mat')
Tf = 1/500; Ff = 1/Tf; T = Tf;
s = tf('s');

%% Simulazione Retroazione posizione + velocità
load('W_transVelocity.mat')
num_el = size(Traj,1);
t = 0:Tf:(num_el*Tf-Tf);
for i=1:6
    sim = lsim(W(i,i),Traj(:,i),t);
    err = sim-Traj(:,i);
    figure, subplot(211), plot(sim,'k','LineWidth',3); hold on; plot(Traj(:,i),'--r','LineWidth',2);
    legend('Uscita','Ingresso');
        subplot(212), plot(err), legend('Errore');

end

%% Simulazione con retroazione posizione + velcità + accel
load('W_transAccel.mat')
for i=1:6
    sim = lsim(W(i,i),Traj(:,i),t);
    err = sim-Traj(:,i);
    figure,subplot(211), plot(sim,'k','LineWidth',3); hold on; plot(Traj(:,i),'--r','LineWidth',2);
    legend('Uscita','Ingresso');
     subplot(212), plot(err), legend('Errore');

end

%% Simulazione con feedforward, retroazione pos+vel+acc
load('Prefilter.mat')
W = W*ones(6,1);
Wff = Prefilter.*W;
for i=1:6
    sim = lsim(Wff(i),Traj(:,i),t);
    err = sim-Traj(:,i);
    figure,subplot(211), plot(sim,'k','LineWidth',3); hold on; plot(Traj(:,i),'--r', 'LineWidth',2);
    legend('Uscita','Ingresso');
    subplot(212), plot(err), legend('Errore');
end
