close all; clearvars;
%% Inizializzazione Parametri
cd utilis
load('Bconst.mat');

ParametriMotori
cd ..
Td = 1/500;
I = Kr^-1*Bconst*Kr^-1;
Tm = I*Ra*Kt^-1*Kv^-1;          %Cosante di tempo sistema
KM = Kv^-1;                     %Guadagno sistema
% syms z w ktv kp ktp km kv ktp ka kta xr
% eq1 = 2*z/w - ktv/(kp*ktp)
% eq2 = 1/(w^2) - ((1+km*ka*kta)/(km*kp*ktp*kv*ka))
% eq3 = xr - kp*ktp*kv*ka
% S = solve(eq1,eq2,eq3,kp,kv,ka)
% S.kp = (ktv*w)/(2*ktp*z)
% S.kv = (2*km*kta*w*xr*z)/(ktv*(- w^2 + km*xr))
% S.ka = (- w^2 + km*xr)/(km*kta*w^2)

Z = diag([1 1 1 1 1 1]);
W = 0.7.*diag([360 430 420 404 530 481]);
XR = 10^7.*diag([1 1 1 1 1 1]); %TO ASK: Molto grande, sia in acc che in vel.

KTV = diag([1 1 1 1 1 1]); % Guadagno trasduttore in velocit�
KTP = diag([1 1 1 1 1 1]); % Guadagno trsduttore in posizione
KTA = diag([1 1 1 1 1 1]); % Guadagno trasduttore in accelerazione

KCP = diag([(KTV(1,1)*W(1,1))/(2*KTP(1,1)*Z(1,1)),... %Guadagno controllore in posizione
            (KTV(2,2)*W(2,2))/(2*KTP(2,2)*Z(2,2)),...
            (KTV(3,3)*W(3,3))/(2*KTP(3,3)*Z(3,3)),...
            (KTV(4,4)*W(4,4))/(2*KTP(4,4)*Z(4,4)),...
            (KTV(5,5)*W(5,5))/(2*KTP(5,5)*Z(5,5)),...
            (KTV(6,6)*W(6,6))/(2*KTP(6,6)*Z(6,6))]);    
KCV = diag([(2*KM(1,1)*KTA(1,1)*W(1,1)*XR(1,1)*Z(1,1))/(KTV(1,1)*(-W(1,1)^2 + KM(1,1)*XR(1,1))),... % Guadagno controllore in velocit�
            (2*KM(2,2)*KTA(2,2)*W(2,2)*XR(2,2)*Z(2,2))/(KTV(2,2)*(-W(2,2)^2 + KM(2,2)*XR(2,2))),...
            (2*KM(3,3)*KTA(3,3)*W(3,3)*XR(3,3)*Z(3,3))/(KTV(3,3)*(-W(3,3)^2 + KM(3,3)*XR(3,3))),...
            (2*KM(4,4)*KTA(4,4)*W(4,4)*XR(4,4)*Z(4,4))/(KTV(4,4)*(-W(4,4)^2 + KM(4,4)*XR(4,4))),...
            (2*KM(5,5)*KTA(5,5)*W(5,5)*XR(5,5)*Z(5,5))/(KTV(5,5)*(-W(5,5)^2 + KM(5,5)*XR(5,5))),...
            (2*KM(6,6)*KTA(6,6)*W(6,6)*XR(6,6)*Z(6,6))/(KTV(6,6)*(-W(6,6)^2 + KM(6,6)*XR(6,6)))]); 
KCA = diag([(-W(1,1)^2 + KM(1,1)*XR(1,1))/(KM(1,1)*KTA(1,1)*W(1,1)^2),...  % Guadagno controllore in accelerazione
            (-W(2,2)^2 + KM(2,2)*XR(2,2))/(KM(2,2)*KTA(2,2)*W(2,2)^2),...
            (-W(3,3)^2 + KM(3,3)*XR(3,3))/(KM(3,3)*KTA(3,3)*W(3,3)^2),...
            (-W(4,4)^2 + KM(4,4)*XR(4,4))/(KM(4,4)*KTA(4,4)*W(4,4)^2),...
            (-W(5,5)^2 + KM(5,5)*XR(5,5))/(KM(5,5)*KTA(5,5)*W(5,5)^2),...
            (-W(6,6)^2 + KM(6,6)*XR(6,6))/(KM(6,6)*KTA(6,6)*W(6,6)^2)]);
TCA = diag([Tm(1,1) Tm(2,2) Tm(3,3) Tm(4,4) Tm(5,5) Tm(6,6)]); % Costante di tempo controllore accelerazione

