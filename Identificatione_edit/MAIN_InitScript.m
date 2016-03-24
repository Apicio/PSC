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
delay = 300;
%% 
cutoff = 42000;
t = IdMatrix(cutoff:end,1);        % Vettore dei tempi
qInv = IdMatrix(cutoff:end,2:8);   % Matrice Q, variabili di giunto INVIATE al controllore
qSim = IdMatrix(cutoff:end,23:29); % Matrice Q, variabili di giunto LETTE dal controllore
ISim = IdMatrix(cutoff:end,37:43); % Matrice delle Correnti lette dai sensori
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
qInv = qInv(i:size(Traj,1)+i-1,:);           % Matrice Q, variabili di giunto INVIATE al controllore
qSim = qSim((i+j):size(Traj,1)+(i+j)-1,:);   % Matrice Q, variabili di giunto LETTE dal controllore
ISim = ISim((i+j):size(Traj,1)+(i+j)-1,:);   % Matrice delle Correnti lette dai sensori
figure; plot(qInv); title('qInv');
figure; plot(Traj); title('Traj');
figure; plot(qSim); title('qSim');
figure; plot(ISim); title('ISim');










