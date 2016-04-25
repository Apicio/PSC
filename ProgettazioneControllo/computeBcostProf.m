function [ Bconst ] = computeBconst( )
pos_inf = [-2.9671   -3.0543    -1.5708    -3.6652    -2.2689    -43.9823]; %m m radx6
pos_sup = [2.9671    1.1345     1.3963     3.6652     2.2689     50.2655]; 
T = 0.05;
%% Giunto 6
giunto = 6;
qDH = zeros(1,6);
ddqDH = zeros(1,6);
range = pos_inf(giunto):T:pos_sup(giunto);
tmpBM = zeros(size(range));
for j=1:1:size(range,2)
    qDH(giunto) = range(j); ddqDH(giunto) = 1;
    tmp = MatriceInerzia([0,0,qDH])*[0,0,ddqDH]';
    tmpBM(j) = mean(tmp);
end
Bconst(giunto,giunto) = mean(tmpBM)
disp(strcat('done ',num2str(giunto)));
%% Giunto 5
giunto = 5;
qDH = zeros(1,6);
ddqDH = zeros(1,6);
range = pos_inf(giunto):T:pos_sup(giunto);
tmpBM = zeros(size(range));
for j=1:1:size(range,2)
    qDH(giunto) = range(j); ddqDH(giunto) = 1;
    tmp = MatriceInerzia([0,0,qDH])*[0,0,ddqDH]';
    tmpBM(j) = mean(tmp);
end
Bconst(giunto,giunto) = mean(tmpBM)
disp(strcat('done ',num2str(giunto)));
%% Giunto 4
giunto = 4;
qDH = zeros(1,6);
ddqDH = zeros(1,6);
range = pos_inf(giunto):T:pos_sup(giunto);
tmpBM = zeros(size(range));
for j=1:1:size(range,2)
    qDH(giunto) = range(j); ddqDH(giunto) = 1;
    tmp = MatriceInerzia([0,0,qDH])*[0,0,ddqDH]';
    tmpBM(j) = mean(tmp);
end
Bconst(giunto,giunto) = mean(tmpBM)
disp(strcat('done ',num2str(giunto)));
%% Giunto 3
giunto = 3;
qDH = zeros(1,6);
ddqDH = zeros(1,6);
range = pos_inf(giunto):T:pos_sup(giunto);
tmpBM = zeros(size(range));
for j=1:1:size(range,2)
    qDH(giunto) = range(j); ddqDH(giunto) = 1;
    tmp = MatriceInerzia([0,0,qDH])*[0,0,ddqDH]';
    tmpBM(j) = mean(tmp);
end
Bconst(giunto,giunto) = mean(tmpBM)
disp(strcat('done ',num2str(giunto)));
%% Giunto 2
giunto = 2;
dipendenza1 = 3;
qDH = zeros(1,6);
ddqDH = zeros(1,6);
range = pos_inf(giunto):T:pos_sup(giunto);
rangedip1 = pos_inf(dipendenza1):T:pos_sup(dipendenza1);
curr = zeros(8,1);
iter = 1;
for j=1:size(range,2)
    for k = 1:size(rangedip1,2)
        qDH(giunto) = range(j); ddqDH(giunto) = 1; qDH(dipendenza1) = rangedip1(k);
        tmp = MatriceInerzia([0,0,qDH])*[0,0,ddqDH]';
        curr = tmp + curr;
        iter = iter +1;
    end
end
Bconst(giunto,giunto) = mean(curr./iter)
disp(strcat('done ',num2str(giunto)));
%% Giunto 1
giunto = 1;
dipendenza1 = 2;
dipendenza2 = 3;
qDH = zeros(1,6);
ddqDH = zeros(1,6);
range = pos_inf(giunto):T:pos_sup(giunto);
rangedip1 = pos_inf(dipendenza1):T:pos_sup(dipendenza1);
rangedip2 = pos_inf(dipendenza2):T:pos_sup(dipendenza2);
curr = zeros(8,1);
iter = 1;
for j=1:size(range,2)
    disp(strcat('step ',num2str(j)));
    for k = 1:size(rangedip1,2)
        for i = 1:size(rangedip2,2)
            qDH(giunto) = range(j); ddqDH(giunto) = 1; qDH(dipendenza1) = rangedip1(k); qDH(dipendenza2) = rangedip2(i);
            tmp = MatriceInerzia([0,0,qDH])*[0,0,ddqDH]';
            curr = tmp + curr;
            iter = iter +1;
        end
    end
end
Bconst(giunto,giunto) = mean(curr./iter)
disp(strcat('done ',num2str(giunto)));
% 
% 
% for i=1:6
%     qDH = zeros(1,6);
%     ddqDH = zeros(1,6);
%     range = pos_inf(i):0.001:pos_sup(i);
%     tmpBM = zeros(size(range));
%     for j=1:1:size(range,2)
%         qDH(i) = range(j); ddqDH(i) = 1;
%         G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau
%         tmp = Regressore(qDH,zeros(1,6),ddqDH)*pigreca - G;
%         tmpBM(j) = mean(tmp);
%     end
%     Bconst(i,i) = mean(tmpBM);
% end

end

