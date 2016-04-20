%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INIZIALIZZAZIONE %%%%%%%%%%%%%%%%%%%%%%
clear all; close all;
pos_inf = [-2.9671   -3.0543    -1.5708    -3.6652    -2.2689    -43.9823]; %m m radx6
pos_sup = [2.9671    1.1345     1.3963     3.6652     2.2689     50.2655]; 
MotorParametersBushelessLafert
costanti;
load('pigreca2.mat');
load('Fv.mat');
T = 0.1;
Ra(2) = 58.95;
kt = [0.7; 1.04; 0.7; 0.51; 0.51; 0.51];
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
todo = 1;
if(todo)
%% Giunto 6
giunto = 6;
qDH = zeros(1,6);
ddqDH = zeros(1,6);
range = pos_inf(giunto):T:pos_sup(giunto);
tmpBM = zeros(size(range));
for j=1:1:size(range,2)
    qDH(giunto) = range(j); ddqDH(giunto) = 1;
    G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau
    tmp = Regressore(qDH,zeros(1,6),ddqDH)*pigreca - G;
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
    G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau
    tmp = Regressore(qDH,zeros(1,6),ddqDH)*pigreca - G;
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
    G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau
    tmp = Regressore(qDH,zeros(1,6),ddqDH)*pigreca - G;
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
    G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau
    tmp = Regressore(qDH,zeros(1,6),ddqDH)*pigreca - G;
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
curr = zeros(6,1);
iter = 1;
for j=1:size(range,2)
    for k = 1:size(rangedip1,2)
        qDH(giunto) = range(j); ddqDH(giunto) = 1; qDH(dipendenza1) = rangedip1(k);
        G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau
        tmp = Regressore(qDH,zeros(1,6),ddqDH)*pigreca - G;
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
curr = zeros(6,1);
iter = 1;
for j=1:size(range,2)
    disp(strcat('step ',num2str(j)));
    for k = 1:size(rangedip1,2)
        for i = 1:size(rangedip2,2)
            qDH(giunto) = range(j); ddqDH(giunto) = 1; qDH(dipendenza1) = rangedip1(k); qDH(dipendenza2) = rangedip2(i);
            G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau
            tmp = Regressore(qDH,zeros(1,6),ddqDH)*pigreca - G;
            curr = tmp + curr;
            iter = iter +1;
        end
    end
end
disp(strcat('done ',num2str(giunto)));
Bconst(giunto,giunto) = mean(curr./iter)
else
    load('BconstOurLast.mat')
    Bconst
end
%% Compute Wn
KT = diag(kt); KV = diag(kv); RA = diag(Ra); Kr = diag(kr);
I = Kr^-1*Bconst*Kr^-1;
Tm = I*diag(Ra)*KT^-1*KV^-1;
Wn = Tm^-1
%% Compute Tau
%tauAmp = L/R
%tauMecc = I/Fm = (bi/kri^2)/(fv/kri^2) = bi/fv

Fm = Kr^-1*Fv*Kr^-1;
for i=1:6
    tauAmp(i)=La(i)/Ra(i);
    tauMecc(i) = Bconst(i,i)/Fv(i,i); %Non ci interessa l'accoppiamento, stimo solo facendo un confroto fra le tau
end

figure
stem(tauAmp,'r')
hold on
stem(tauMecc,'b')
legend('tauAmp','tauMecc');
s = tf('s');
wn = [];
for i=1:6
    figure
    fun = (kt(i)/(Ra(i)*Fm(i,i)))*((1/(tauAmp(i)*s +1))*(1/(tauMecc(i)*s+1)));
    margin(fun);
    [~,~,~,Wpm] = margin(fun);
    wn = [wn , Wpm];
    hold on
    fun = (kt(i)/(Ra(i)*Fm(i,i)))*(1/(tauMecc(i)*s+1));
    margin(fun);
    title(strcat('Giunto-',num2str(i)));
end
wn


