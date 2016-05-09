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
% syms z w ktv kp ktp km kv ktp
% eq1 = 2*z/w - ktv/(kp*ktp)
% eq2 = w^2 - kp*km*ktp*kv
% S = solve(eq1,eq2,'kp,kv')
% S.kp = (ktv*w)/(2*ktp*z)
% S.kv = (2*w*z)/(km*ktv)

rlkcv = [1.0141 1.0141 1.0141 1.0141 1.0141 1.0141];
Z = diag([1 1 1 1 1 1]);
W = 0.48.*diag([300 300 300 300 300 300]);

KTV = diag([1 1 1 1 1 1]);                          %Guadagno trasduttore velocità
KTP = diag([1 1 1 1 1 1]);                          %Guadagno trasduttore posizione
KCP = diag([(KTV(1,1)*W(1,1))/(2*KTP(1,1)*Z(1,1)),... %Guadagno controllore in posizione
            (KTV(2,2)*W(2,2))/(2*KTP(2,2)*Z(2,2)),...
            (KTV(3,3)*W(3,3))/(2*KTP(3,3)*Z(3,3)),...
            (KTV(4,4)*W(4,4))/(2*KTP(4,4)*Z(4,4)),...
            (KTV(5,5)*W(5,5))/(2*KTP(5,5)*Z(5,5)),...
            (KTV(6,6)*W(6,6))/(2*KTP(6,6)*Z(6,6))]);    
KCV = diag([rlkcv(1)*(2*W(1,1)*Z(1,1))/(KM(1,1)*KTV(1,1)),...
            rlkcv(2)*(2*W(2,2)*Z(2,2))/(KM(2,2)*KTV(2,2)),...
            rlkcv(3)*(2*W(3,3)*Z(3,3))/(KM(3,3)*KTV(3,3)),...
            rlkcv(4)*(2*W(4,4)*Z(4,4))/(KM(4,4)*KTV(4,4)),...
            rlkcv(5)*(2*W(5,5)*Z(5,5))/(KM(5,5)*KTV(5,5)),...
            rlkcv(6)*(2*W(6,6)*Z(6,6))/(KM(6,6)*KTV(6,6))]);   %Guadagno controllore in velocità
TCV = diag([TM(1,1) TM(2,2) TM(3,3) TM(4,4) TM(5,5) TM(6,6)]);  %Costante di tempo controllore
XR = KCP*KTP*KCV;
save('W_transVelocity.mat','W');
cd ..
s = tf('s');
%% Progettazione
C = (KCP*KCV/s)*(s*TCV+eye(6,6));
H = KTP*(eye(6,6) + (s*KTV)/(KCP*KTP));
P = KM/(s*(eye(6,6)+s*TM));
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


