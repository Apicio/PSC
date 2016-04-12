close all; clear all; 
pos_inf = [-2.9671   -3.0543    -1.5708    -3.6652    -2.2689    -43.9823]; %m m radx6
pos_sup = [2.9671    1.1345     1.3963     3.6652     2.2689     50.2655]; %m m radx6
dqmaxcomau = [2.433 2.7925 2.9671 7.8534 6.5443 9.5986]; %velocita' massime ai giunti m/s m/s rad/sx6
ddqmaxcomau = [20 20 20 35 45 45]; %accelerazioni massime ai giunti m/s^2 m/s^2 rad/s^2x6dTraj

t1 = 0:F:1;
t2 = 0:F:T;
t3 = 0:F:1;
t = [t1,t2,t3];
s1 = ones(size(t1))*pos_inf(1);
s2 = linspace(pos_inf(1),pos_sup(1),size(t2,2));
s3 = ones(size(t3))*pos_sup(1);
s = [s1,s2,s3]


f = fit(pos_inf(1),pos_sup(1),'fourier2')

traj

% toPrint = ['rotto su '];
% numIter = 10000; Wn=zeros(1,6); T = 0.001;
% t = 0:T:2*pi;
% for j=1:6
%     for i=0:0.001:numIter
%         Wn(j) = Wn(j)+i;
%         tmp = pos_sup(j)*sin(2*pi*t*Wn(j));
%             plot(t,tmp);
%         
%         dtmp = diff(tmp)/T; ddtmp = diff(dtmp)/T;
%         if(max(abs(dtmp))>dqmaxcomau(j) || max(abs(ddtmp))>ddqmaxcomau(j))
%             disp([toPrint(1,:), num2str(j)])
%             break;
%         end
%     end
% end
