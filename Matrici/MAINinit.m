clc; clear all; close all;
% B(q)ddq + C(q,dq)dq + Fv*dq + sign(dq)*Fs(dq) + g(q) = tau
Regressore([1, zeros(1,5)],zeros(1,6),zeros(1,6))*pigreca
Regressore([zeros(1,1),1,zeros(1,4)],zeros(1,6),zeros(1,6))*pigreca
Regressore([zeros(1,2),1,zeros(1,3)],zeros(1,6),zeros(1,6))*pigreca
Regressore([zeros(1,3),1,zeros(1,2)],zeros(1,6),zeros(1,6))*pigreca
Regressore([zeros(1,4),1,zeros(1,1)],zeros(1,6),zeros(1,6))*pigreca
Regressore([zeros(1,5),1],zeros(1,6),zeros(1,6))*pigreca


