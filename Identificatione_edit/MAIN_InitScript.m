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
%% Carico WorkSpace
load('traj.mat');
load('IdMatrix.mat');
load('min_value.mat');
distance_from_wall = 0.50;
%% 
cutoff = 42000;
t = IdMatrix(cutoff:end,1);        % Vettore dei tempi
qInv = IdMatrix(cutoff:end,2:8);   % Matrice Q, variabili di giunto INVIATE al controllore
qSim = IdMatrix(cutoff:end,23:29); % Matrice Q, variabili di giunto LETTE dal controllore
ISim = IdMatrix(cutoff:end,37:43); % Matrice delle Correnti lette dai sensori
%% Troviamo i punti della traiettoria
figure; plot(Traj);
cycle = size(qInv,1) - size(Traj,1);
no = [];
% Et = sum(Traj.^2);
% for i=1:cycle
%     Ea = sum(qInv(i:size(Traj,1)+i-1,:).^2);
%     no = [no, mean(abs(Ea-Et))];
% end
for i=1:cycle
    tmp = qInv(i:size(Traj,1)+i-1,:);
    diff = abs(tmp(:) - Traj(:));
    no = [no, mean(diff)];
end
i = find(no == min(no));
figure; plot(qInv(i:size(Traj,1)+i-1,:));
%% Undirted Data
t = IdMatrix(i:size(Traj,1)+i-1,1);        % Vettore dei tempi
qInv = IdMatrix(i:size(Traj,1)+i-1,2:8);   % Matrice Q, variabili di giunto INVIATE al controllore
qSim = IdMatrix(i:size(Traj,1)+i-1,23:29); % Matrice Q, variabili di giunto LETTE dal controllore
ISim = IdMatrix(i:size(Traj,1)+i-1,37:43); % Matrice delle Correnti lette dai sensori










