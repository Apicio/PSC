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
t = IdMatrix(:,1);       % Vettore dei tempi
qInv = IdMatrix(:,2:8); % Matrice Q, variabili di giunto INVIATE al controllore
qSim = IdMatrix(:,23:29); % Matrice Q, variabili di giunto LETTE dal controllore
ISim = IdMatrix(:,37:43); % Matrice delle Correnti lette dai sensori
%% Troviamo i punti della traiettoria
[~,indx] = ismember(Traj(1,:), qInv, 'rows');
E = 10^2;
tmp = round(qInv.*E)./E;
for i=2:size(min_value,2)
    [~,tmp_indx] = ismember(round([min_value(1:6,i)', distance_from_wall].*E)./E , tmp, 'rows');
    indx = [indx, tmp_indx];
end
%% Check Errors
v = zeros(1,size(min_value,2));
for i=1:size(min_value,2)
    v(i) = norm(min_value(1:6,i) - qInv(indx(i),1:6)');
end
mean(v)











