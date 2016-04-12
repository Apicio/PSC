function [ Bconst ] = computeBconst( )
pos_inf = [-2.9671   -3.0543    -1.5708    -3.6652    -2.2689    -43.9823]; %m m radx6
pos_sup = [2.9671    1.1345     1.3963     3.6652     2.2689     50.2655]; 
load('pi.mat');
means = zeros(1,6);
for i=1:6
    qDH = zeros(1,6);
    ddqDH = zeros(1,6);
    qqq = pos_inf(i):0.001:pos_sup(i);
    tmpBM = zeros(size(qqq));
    for j=1:1:size(qqq,2)
        qDH(i) = qqq(j); ddqDH(i) = 1;
        G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau
        tmp = Regressore(qDH,zeros(1,6),ddqDH)*pigreca - G;
        tmpBM(j) = mean(tmp);
    end
    Bconst(i,i) = mean(tmpBM);
end

end

