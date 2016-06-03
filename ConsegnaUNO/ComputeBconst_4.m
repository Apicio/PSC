clear all; close all;
pos_inf = [-2.9671   -3.0543    -1.5708    -3.6652    -2.2689    -43.9823]; %m m radx6
pos_sup = [2.9671    1.1345     1.3963     3.6652     2.2689     50.2655]; 
load('utilis/pigreca.mat');
T = 0.05;
cd utilis
%% Giunto 6
giunto = 6;
qDH = zeros(1,6);
range = pos_inf(giunto):T:pos_sup(giunto);
tmpBM = zeros(size(range));
for j=1:1:size(range,2)
    qDH(giunto) = range(j);
    G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau
    B(:,1) =  Regressore(qDH,zeros(1,6),[1,0,0,0,0,0])*pigreca - G; %% B(q)ddq + g(q) = tau quindi tolgo G per ottenere B(q)ddq
    B(:,2) =  Regressore(qDH,zeros(1,6),[0,1,0,0,0,0])*pigreca - G;
    B(:,3) =  Regressore(qDH,zeros(1,6),[0,0,1,0,0,0])*pigreca - G;
    B(:,4) =  Regressore(qDH,zeros(1,6),[0,0,0,1,0,0])*pigreca - G;
    B(:,5) =  Regressore(qDH,zeros(1,6),[0,0,0,0,1,0])*pigreca - G;
    B(:,6) =  Regressore(qDH,zeros(1,6),[0,0,0,0,0,1])*pigreca - G;
    tmpBM(j) = B(giunto,giunto);
end
Bconst(giunto,giunto) = mean(tmpBM)
disp(strcat('done ',num2str(giunto)));
%% Giunto 5
giunto = 5;
qDH = zeros(1,6);
range = pos_inf(giunto):T:pos_sup(giunto);
tmpBM = zeros(size(range));
for j=1:1:size(range,2)
    qDH(giunto) = range(j);
    G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau
    B(:,1) =  Regressore(qDH,zeros(1,6),[1,0,0,0,0,0])*pigreca - G; %% B(q)ddq + g(q) = tau quindi tolgo G per ottenere B(q)ddq
    B(:,2) =  Regressore(qDH,zeros(1,6),[0,1,0,0,0,0])*pigreca - G;
    B(:,3) =  Regressore(qDH,zeros(1,6),[0,0,1,0,0,0])*pigreca - G;
    B(:,4) =  Regressore(qDH,zeros(1,6),[0,0,0,1,0,0])*pigreca - G;
    B(:,5) =  Regressore(qDH,zeros(1,6),[0,0,0,0,1,0])*pigreca - G;
    B(:,6) =  Regressore(qDH,zeros(1,6),[0,0,0,0,0,1])*pigreca - G;
    tmpBM(j) = B(giunto,giunto);
end
Bconst(giunto,giunto) = mean(tmpBM)
disp(strcat('done ',num2str(giunto)));
%% Giunto 4
giunto = 4;
qDH = zeros(1,6);
range = pos_inf(giunto):T:pos_sup(giunto);
tmpBM = zeros(size(range));
for j=1:1:size(range,2)
    qDH(giunto) = range(j);
    G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau
    B(:,1) =  Regressore(qDH,zeros(1,6),[1,0,0,0,0,0])*pigreca - G; %% B(q)ddq + g(q) = tau quindi tolgo G per ottenere B(q)ddq
    B(:,2) =  Regressore(qDH,zeros(1,6),[0,1,0,0,0,0])*pigreca - G;
    B(:,3) =  Regressore(qDH,zeros(1,6),[0,0,1,0,0,0])*pigreca - G;
    B(:,4) =  Regressore(qDH,zeros(1,6),[0,0,0,1,0,0])*pigreca - G;
    B(:,5) =  Regressore(qDH,zeros(1,6),[0,0,0,0,1,0])*pigreca - G;
    B(:,6) =  Regressore(qDH,zeros(1,6),[0,0,0,0,0,1])*pigreca - G;
    tmpBM(j) = B(giunto,giunto);
