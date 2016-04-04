function [G, Cor, Fs, Fv, B] = generateModel(qDH, dqDH, ddqDH)
% B(q)ddq + C(q,dq)dq + Fv*dq + sign(dq)*Fs + g(q) = tau
load('pi.mat')
G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau

B(:,1) =  Regressore(qDH,zeros(1,6),[1,0,0,0,0,0])*pigreca - G; %% B(q)ddq + g(q) = tau quindi tolgo G per ottenere B(q)ddq
B(:,2) =  Regressore(qDH,zeros(1,6),[0,1,0,0,0,0])*pigreca - G;
B(:,3) =  Regressore(qDH,zeros(1,6),[0,0,1,0,0,0])*pigreca - G;
B(:,4) =  Regressore(qDH,zeros(1,6),[0,0,0,1,0,0])*pigreca - G;
B(:,5) =  Regressore(qDH,zeros(1,6),[0,0,0,0,1,0])*pigreca - G;
B(:,6) =  Regressore(qDH,zeros(1,6),[0,0,0,0,0,1])*pigreca - G;

Sn(:,1) =  Regressore(qDH,[-1,0,0,0,0,0],zeros(1,6))*pigreca - G; % C(q,dq)dq + Fv*dq + sign(dq)*Fs
Sn(:,2) =  Regressore(qDH,[0,-1,0,0,0,0],zeros(1,6))*pigreca - G;
Sn(:,3) =  Regressore(qDH,[0,0,-1,0,0,0],zeros(1,6))*pigreca - G;
Sn(:,4) =  Regressore(qDH,[0,0,0,-1,0,0],zeros(1,6))*pigreca - G;
Sn(:,5) =  Regressore(qDH,[0,0,0,0,-1,0],zeros(1,6))*pigreca - G;
Sn(:,6) =  Regressore(qDH,[0,0,0,0,0,-1],zeros(1,6))*pigreca - G;

Sp(:,1) =  Regressore(qDH,[1,0,0,0,0,0],zeros(1,6))*pigreca - G; % C(q,dq)dq + Fv*dq - Fs
Sp(:,2) =  Regressore(qDH,[0,1,0,0,0,0],zeros(1,6))*pigreca - G;
Sp(:,3) =  Regressore(qDH,[0,0,1,0,0,0],zeros(1,6))*pigreca - G;
Sp(:,4) =  Regressore(qDH,[0,0,0,1,0,0],zeros(1,6))*pigreca - G;
Sp(:,5) =  Regressore(qDH,[0,0,0,0,1,0],zeros(1,6))*pigreca - G;
Sp(:,6) =  Regressore(qDH,[0,0,0,0,0,1],zeros(1,6))*pigreca - G;

CFv = (Sp+Sn)./2; % C(q,dq)dq + Fv*dq
Fs = Sp - CFv;    % C(q,dq)dq + Fv*dq + Fs - C(q,dq)dq + Fv*dq = Fs

end