% Giunto 1 
% giunto = 1;
% F1 = (KM(giunto,giunto)*KCP(giunto,giunto)*KCV(giunto,giunto)*(1+s*TCV(giunto,giunto)))/(s*s*(1+s*Tm(giunto,giunto)));
% F2 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
% F = F1*KTP(giunto,giunto)*F2;
% zpk(F)
% %rltool(minreal(F))
% i =1;
% H = KTP(i,i)*(1 + (s*KTV(i,i))/(KCP(i,i)*KTP(i,i)));
% W = minreal((1/H)/(1+1/F))
% figure, step(W), title(strcat('giunto',num2str(i)))
% % Digitale
% Fd = F*exp(-s*Td/2)
% figure, margin(Fd), title(strcat('delay giunto',num2str(i)))
% W = minreal((Fd/H)/(1+Fd))
% figure, step(W), title(strcat('delay_giunto',num2str(i)))
% %% Giunto 2 
% giunto = 2;
% F1 = (KM(giunto,giunto)*KCP(giunto,giunto)*KCV(giunto,giunto)*(1+s*TCV(giunto,giunto)))/(s*s*(1+s*Tm(giunto,giunto)));
% F2 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
% F = F1*KTP(giunto,giunto)*F2;
% zpk(F)
% %rltool(minreal(F))
% i =2;
% H = KTP(i,i)*(1 + (s*KTV(i,i))/(KCP(i,i)*KTP(i,i)));
% W = minreal((1/H)/(1+1/F))
% figure, step(W), title(strcat('giunto',num2str(i)))
% % Digitale
% Fd = F*exp(-s*Td/2)
% figure, margin(Fd), title(strcat('delay giunto',num2str(i)))
% W = minreal((1/H)/(1+1/F))
% figure, step(W), title(strcat('delay_giunto',num2str(i)))
% %% Giunto 3 
% giunto = 3;
% F1 = (KM(giunto,giunto)*KCP(giunto,giunto)*KCV(giunto,giunto)*(1+s*TCV(giunto,giunto)))/(s*s*(1+s*Tm(giunto,giunto)));
% F2 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
% F = F1*KTP(giunto,giunto)*F2;
% zpk(F)
% %rltool(minreal(F))
% i =3;
% H = KTP(i,i)*(1 + (s*KTV(i,i))/(KCP(i,i)*KTP(i,i)));
% W = minreal((1/H)/(1+1/F))
% figure, step(W), title(strcat('giunto',num2str(i)))
% % Digitale
% Fd = F*exp(-s*Td/2)
% figure, margin(Fd), title(strcat('delay giunto',num2str(i)))
% W = minreal((1/H)/(1+1/F))
% figure, step(W), title(strcat('delay_giunto',num2str(i)))
% %% Giunto 4 
% giunto = 4;
% F1 = (KM(giunto,giunto)*KCP(giunto,giunto)*KCV(giunto,giunto)*(1+s*TCV(giunto,giunto)))/(s*s*(1+s*Tm(giunto,giunto)));
% F2 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
% F = F1*KTP(giunto,giunto)*F2;
% zpk(F)
% %rltool(minreal(F))
% i =4;
% H = KTP(i,i)*(1 + (s*KTV(i,i))/(KCP(i,i)*KTP(i,i)));
% W = minreal((1/H)/(1+1/F))
% figure, step(W), title(strcat('giunto',num2str(i)))
% % Digitale
% Fd = F*exp(-s*Td/2)
% figure, margin(Fd), title(strcat('delay giunto',num2str(i))) 
% W = minreal((1/H)/(1+1/F))
% figure, step(W), title(strcat('delay giunto',num2str(i)))
% %% Giunto 5 
% giunto = 5;
% F1 = (KM(giunto,giunto)*KCP(giunto,giunto)*KCV(giunto,giunto)*(1+s*TCV(giunto,giunto)))/(s*s*(1+s*Tm(giunto,giunto)));
% F2 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
% F = F1*KTP(giunto,giunto)*F2;
% zpk(F)
% %rltool(minreal(F))
% i =5;
% H = KTP(i,i)*(1 + (s*KTV(i,i))/(KCP(i,i)*KTP(i,i)));
% W = minreal((1/H)/(1+1/F))
% figure, step(W), title(strcat('giunto',num2str(i)))
% % Digitale
% Fd = F*exp(-s*Td/2)
% figure, margin(Fd), title(strcat('delay giunto',num2str(i)))
% W = minreal((1/H)/(1+1/F))
% figure, step(W), title(strcat('delay giunto',num2str(i)))
% %% Giunto 6 
% giunto = 6;
% F1 = (KM(giunto,giunto)*KCP(giunto,giunto)*KCV(giunto,giunto)*(1+s*TCV(giunto,giunto)))/(s*s*(1+s*Tm(giunto,giunto)));
% F2 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
% F = F1*KTP(giunto,giunto)*F2;
% zpk(F)
% %rltool(minreal(F))
% i =6;
% H = KTP(i,i)*(1 + (s*KTV(i,i))/(KCP(i,i)*KTP(i,i)));
% W = minreal((1/H)/(1+1/F))
% figure, step(W), title(strcat('giunto',num2str(i)))
% % Digitale
% Fd = F*exp(-s*Td/2)
% figure, margin(Fd), title(strcat('delay giunto',num2str(i)))
% W = minreal((1/H)/(1+1/F))
% figure, step(W), title(strcat('delay giunto',num2str(i))) 