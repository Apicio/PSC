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
% FILE: Montecarlo.m
% Condizione iniziale determinata generando casualmente delle matrici di
% dimensione (3*n,N), valudando la funzione di costo, i limiti del
% manipolatore e scegliendo a valle di un certo numero di operazioni la x0
% che presentava il costo minimo. La funzione di costo è calcolata tramite:
% > costFunctional(min_v(1:6,1:N), min_v(7:12,1:N), min_v(13:18,1:N), N);
% A partire dal x0 trovato è stata richiamata la funzione di minimizzazione
% > fmincon(cost, input,[],[],[],[],limInf,limSup,[],options);
% imponendo i limiti di giunto e ulteriori parametri definiti in options.
% Di seguito viene ricaricato il workspace relativo al risultato delle
% operazioni precedentemente descritte. 
load('costFun38.mat')
%% Check Positions
min_value(1,:) = min_value(1,:)+deg2rad(20);
min_value(2,41) = min_value(2,41)-deg2rad(20);
I = [4, 12, 13, 15, 28, 30, 31, 57, 63, 66, 68]; % Punti da rimuovere.
%8(2) 25(3) 34(2) 41(2) 44(3)                                               % 10 29 40 41 42 48
%41 48 52
%30 68 max 32 47
min_value(:,I) = [];
min_value(2,8) = min_value(2,8)-deg2rad(20);
min_value(3,25) = min_value(3,25)+deg2rad(40);
min_value(2,34) = min_value(2,34)-deg2rad(40);
min_value(3,51) = min_value(3,51)+deg2rad(20);
min_value(2,41) = min_value(2,41)-deg2rad(20);
min_value(3,44) = min_value(3,44)+deg2rad(20);
min_value(3,49) = min_value(3,49)-deg2rad(20);

for i=1:size(min_value,2)
    JOINT = [min_value(1,i) min_value(2,i) min_value(3,i) min_value(4,i) min_value(5,i) min_value(6,i)];
	SendPoseToVRep(JOINT);
    disp(i);
    pause;
end % Step by Step si controllano i punti da interpolare in Matlab per 
    % verificare la presenza di evntuali punti Critici, nel rispetto delle 
    % dimensioni della scena.


p1 = min_value(:,33);
p2 = min_value(:,40);
p3 = min_value(:,54);
min_value(:,33) = [];
min_value(:,40) = [];
min_value(:,54) = [];
min_value = [p1, p2, p3, min_value];
%% Generazione Traiettoria
% min_value(7:12,:) = min_value(7:12,:)/1.5;
% min_value(13:18,:) = min_value(13:18,:)/2.25;

F = 1000;
tstart = 0; tend = 1.5;%1.2550;
%[times, srt] = minPlot(min_value, F, tstart, tend);
traj = genTraj(min_value, 1:1:size(min_value,2), 6, size(min_value,2), tstart, tend, F);
%% Invio traiettoria a V-REP
for i=1:size(traj,2)
    JOINT = [traj(1,i) traj(2,i) traj(3,i) traj(4,i) traj(5,i) traj(6,i)];
	SendPoseToVRep(JOINT);
end
%% Check Traiettoria
checkAlgorithm(min_value,size(min_value,2))
[toRet, dtraj, ddtraj] = checkLimits(traj, 1/F);

if (toRet == 1) 
    disp('Check Limiti di Giunto Superato');
end

%% Salvataggio Traiettoria
fileID = fopen('traj.txt','w');
ditance_from_wall = 0.5;
traj(7,:) = ditance_from_wall;
fprintf(fileID,'%f %f %f %f %f %f %f\n',traj);
disp('Traiettoria salvata in traj.txt');


% i = 1.3;
% t = [];
% while(i>0)
% traj = genTraj(min_value, 1:1:size(min_value,2), 6, size(min_value,2), 0, 1.1, F);
%     check = checkLimits(traj, 1/F)
%     if(check(1) == 1) %Se i limiti sono rispettati, esci.
%         t = [t,i];
%         i
%     end
%     i=i-1*10^(-3);
% end


