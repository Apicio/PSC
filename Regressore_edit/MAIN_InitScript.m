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

load('min_limitiStringentiJ23.mat');
points = [];
for j=1:size(min3,2)
    [p, phi, R, A] = cindir([0,0,min3(1:6,j)'], 'ZYZ');
    points = [points, p];
end
Ix = find(points(1,:)>300);
Iz = find(points(3,:)>300);
I = intersect(Ix,Iz);
minP = min3(:,I);
% minN = [min3(:,3:6), min3(:,9:12), min3(:,14:15), min3(:,17:18), min3(:,20:33), min3(:,38:42), min3(:,44:49)];
minE = 
[times, srt] = minPlot(minN);
traj = genTraj(minN, 1:1:size(minN,2), 6, size(minN,2), times, 1000);
points = [];
for i=1:size(traj,2)
    JOINT = [0 0 traj(1,i) traj(2,i) traj(3,i) traj(4,i) traj(5,i) traj(6,i)];
	SendPoseToVRep(JOINT);
end
for j=1:size(min3,2)
    [p, phi, R, A] = cindir([0,0,min3(1:6,j)'], 'ZYZ');
    p(3)
    if(p(3) < 0.300)
        points = [points, j];
    end
end
%ESEMPIO DI MOVIMENTAZIONE DEL ROBOT
%JOINT = [1 1 0 -pi/2 pi/4 0 0 0]; %(m (x), m(y), rad(joint1), rad(joint2), rad(joint3), rad(joint4), rad(joint5), rad(joint6))
%COMANDO: SendPoseToVRep(JOINT);
