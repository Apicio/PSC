clc; clear all; close all;
load('traj.mat')
u = zeros(size(traj,1)-2,size(traj,2)-1);
Fs = 500;
dtraj = sgolayfilt(diff(traj)*Fs,1,17);
ddtraj = sgolayfilt(diff(dtraj)*Fs,1,17);
figure, plot(traj), figure, plot(dtraj), figure, plot(ddtraj);
num = size(traj,1)-2;
parfor i=1:num
    u(i,:) = noiseCompensation(traj(i,1:6), dtraj(i,1:6), ddtraj(i,1:6))';
end