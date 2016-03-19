%% CONNESSIONE V-REP
if(~exist('client') || client ~=0)
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
% N = 75;
% x0 = 
% min_value = findMin(x0, N);
load('costFun38.mat')
%% Check Positions
for i=1:size(min_value,2)
    JOINT = [0 0 min_value(1,i) min_value(2,i) min_value(3,i) min_value(4,i) min_value(5,i) min_value(6,i)];
	SendPoseToVRep(JOINT);
    disp(i);
    pause;
end % Step by Step si controllano i punti da interpolare in Matlab per 
    % verificare la presenza di evntuali punti Critici, nel rispetto delle 
    % dimensioni della scena.
I = [4, 12, 13, 15, 28, 30, 31, 57, 63, 66, 68]; % Punti da rimuovere.
                                                 % 10 29 40 41 42 48
min_value(:,I) = [];
p1 = min_value(:,33);
p2 = min_value(:,40);
p3 = min_value(:,54);
min_value(:,33) = [];
min_value(:,40) = [];
min_value(:,54) = [];
min_value = [p1, p2, p3, min_value];
%% Generazione Traiettoria
F = 1000;
[times, srt] = minPlot(min_value, F);
traj = genTraj(min_value, 1:1:size(min_value,2), 6, size(min_value,2), times, F);
%% Invio traiettoria a V-REP
for i=1:size(traj,2)
    JOINT = [0 0 traj(1,i) traj(2,i) traj(3,i) traj(4,i) traj(5,i) traj(6,i)];
	SendPoseToVRep(JOINT);
end
%% Check Traiettoria
checkAlgorithm(min_value,size(min_value,2))
checkLimits(traj, 1/F)
%% Salvataggio Traiettoria
fileID = fopen('traj.txt','w');
fprintf(fileID,'%f %f %f %f %f %f\n',traj);

flag = 1; i=1;
while(flag == 1)
tstart = 0; tend = size(min_value,2)*i;
traj = genTraj(min_value, 1:1:size(min_value,2), 6, size(min_value,2), tstart, tend, F);
%checkLimits(traj, 1/F)
    if(checkLimits(traj, 1/F) == 1) %Se i limiti sono rispettati, esci.
        flag =-1;
        disp('finito');
    end
    i=i-1*10^(-4)
end


