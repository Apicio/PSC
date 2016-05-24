clc; clearvars;
cd utilis
load('KCP.mat')
load('KCV.mat')
load('KTA.mat')
load('KTP.mat')
load('KTV.mat')
load('TCA.mat')
load('W.mat')
load('XR.mat')
load('Z.mat')
load('KCA.mat')
load('KM.mat')
load('traj.mat'); traj = Traj; 
load('Bconst.mat')
load('Fv.mat')
load('u_out.mat')
load('KCPv.mat') % Controllo
load('KCVv.mat') % Controllo
load('KTPv.mat') % Controllo
load('KTVv.mat') % Controllo
load('TCVv.mat') % Controllo
ParametriMotori
cd ..
%% Inizializzazione
Tf = 1/500; Ff = 1/Tf; T = Tf;
%81576

% num_el = size(Traj,1);
% t = 0:Tf:(num_el*Tf-Tf);
% w = 1;
% joint = 10*sin(w*t);
% traj = [joint;joint;joint;joint;joint;joint;joint]';
% 
% dtraj = sgolayfilt(diff(traj)*Ff,1,17);
% ddtraj = sgolayfilt(diff(dtraj)*Ff,1,17);
dtraj = diff(traj)*Ff;
ddtraj = diff(dtraj)*Ff;
dtraj = dtraj(2:end,:);
traj = traj(2:end-1,:);
% 
% rlkcv = [1.9974 1.9307 2.0798 2.0068 1.6911 1.8684];
% rKCV = diag(rlkcv)
% KCV = KCV*rKCV^-1

num_el = size(traj,1);
t = 0:Tf:(num_el*Tf-Tf);

traj = traj(:,1:end-1);
dtraj = dtraj(:,1:end-1);
ddtraj = ddtraj(:,1:end-1);

q0 = Kr*traj(1,1:end)';
q0 = q0';

traj = [t', traj];
dtraj = [t', dtraj];
ddtraj = [t', ddtraj];

Im = Kr^-1*Bconst*Kr^-1;

FM = Kr^-1*Fv*Kr^-1;

dist = [t', u];

s = tf('s');
z = tf('z');
Cv1 = KCP*KCV*TCV+KCV*KTV*KTP^-1;
Cv2 = KCP*KCV*s^-1;
Cv3 = KCV*TCV*KTV*KTP^-1.*s;
Cv = (Cv1 + Cv2 + Cv3);

N = 100;
for i=1:6
 tmp = pid(Cv(i,i));
 gP(i) = tmp.Kp;
 gI(i) = tmp.Ki;
 gD(i) = tmp.Kd;
 Cvr(i) = gP(i)+gI(i)/s + gD(i)*(N/(1+N/s));
 Cvd(i) = gP(i)+((Tf*gI(i))/(z-1)) + (gD(i)*((N)/(1+((N*Tf)/(z-1)))));
end
% Cd = c2d(Cvr,Tf,'tutsin');



% s = tf('s');
% C = KCA*(TCA*s+eye(6,6))/s
% Cd = c2d(C,Tf,'zoh')*ones(6,1)
% 
% I = Kr^-1*Bconst*Kr^-1;
% TM = I*Ra*Kt^-1*Kv^-1;
% P = KM(1,1)/(s*(TM(1,1)*s+1))
% % Kp + Ki/s = (s*Kp+Ki)/s
% Ki*(1+s*(Kp/Ki))/s
% Ki = Kca
% Kp/Ki = Tca -> Kp = Tca*Ki

