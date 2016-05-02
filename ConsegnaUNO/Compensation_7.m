clc; clear all; close all;
load('utilis/traj.mat')
cd utilis
u = zeros(size(Traj,1)-2,size(Traj,2)-1);
Fs = 500;
dtraj = sgolayfilt(diff(Traj)*Fs,1,17);
ddtraj = sgolayfilt(diff(dtraj)*Fs,1,17);
figure, plot(Traj), figure, plot(dtraj), figure, plot(ddtraj);
num = size(Traj,1)-2;
parfor i=1:num
    u(i,:) = noiseCompensation(Traj(i,1:6), dtraj(i,1:6), ddtraj(i,1:6))';
end
%% Grafici (cambiare fra ddtraj/dtraj/traj)
figure; 
subplot(321); plot(ddtraj(:,1)); hold on; plot(u(:,1));
subplot(322); plot(ddtraj(:,2)); hold on; plot(u(:,2));
subplot(323); plot(ddtraj(:,3)); hold on; plot(u(:,3));
subplot(324); plot(ddtraj(:,4)); hold on; plot(u(:,4));
subplot(325); plot(ddtraj(:,5)); hold on; plot(u(:,5));
subplot(326); plot(ddtraj(:,6)); hold on; plot(u(:,6));
save('u_out.mat','u')