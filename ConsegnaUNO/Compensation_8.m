clc; clear all; close all;
cd utilis
load('traj.mat')
load('Bconst.mat')
load('Fv.mat')
ParametriMotori
cd ..
u = zeros(size(Traj,1)-2,size(Traj,2)-1);
Fs = 500;
dtraj = sgolayfilt(diff(Traj)*Fs,1,17);
ddtraj = sgolayfilt(diff(dtraj)*Fs,1,17);
figure, plot(Traj), figure, plot(dtraj), figure, plot(ddtraj);
num = size(Traj,1)-2;
parfor i=1:num
    u(i,:) = noiseCompensation(Traj(i,1:6), dtraj(i,1:6), ddtraj(i,1:6))';
end
I = Kr^-1*Bconst*Kr^-1;
Fm = Kr^-1*Fv*Kr^-1;
parfor i=1:num
    ddqm = Kr*ddtraj(i,1:6)';
    dqm = Kr*dtraj(i,1:6)';
    tau(i,:) = I*ddqm + Fm*dqm;
end
%% Grafici (cambiare fra ddtraj/dtraj/traj)
figure; 
subplot(321); plot(tau(:,1)); hold on; plot(u(:,1)); hold on; plot(u(:,1)/10^6);
subplot(322); plot(tau(:,2)); hold on; plot(u(:,2)); hold on; plot(u(:,2)/10^6);
subplot(323); plot(tau(:,3)); hold on; plot(u(:,3)); hold on; plot(u(:,3)/10^6);
subplot(324); plot(tau(:,4)); hold on; plot(u(:,4)); hold on; plot(u(:,4)/10^6);
subplot(325); plot(tau(:,5)); hold on; plot(u(:,5)); hold on; plot(u(:,5)/10^6);
subplot(326); plot(tau(:,6)); hold on; plot(u(:,6)); hold on; plot(u(:,6)/10^6);
save('u_out.mat','u')