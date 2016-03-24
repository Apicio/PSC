%% CONNESSIONE V-REP
disable = true;
if(~disable && (exist('client') || client ~=0))
    clear all; clc; close all;
    warning off
    % StopVrepSimulation(); %pre precauzione
    %%%%%%%%%%%%%%%%%%%%%%%%%%   Set Path  %%%%%%%%%%%%%%%%%%%%%%%%%%
    %restoredefaultpath
    addpath(genpath('C:\Program Files (x86)\V-REP3\V-REP_PRO_EDU\programming'))
    % OGNUNO DI VOI DOVRA' METTERE IL PATH ALLA CARTELLA PROGRAMMING NELLA
    % DIRECTORY DI INSTALLAZIONE DI VREP
    %addpath(genpath('C:\Program Files (x86)\V-REP3\V-REP_PRO_EDU\programming'));
    addpath(genpath('./')); %aggiungo il path corrente al path di matlab in modo che le funzioni nelle sottodirectory possano viste dal Matlab
    savepath;
    %%%%%%%%%              Inizializzazione  %%%%%%%%%%%%%%%%%%%%%%%%%
    InitConnectionWithSimulator();%initialize the communication with the Simulator
    %MotorParametersBushelessLafert(); %load in workspace the parameters of the motors
end
if(disable)
    clear all; clc; close all;
end
%% Carico WorkSpace
load('traj.mat');
load('IdMatrix.mat');
load('min_value.mat');
distance_from_wall = 0.50;
delay = 300; interval = 1.255; 
F=1000;
costanti;
%% 
cutoff = 42000;
t = IdMatrix(cutoff:end,1);        % Vettore dei tempi
qInv = IdMatrix(cutoff:end,2:8);   % Matrice Q, variabili di giunto INVIATE al controllore
qSim = IdMatrix(cutoff:end,23:29); % Matrice Q, variabili di giunto LETTE dal controllore
ISim = IdMatrix(cutoff:end,37:43); % Matrice delle Correnti lette dai sensori
%% Denoising dei segnali misurati
ISimg = zeros(size(ISim));
for k=1:size(ISim,2)
      [up, down] = envelope(ISim(:,k),16,'peak');
      ISim(:,k) = (up+down)/2;
      %ISim(:,k) = sgolayfilt(ISim(:,k),1,17);
%     dec = mdwtdec('c',ISim(:,k),2,'db1');
%     [XD,~,~] = mswden('den',dec,'sqtwolog','sln');
%     ISim(:,k) = XD;
%     
%     dec = mdwtdec('c',qSim(:,k),2,'db1');
%     [XD,~,~] = mswden('den',dec,'sqtwolog','sln');
%     qSim(:,k) = XD;
end

%% Troviamo i punti della traiettoria
cycle = size(qInv,1) - size(Traj,1);
no = zeros(1,cycle);
Et = sum(Traj.^2);
for i=1:cycle
    Ea = sum(qInv(i:size(Traj,1)+i-1,:).^2);
    no(i) = mean(abs(Ea-Et));
end
i = find(no == min(no));                        %cutoff index
no = zeros(1,delay);
Et = sum(qInv(i:size(Traj,1)+i-1,1:6).^2);
for j=i:delay+i
    Ea = sum(qSim(j:size(Traj,1)+j-1,1:6).^2);
    no(j-i+1) = mean(abs(Ea-Et));
end
j = find(no == min(no));                        %delay index
%% Undirted Data
t = t(i:size(Traj,1)+i-1);                   % Vettore dei tempi
qInv = qInv(i:size(Traj,1)+i-1,1:6);           % Matrice Q, variabili di giunto INVIATE al controllore
qSim = qSim((i+j):size(Traj,1)+(i+j)-1,1:6);   % Matrice Q, variabili di giunto LETTE dal controllore
ISim = ISim((i+j):size(Traj,1)+(i+j)-1,1:6);   % Matrice delle Correnti lette dai sensori
figure; plot(qInv); title('qInv');
figure; plot(Traj); title('Traj');
figure; plot(qSim); title('qSim');
figure; plot(ISim); title('ISim');
%% Compute derivate
Fs = 500; %500 perché è stato considerato un intervallo tra i campioni ogni 0.2 invece di ogni 0.1 così com'era in fase
          % di definizione della traiettoria.
dqSim = diff(qSim)*Fs;
ddqSim = diff(dqSim)*Fs;
%% Generazione TRAINING SET
r = 1:interval*F:size(qSim,1); N_ts = size(r,2)-2; %togliamo il punto iniziale e finale poiché fittizi.
qSim_ts = qSim(r(2:end-1),:);
dqSim_ts = dqSim(r(2:end-1),:);
ddqSim_ts = ddqSim(r(2:end-1),:);
I_ts = ISim(r(2:end-1),:); 
%% Generazione VALIDATION SET
vs_dim = 100;
r = randi([r(2),r(end-1)],vs_dim,1); N_vs = size(r,1);
qSim_vs = qSim(r,:);
dqSim_vs = dqSim(r,:);
ddqSim_vs = ddqSim(r,:);
I_vs = ISim(r,:);
%% Calcolo Parametri Dinamici
W_ts = computeW(qSim_ts', dqSim_ts', ddqSim_ts', N_ts);
Kt = diag(kt);
H=[ -1     0     0     0     0     0
     0     1     0     0     0     0
     0     0    -1     0     0     0
     0     0     0    -1     0     0
     0     0     0     0     1     0
     0     0     0     0     0    -1];
 A = ((H')^-1 * Kr' * Kt);
 tauDH_ts = [] ;
 for i=1:size(I_ts,1)
     toAdd = A*I_ts(i,:)';
     tauDH_ts = [tauDH_ts; toAdd];
 end
% I_ts = I_ts';
% tauDH_ts = repmat(A,1,64)*I_ts(:)';
PI_ts = pinv(W_ts)*tauDH_ts;
tau = W_ts*PI_ts;
errrrrr = mean(abs(tau-tauDH_ts))
%% Validazione Algoritmo di calcolo dei Parametri Dinamici
W_vs = computeW(qSim_vs', dqSim_vs', ddqSim_vs', N_vs);
tauDH_vs = [] ;
for i=1:size(I_vs,1)
     toAdd = A*I_vs(i,:)';
     tauDH_vs = [tauDH_vs; toAdd];
end

tauDH_cap = W_vs*PI_ts;
err =abs(tauDH_cap-tauDH_vs);