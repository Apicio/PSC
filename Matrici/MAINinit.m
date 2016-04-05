clc; clear all; close all;
% B(q)ddq + C(q,dq)dq + Fv*dq + sign(dq)*Fs(dq) + g(q) = tau
qDH = ones(1,6);
dqDH = ones(1,6);
[G, Cordq, Fsdq, Fv, Bc, dB] = generateModel(qDH, dqDH);
