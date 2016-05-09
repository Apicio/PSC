function [G, Cor, Fsdq, Fv, B] = generateModel(qDH, dqDH)
% B(q)ddq + C(q,dq)dq + Fv*dq + sign(dq)*Fs + g(q) = tau
load('pigreca.mat')
ParametriMotori
G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau

B(:,1) =  Regressore(qDH,zeros(1,6),[1,0,0,0,0,0])*pigreca - G; %% B(q)ddq + g(q) = tau quindi tolgo G per ottenere B(q)ddq
B(:,2) =  Regressore(qDH,zeros(1,6),[0,1,0,0,0,0])*pigreca - G;
B(:,3) =  Regressore(qDH,zeros(1,6),[0,0,1,0,0,0])*pigreca - G;
B(:,4) =  Regressore(qDH,zeros(1,6),[0,0,0,1,0,0])*pigreca - G;
B(:,5) =  Regressore(qDH,zeros(1,6),[0,0,0,0,1,0])*pigreca - G;
B(:,6) =  Regressore(qDH,zeros(1,6),[0,0,0,0,0,1])*pigreca - G;

% Bc = diag([mean(B(:,1)),mean(B(:,2)),mean(B(:,3)),mean(B(:,4)),mean(B(:,5)),mean(B(:,6))]);
% dB = B - Bc;

Fv(:,1) = regAttVis([1,0,0,0,0,0])*pigreca;
Fv(:,2) = regAttVis([0,1,0,0,0,0])*pigreca;
Fv(:,3) = regAttVis([0,0,1,0,0,0])*pigreca;
Fv(:,4) = regAttVis([0,0,0,1,0,0])*pigreca;
Fv(:,5) = regAttVis([0,0,0,0,1,0])*pigreca;
Fv(:,6) = regAttVis([0,0,0,0,0,1])*pigreca;
Fsdq = regAttStat(dqDH)*pigreca;
% Fs = zeros(6,6); S = zeros(1,6);
% soglia = 0.5;
% dqm = Kr*dqDH';
% for i = 1 : 6
%     if abs(dqm(i)) > soglia
%       S(1,i) = dqm(i)/abs(dqm(i));
%     else
%       S(1,i) = dqm(i)/soglia;
%     end
%     Fs(i,i) = Fsdq(i)/S(1,i);
% end
Cordq =  Regressore(qDH,dqDH,zeros(1,6))*pigreca - G - Fv*dqDH' - Fsdq;
Cor = diag([Cordq(1)/dqDH(1), Cordq(2)/dqDH(2), Cordq(3)/dqDH(3), Cordq(4)/dqDH(4), Cordq(5)/dqDH(5), Cordq(6)/dqDH(6)]);
end

