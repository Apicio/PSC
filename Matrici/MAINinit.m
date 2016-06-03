clc; clear all; close all;
% B(q)ddq + C(q,dq)dq + Fv*dq + sign(dq)*Fs(dq) + g(q) = tau
qDH = ones(1,6);
dqDH = ones(1,6);
[G, Cordq, Fsdq, Fv, Bc, dB] = generateModel(qDH, dqDH);
costanti

Fm = (Kr^-1)*Fv*(Kr^-1);
BB = (Kr^-1)*Bc*(Kr^-1);
t = BB/Fm;
s = tf('s');
stepinfo(1/(s*t(1,1) +1))
figure
step(1/(s*t(1,1) +1)) 
stepinfo(1/(s*t(2,2) +1))
figure
step(1/(s*t(2,2) +1)) 
stepinfo(1/(s*t(3,3) +1))
figure
step(1/(s*t(3,3) +1)) 
stepinfo(1/(s*t(4,4) +1))
figure
step(1/(s*t(4,4) +1)) 
stepinfo(1/(s*t(5,5) +1))
figure
step(1/(s*t(5,5) +1)) 
stepinfo(1/(s*t(6,6) +1))
figure
step(1/(s*t(6,6) +1)) 

