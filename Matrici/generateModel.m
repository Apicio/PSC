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

% Cor(:,1) =  RegrNoAtt(qDH,[dqDH(1),0,0,0,0,0],zeros(1,6))*pigreca - G;
% Cor(:,2) =  RegrNoAtt(qDH,[0,dqDH(2),0,0,0,0],zeros(1,6))*pigreca - G;
% Cor(:,3) =  RegrNoAtt(qDH,[0,0,dqDH(3),0,0,0],zeros(1,6))*pigreca - G;
% Cor(:,4) =  RegrNoAtt(qDH,[0,0,0,dqDH(4),0,0],zeros(1,6))*pigreca - G;
% Cor(:,5) =  RegrNoAtt(qDH,[0,0,0,0,dqDH(5),0],zeros(1,6))*pigreca - G;
% Cor(:,6) =  RegrNoAtt(qDH,[0,0,0,0,0,dqDH(6)],zeros(1,6))*pigreca - G
Cor =  RegrNoAtt(qDH,[dqDH(1),dqDH(2),dqDH(3),dqDH(4),dqDH(5),dqDH(6)],zeros(1,6))*pigreca - G;
end

