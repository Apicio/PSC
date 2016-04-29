clc;
warning off
%StopVrepSimulation(); %pre precauzione


%%%%%%%%%%%%%%%%%%%%%%%%%%   Set Path  %%%%%%%%%%%%%%%%%%%%%%%%%%
%restoredefaultpath
addpath(genpath('/usr/local/src/vrep/'))
% OGNUNO DI VOI DOVRA' METTERE IL PATH ALLA CARTELLA PROGRAMMING NELLA
% DIRECTORY DI INSTALLAZIONE DI VREP
addpath(genpath('C:\Program Files (x86)\V-REP3\V-REP_PRO_EDU\programming'));
addpath(genpath('./')); %aggiungo il path corrente al path di matlab in modo che le funzioni nelle sottodirectory possano viste dal Matlab
savepath;


%%%%%%%%%              Inizializzazione  %%%%%%%%%%%%%%%%%%%%%%%%%
InitConnectionWithSimulator();%initialize the communication with the Simulator
MotorParametersBushelessLafert(); %load in workspace the parameters of the motors



T = 0.01; %sample time. (USARE QUESTO VALORE.)
Tf = 20; %Final time for simulation. The simulink file provided. uses this value. Change according to your needs