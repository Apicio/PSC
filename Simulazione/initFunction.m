clc; clearvars;
load('KCP.mat')
load('KCV.mat')
load('KTA.mat')
load('KTP.mat')
load('KTV.mat')
load('TCA.mat')
load('W.mat')
load('XR.mat')
load('Z.mat')
load('KCA.mat')
load('KM.mat')
load('traj.mat')
load('Bconst.mat')
load('Fv.mat')
load('trajU.mat')
Tf = 1/500; Ff = 1/Tf; T = Tf;
ParametriMotori
%81576
num_el = size(traj,1);
t = 0:Tf:(num_el*Tf-Tf);
w = 1;
joint = linspace(0,3,81576);
traj = [joint;joint;joint;joint;joint;joint;joint]';
dtraj = sgolayfilt(diff(traj)*Ff,1,17);
ddtraj = sgolayfilt(diff(dtraj)*Ff,1,17);
dtraj = dtraj(2:end,:);
traj = traj(2:end-1,:);

rlkcv = [1.9974 1.9307 2.0798 2.0068 1.6911 1.8684];
rKCV = diag(rlkcv)
KCV = KCV*rKCV^-1

num_el = size(traj,1);
t = 0:Tf:(num_el*Tf-Tf);

traj = traj(:,1:end-1);
dtraj = dtraj(:,1:end-1);
ddtraj = ddtraj(:,1:end-1);

q0 = Kr*traj(1,1:end)';
q0 = q0';

traj = [t', traj];
dtraj = [t', dtraj];
ddtraj = [t', ddtraj];

Im = Kr^-1*Bconst*Kr^-1;

FM = Kr^-1*Fv*Kr^-1;

dist = [t', dist(3:end,:)];

cd 'ModelloSix'
% Kp + Ki/s = (s*Kp+Ki)/s
% Ki*(1+s*(Kp/Ki))/s
% Ki = Kca
% Kp/Ki = Tca -> Kp = Tca*Ki

