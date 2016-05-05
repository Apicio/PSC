clear all; clearvars;
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
%% Prefiltro
scale = 10;
s = tf('s');
Pr = KTP + s*KTV*KCP^-1 + (s^2*(eye(6,6) + KM*KCA*KTA))/(KM*KCP*KCV*KCA);
pr_data = Pr*ones(6,1)
zpk_data = zpkdata(pr_data);
real_data = real(cell2mat(zpk_data));
tau = -1./real_data(1:2:end);
pole = (diag(tau/scale)*s + eye(6,6))*(diag(tau/scale)*s + eye(6,6))

Prefilter = Pr*pole^-1
Prefilter = Prefilter*ones(6,1)

for i=1:6
    figure, bode(Prefilter(i));
end