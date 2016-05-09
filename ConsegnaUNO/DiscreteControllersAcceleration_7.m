close all; clearvars;
%% Inizializzazione Parametri
cd utilis
load('Bconst.mat');
load('traj.mat')
ParametriMotori
Td = 1/500;
I = Kr^-1*Bconst*Kr^-1;
TM = I*Ra*Kt^-1*Kv^-1;          %Cosante di tempo sistema
KM = Kv^-1;                     %Guadagno sistema
% syms z w ktv kp ktp km kv ktp ka kta xr
% eq1 = 2*z/w - ktv/(kp*ktp)
% eq2 = 1/(w^2) - ((1+km*ka*kta)/(km*kp*ktp*kv*ka))
% eq3 = xr - kp*ktp*kv*ka
% S = solve(eq1,eq2,eq3,'kp,kv,ka')
% S.kp = (ktv*w)/(2*ktp*z)
% S.kv = (2*km*kta*w*xr*z)/(ktv*(- w^2 + km*xr))
% S.ka = (- w^2 + km*xr)/(km*kta*w^2)

rlkcv = [2.3336 2.3269 2.3295 2.3279 2.3279 2.3279];
Z = diag([1 1 1 1 1 1]);
W = 0.42.*diag([300 300 300 300 300 300]);
XR = 10^7.*diag([1 1 1 1 1 1]);

KTV = diag([1 1 1 1 1 1]); % Guadagno trasduttore in velocità
KTP = diag([1 1 1 1 1 1]); % Guadagno trsduttore in posizione
KTA = diag([1 1 1 1 1 1]); % Guadagno trasduttore in accelerazione

KCP = diag([(KTV(1,1)*W(1,1))/(2*KTP(1,1)*Z(1,1)),... %Guadagno controllore in posizione
            (KTV(2,2)*W(2,2))/(2*KTP(2,2)*Z(2,2)),...
            (KTV(3,3)*W(3,3))/(2*KTP(3,3)*Z(3,3)),...
            (KTV(4,4)*W(4,4))/(2*KTP(4,4)*Z(4,4)),...
            (KTV(5,5)*W(5,5))/(2*KTP(5,5)*Z(5,5)),...
            (KTV(6,6)*W(6,6))/(2*KTP(6,6)*Z(6,6))]);    
KCV = diag([(rlkcv(1)*KM(1,1)*KTA(1,1)*W(1,1)*XR(1,1)*Z(1,1))/(KTV(1,1)*(-W(1,1)^2 + KM(1,1)*XR(1,1))),... % Guadagno controllore in velocità
            (rlkcv(2)*KM(2,2)*KTA(2,2)*W(2,2)*XR(2,2)*Z(2,2))/(KTV(2,2)*(-W(2,2)^2 + KM(2,2)*XR(2,2))),...
            (rlkcv(3)*KM(3,3)*KTA(3,3)*W(3,3)*XR(3,3)*Z(3,3))/(KTV(3,3)*(-W(3,3)^2 + KM(3,3)*XR(3,3))),...
            (rlkcv(4)*KM(4,4)*KTA(4,4)*W(4,4)*XR(4,4)*Z(4,4))/(KTV(4,4)*(-W(4,4)^2 + KM(4,4)*XR(4,4))),...
            (rlkcv(5)*KM(5,5)*KTA(5,5)*W(5,5)*XR(5,5)*Z(5,5))/(KTV(5,5)*(-W(5,5)^2 + KM(5,5)*XR(5,5))),...
            (rlkcv(6)*KM(6,6)*KTA(6,6)*W(6,6)*XR(6,6)*Z(6,6))/(KTV(6,6)*(-W(6,6)^2 + KM(6,6)*XR(6,6)))]); 
KCA = diag([(-W(1,1)^2 + KM(1,1)*XR(1,1))/(KM(1,1)*KTA(1,1)*W(1,1)^2),...  % Guadagno controllore in accelerazione
            (-W(2,2)^2 + KM(2,2)*XR(2,2))/(KM(2,2)*KTA(2,2)*W(2,2)^2),...
            (-W(3,3)^2 + KM(3,3)*XR(3,3))/(KM(3,3)*KTA(3,3)*W(3,3)^2),...
            (-W(4,4)^2 + KM(4,4)*XR(4,4))/(KM(4,4)*KTA(4,4)*W(4,4)^2),...
            (-W(5,5)^2 + KM(5,5)*XR(5,5))/(KM(5,5)*KTA(5,5)*W(5,5)^2),...
            (-W(6,6)^2 + KM(6,6)*XR(6,6))/(KM(6,6)*KTA(6,6)*W(6,6)^2)]);
TCA = diag([TM(1,1) TM(2,2) TM(3,3) TM(4,4) TM(5,5) TM(6,6)]); % Costante di tempo controllore accelerazione
save('Z.mat','Z'), save('W.mat','W'), save('XR.mat','XR'), save('TCA.mat','TCA');
save('KTV.mat','KTV'), save('KTP.mat','KTP'), save('KTA.mat','KTA');
save('KCP.mat','KCP'),save('KCV.mat','KCV'),  save('KCA.mat','KCA');
save('KM.mat','KM'), save('W_transAccel.mat','W');
cd ..
s = tf('s');
%% Definizione controllori %%
G = KM/((eye(6,6)+KM*KCA*KTA)*(eye(6,6)+s*TM*((eye(6,6)+KM*KCA*KTA*(TCA/TM))/(eye(6,6)+KM*KCA*KTA))));
P = G/s;
C = KCP*KCV*KCA*((eye(6,6)+s*TCA)/(s));
H = KTP*(eye(6,6) + (s*KTV)/(KCP*KTP));
F = C*P*H;
W = minreal((H^-1)/(eye(6,6)+F^-1));
% Digitale
Fd = minreal(F*exp(-s*Td/2));
Fd = Fd*ones(6,1);

for i=1:6
    figure, subplot(121), step(W(i,i))
    Wd(i) = minreal((Fd(i)*H(i,i)^-1)/(1+Fd(i)));
    %subplot(132), step(Wd(i))
    subplot(122), step(c2d(W(i,i),Td,'zoh'));
end

num_el = size(Traj,1);
t = 0:Td:(num_el*Td-Td);
for i=1:6
    sim = lsim(W(i,i),Traj(:,i),t);
    err = sim-Traj(:,i);
    figure, subplot(121), plot(sim);
    subplot(122), plot(err)
end

for i=1:6
    sim = lsim(Wd(i),Traj(:,i),t);
    err = sim-Traj(:,i);
    figure, subplot(121), plot(sim);
    subplot(122), plot(err)
end