s = tf('s');
%% Definizione controllori %%
KCV = diag(KCV)
F0 = ((eye(6,6) + KM*KCA*KTA)*(TCA*Tm^-1))/(eye(6,6)+KM*KCA*KTA)
F1 = KCP*KCA*KCV;
F2 = (eye(6,6)+s*TCA)/s
F3 = KM/((eye(6,6) +KM*KCA*KTA)*(eye(6,6)+s*Tm))
F4 = KTP/s;
F5 = eye(6,6) + s*KTV/(KCP*KTP);
F =F0*F1*F2*F3*F4*F5;
zpk(F*ones(6,1));
H = KTP*(eye(6,6) + s*KTV)/(KCP*KTP);
W = minreal((H^-1)/(eye(6,6)+F^-1))
W = W*ones(6,1)
figure, step(W), title(strcat('giunto',num2str(i)))


% %% Giunto 2 
% giunto = 2;
% F0 = (1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto)*(TCA(giunto,giunto)/Tm(giunto,giunto)))/(1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto));
% F1 = KCP(giunto,giunto)*KCA(giunto,giunto)*KCV(giunto,giunto);
% F2 = (1+s*TCA(giunto,giunto))/(s);
% F3 = KM(giunto,giunto)/((1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto))*(1+s*Tm(giunto,giunto)*F0));
% F4 = KTP(giunto,giunto)/s;
% F5 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
% F = F1*F2*F3*F4*F5;
% %rltool(minreal(F))
% i =2;
% H = KTP(i,i)*(1 + (s*KTV(i,i))/(KCP(i,i)*KTP(i,i)));
% W = minreal((1/H)/(1+1/F))
% figure, step(W), title(strcat('giunto',num2str(i)))
% % Digitale
% Fd = F*exp(-s*Td/2)
% figure, margin(Fd), title(strcat('delay giunto',num2str(i)))
% W = minreal((1/H)/(1+1/F))
% figure, step(W), title(strcat('delay giunto',num2str(i)))
% %% Giunto 3 
% giunto = 3;
% F0 = (1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto)*(TCA(giunto,giunto)/Tm(giunto,giunto)))/(1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto));
% F1 = KCP(giunto,giunto)*KCA(giunto,giunto)*KCV(giunto,giunto);
% F2 = (1+s*TCA(giunto,giunto))/(s);
% F3 = KM(giunto,giunto)/((1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto))*(1+s*Tm(giunto,giunto)*F0));
% F4 = KTP(giunto,giunto)/s;
% F5 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
% F = F1*F2*F3*F4*F5;
% %rltool(minreal(F))
% i =3;
% H = KTP(i,i)*(1 + (s*KTV(i,i))/(KCP(i,i)*KTP(i,i)));
% W = minreal((1/H)/(1+1/F))
% figure, step(W), title(strcat('giunto',num2str(i)))
% % Digitale
% Fd = F*exp(-s*Td/2)
% figure, margin(Fd), title(strcat('delay giunto',num2str(i)))
% W = minreal((1/H)/(1+1/F))
% figure, step(W), title(strcat('delay giunto',num2str(i)))
% %% Giunto 4 
% giunto = 4;
% F0 = (1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto)*(TCA(giunto,giunto)/Tm(giunto,giunto)))/(1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto));
% F1 = KCP(giunto,giunto)*KCA(giunto,giunto)*KCV(giunto,giunto);
% F2 = (1+s*TCA(giunto,giunto))/(s);
% F3 = KM(giunto,giunto)/((1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto))*(1+s*Tm(giunto,giunto)*F0));
% F4 = KTP(giunto,giunto)/s;
% F5 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
% F = F1*F2*F3*F4*F5;
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
% F0 = (1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto)*(TCA(giunto,giunto)/Tm(giunto,giunto)))/(1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto));
% F1 = KCP(giunto,giunto)*KCA(giunto,giunto)*KCV(giunto,giunto);
% F2 = (1+s*TCA(giunto,giunto))/(s);
% F3 = KM(giunto,giunto)/((1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto))*(1+s*Tm(giunto,giunto)*F0));
% F4 = KTP(giunto,giunto)/s;
% F5 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
% F = F1*F2*F3*F4*F5;
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
% F0 = (1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto)*(TCA(giunto,giunto)/Tm(giunto,giunto)))/(1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto));
% F1 = KCP(giunto,giunto)*KCA(giunto,giunto)*KCV(giunto,giunto);
% F2 = (1+s*TCA(giunto,giunto))/(s);
% F3 = KM(giunto,giunto)/((1+KM(giunto,giunto)*KCA(giunto,giunto)*KTA(giunto,giunto))*(1+s*Tm(giunto,giunto)*F0));
% F4 = KTP(giunto,giunto)/s;
% F5 = 1+ s*KTV(giunto,giunto)/(KCP(giunto,giunto)*KTP(giunto,giunto));
% F = F1*F2*F3*F4*F5;
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