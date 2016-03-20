function toRet = checkLimits(traj, T)
%CHECKLIMITS Summary of this function goes here
%   Detailed explanation goes here
%%%%%%%%%%%%%%%%%%%LIMITI FISICI DEL MANIPOLATORE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dqmaxcomau = [2.433 2.7925 2.9671 7.8534 6.5443 9.5986]; %velocita' massime ai giunti m/s m/s rad/sx6
ddqmaxcomau = [20 20 20 35 45 45]; %accelerazioni massime ai giunti m/s^2 m/s^2 rad/s^2x6dTraj
dtraj = zeros(size(traj));
ddtraj = zeros(size(traj));
% toRet = [];
toRet = 1;
for j=1:size(traj,1)
        [dtraj(j,1:end), ddtraj(j,1:end)] = computeDerivate(traj(j,1:end), T);
        if( abs(max(dtraj(j,10:end))) > dqmaxcomau(j) ||  abs(max(ddtraj(j,10:end))) > ddqmaxcomau(j))
           toRet = [toRet; j];
           toRet(1) = 0;
        end
end


