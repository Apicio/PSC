clc;
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

% load('min_fmincon_21.77.mat');
traj = genTraj(min3, [1:1:50], 6, 50, [0:2:98], 10);
points = [];
for i=1:size(traj,2)
    pause(0.1);
    JOINT = [0 0 traj(1,i) traj(2,i) traj(3,i) traj(4,i) traj(5,i) traj(6,i)];
	SendPoseToVRep(JOINT);
    [p, phi, R, A] = cindir(JOINT, 'ZYZ');
    if(p(3) < 300)
        points = [points, i];
    end
end
%ESEMPIO DI MOVIMENTAZIONE DEL ROBOT
%JOINT = [1 1 0 -pi/2 pi/4 0 0 0]; %(m (x), m(y), rad(joint1), rad(joint2), rad(joint3), rad(joint4), rad(joint5), rad(joint6))
%COMANDO: SendPoseToVRep(JOINT);
