clear all; clc; close all;
load('traj.mat');
load('IdMatrix.mat');
load('min_value.mat');
distance_from_wall = 0.50;
delay = 300; interval = 1.2550; F=1000; costanti;
%% Load WorkSpace
cutoff = 42000;
t = IdMatrix(cutoff:end,1);        % Vettore dei tempi
qInv = IdMatrix(cutoff:end,2:8);   % Matrice Q, variabili di giunto INVIATE al controllore
qSim = IdMatrix(cutoff:end,23:29); % Matrice Q, variabili di giunto LETTE dal controllore
ISim = IdMatrix(cutoff:end,37:43); % Matrice delle Correnti lette dai sensori
%% Troviamo i punti nella Traj
T = 0:1/F:(size(min_value,2)-1)*interval;
size(T,2) - size(Traj,1)
I = 1:interval*F:size(Traj,1);
traj_min_value = Traj(I,1:6);
error1 = mean(mean(abs(traj_min_value-min_value(1:6,:)')));
figure
plot(T,Traj(:,1:6))
hold on
stem(T(I),Traj(I,1:6))
%% Troviamo i punti in qInv
cycle = size(qInv,1) - size(Traj,1);
no = zeros(1,cycle);
for i=1:cycle
    error2 = mse(qInv(I+i-1,1:6)-min_value(1:6,:)');
    no(i) = error2;
end
Differenza = min(no)
i = find(no == min(no));
%% Troviamo i punti in qSim
no = zeros(1,cycle);
for j=1:cycle
    error3 = mse(qSim(I+j-1,1:6)-qInv(I+i-1,1:6));
    no(j) = error3;
end
Differenza = min(no)
j = find(no == min(no)); 
%% Undirted Data
qInv = qInv(i:size(Traj,1)+i-1,1:6);           % Matrice Q, variabili di giunto INVIATE al controllore
qSim = qSim((i+j):size(Traj,1)+(i+j)-1,1:6);   % Matrice Q, variabili di giunto LETTE dal controllore
ISim = ISim((i+j):size(Traj,1)+(i+j)-1,1:6);   % Matrice delle Correnti lette dai sensori
%% Denoising dei segnali misurati
qSim = sgolayfilt(qSim,1,17);
ISim = sgolayfilt(ISim,1,17);
figure; plot(T,ISim);
%% Show Results
figure; plot(T,qInv); title('qInv');
figure; plot(T,Traj); title('Traj');
figure; plot(T,qSim); title('qSim');
figure; plot(T,ISim); title('ISim');
%% Compute derivate
Fs = 500; %500 perché è stato considerato un intervallo tra i campioni ogni 0.2 invece di ogni 0.1 così com'era in fase
          % di definizione della traiettoria.
dqSim = sgolayfilt(diff(qSim)*Fs,1,17);
Hd = getFilter();
ddqSim = sgolayfilt(diff(dqSim)*Fs,1,17);
%figure; plot(T,dqSim(20:end-20,:)); figure; plot(T,ddqSim(20:end-20,:));
%% Generazione TRAINING SET
load('ROW_TS.mat');
qSim_TS = qSim(ROW,:);
dqSim_TS = dqSim(ROW,:);
ddqSim_TS = ddqSim(ROW,:);
IISim_TS = ISim(ROW,:); 
N_TS = size(ROW,1);
%% Generazione VALIDATION SET
vs_dim = 2000;
r = randi([I(2),I(end-1)],vs_dim,1); N_vs = size(r,1);
qSim_vs = qSim(r,:);
dqSim_vs = dqSim(r,:);
ddqSim_vs = ddqSim(r,:);
I_vs = ISim(r,:);
%% Calcolo Parametri Dinamici
W_TS = computeW(qSim_TS', dqSim_TS', ddqSim_TS', N_TS);
Kt = diag(kt);
H = diag([-1 1 -1 -1 1 -1]);
A = ((H')^-1 * Kr' * Kt);
tauDH_TS = A*IISim_TS';
PI_TS = pinv(W_TS)*tauDH_TS(:);
TAU = W_TS*PI_TS;

err = mean(abs(TAU-tauDH_TS(:)))
errOnJointsTS = computeErr(TAU, tauDH_TS(:),6)

%% Validazione Algoritmo di calcolo dei Parametri Dinamici
W_vs = computeW(qSim_vs', dqSim_vs', ddqSim_vs', N_vs);
tauDH_vs = [] ;
for i=1:size(I_vs,1)
     toAdd = A*I_vs(i,:)';
     tauDH_vs = [tauDH_vs; toAdd];
end

tauDH_cap = W_vs*PI_TS;

err = mean(abs(tauDH_cap-tauDH_vs))
errOnJointsVS = computeErr(tauDH_cap, tauDH_vs,6)
%% Plot delle coppie misurate e ricostruite
figure; 
subplot(321); plot(tauDH_vs(1:6:180)); hold on; plot(tauDH_cap(1:6:180),'-.'); title('Joint1'); ylabel('Nm');
subplot(322); plot(tauDH_vs(2:6:180)); hold on; plot(tauDH_cap(2:6:180),'-.'); title('Joint2'); ylabel('Nm');
subplot(323); plot(tauDH_vs(3:6:180)); hold on; plot(tauDH_cap(3:6:180),'-.'); title('Joint3'); ylabel('Nm');
subplot(324); plot(tauDH_vs(4:6:180)); hold on; plot(tauDH_cap(4:6:180),'-.'); title('Joint4'); ylabel('Nm');
subplot(325); plot(tauDH_vs(5:6:180)); hold on; plot(tauDH_cap(5:6:180),'-.'); title('Joint5'); ylabel('Nm');
subplot(326); plot(tauDH_vs(6:6:180)); hold on; plot(tauDH_cap(6:6:180),'-.'); title('Joint6'); ylabel('Nm');


