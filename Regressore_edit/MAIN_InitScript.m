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
Ic = intersect(find(points(1,:)<0.2), find(points(2,:)<0.1));   % Avoid Center
% In = find(points(3,:)<0.4);                                     % Avoid negative z
% nI = union(Ic,In);
I = [1, 2, 9, 16, 34, 35, 43, 50];
min3(:,I) = [];

% for i=1:size(min3,2)
%     JOINT = [0 0 min3(1,i) min3(2,i) min3(3,i) min3(4,i) min3(5,i) min3(6,i)];
% 	SendPoseToVRep(JOINT);
%     disp(i);
%     pause;
% end

% minN = [min3(:,3:6), min3(:,9:12), min3(:,14:15), min3(:,17:18), min3(:,20:33), min3(:,38:42), min3(:,44:49)];
% [times, srt] = minPlot(min3);
times = linspace(0,size(min3,2)*0.8,size(min3,2));
traj = genTraj(min3, 1:1:size(min3,2), 6, size(min3,2), times, 1000);
points = [];
for i=1:size(traj,2)
    JOINT = [0 0 traj(1,i) traj(2,i) traj(3,i) traj(4,i) traj(5,i) traj(6,i)];
	SendPoseToVRep(JOINT);
    disp(i);
end
for i=1:size(min3,2)
    JOINT = [0 0 min3(1,i) min3(2,i) min3(3,i) min3(4,i) min3(5,i) min3(6,i)];
	SendPoseToVRep(JOINT);
    disp(i);
    pause;
end

%ESEMPIO DI MOVIMENTAZIONE DEL ROBOT
%JOINT = [1 1 0 -pi/2 pi/4 0 0 0]; %(m (x), m(y), rad(joint1), rad(joint2), rad(joint3), rad(joint4), rad(joint5), rad(joint6))
%COMANDO: SendPoseToVRep(JOINT);