end
Bconst(giunto,giunto) = mean(tmpBM)
disp(strcat('done ',num2str(giunto)));
%% Giunto 3
giunto = 3;
qDH = zeros(1,6);
range = pos_inf(giunto):T:pos_sup(giunto);
tmpBM = zeros(size(range));
for j=1:1:size(range,2)
    qDH(giunto) = range(j);
    G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau
    B(:,1) =  Regressore(qDH,zeros(1,6),[1,0,0,0,0,0])*pigreca - G; %% B(q)ddq + g(q) = tau quindi tolgo G per ottenere B(q)ddq
    B(:,2) =  Regressore(qDH,zeros(1,6),[0,1,0,0,0,0])*pigreca - G;
    B(:,3) =  Regressore(qDH,zeros(1,6),[0,0,1,0,0,0])*pigreca - G;
    B(:,4) =  Regressore(qDH,zeros(1,6),[0,0,0,1,0,0])*pigreca - G;
    B(:,5) =  Regressore(qDH,zeros(1,6),[0,0,0,0,1,0])*pigreca - G;
    B(:,6) =  Regressore(qDH,zeros(1,6),[0,0,0,0,0,1])*pigreca - G;
    tmpBM(j) = B(giunto,giunto);
end
Bconst(giunto,giunto) = mean(tmpBM)
disp(strcat('done ',num2str(giunto)));
%% Giunto 2
giunto = 2;
dipendenza1 = 3;
qDH = zeros(1,6);
range = pos_inf(giunto):T:pos_sup(giunto);
rangedip1 = pos_inf(dipendenza1):T:pos_sup(dipendenza1);
tmpBM = 0; iter = 0;
for j=1:size(range,2)
    for k = 1:size(rangedip1,2)
        qDH(giunto) = range(j); qDH(dipendenza1) = rangedip1(k);
        G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau
        B(:,1) =  Regressore(qDH,zeros(1,6),[1,0,0,0,0,0])*pigreca - G; %% B(q)ddq + g(q) = tau quindi tolgo G per ottenere B(q)ddq
        B(:,2) =  Regressore(qDH,zeros(1,6),[0,1,0,0,0,0])*pigreca - G;
        B(:,3) =  Regressore(qDH,zeros(1,6),[0,0,1,0,0,0])*pigreca - G;
        B(:,4) =  Regressore(qDH,zeros(1,6),[0,0,0,1,0,0])*pigreca - G;
        B(:,5) =  Regressore(qDH,zeros(1,6),[0,0,0,0,1,0])*pigreca - G;
        B(:,6) =  Regressore(qDH,zeros(1,6),[0,0,0,0,0,1])*pigreca - G;
        tmpBM = tmpBM + B(giunto,giunto);
        iter = iter +1;
    end
end
Bconst(giunto,giunto) = tmpBM/iter
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
tmpBM = 0; iter = 0;
for j=1:size(range,2)
    disp(strcat('step ',num2str(j)));
    for k = 1:size(rangedip1,2)
        for i = 1:size(rangedip2,2)
            qDH(giunto) = range(j); qDH(dipendenza1) = rangedip1(k); qDH(dipendenza2) = rangedip2(i);
            G = Regressore(qDH,zeros(1,6),zeros(1,6))*pigreca; % g(q) = tau
            B(:,1) =  Regressore(qDH,zeros(1,6),[1,0,0,0,0,0])*pigreca - G; %% B(q)ddq + g(q) = tau quindi tolgo G per ottenere B(q)ddq
            B(:,2) =  Regressore(qDH,zeros(1,6),[0,1,0,0,0,0])*pigreca - G;
            B(:,3) =  Regressore(qDH,zeros(1,6),[0,0,1,0,0,0])*pigreca - G;
            B(:,4) =  Regressore(qDH,zeros(1,6),[0,0,0,1,0,0])*pigreca - G;
            B(:,5) =  Regressore(qDH,zeros(1,6),[0,0,0,0,1,0])*pigreca - G;
            B(:,6) =  Regressore(qDH,zeros(1,6),[0,0,0,0,0,1])*pigreca - G;
            tmpBM = tmpBM +B(giunto,giunto);
            iter = iter +1;
        end
    end
end
disp(strcat('done ',num2str(giunto)));
Bconst(giunto,giunto) = tmpBM/iter
save('Bconst.mat','Bconst')
