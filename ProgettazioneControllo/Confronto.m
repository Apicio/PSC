%% Our Wn
load('BconstOur.mat');
MotorParametersBushelessLafert;
costanti; KT = diag(Kt); KV = diag(kv); RA = diag(Ra); 
Tm = zeros(6,1); Wn = zeros(1,6);
Tm = Bconst*diag(Ra)*KT^-1*KV^-1;
%Tg = Tm*abs(Kr^-1); %% Da Motori a Giunti, non si è ancora capito se è giusto.
Wn = Tm^-1
%% Prof Wn
load('BconstProf.mat');
MotorParametersBushelessLafert;
costanti; KT = diag(Kt); KV = diag(kv); RA = diag(Ra); 
Tm = zeros(6,1); Wn = zeros(1,6);
Tm = Bconst*diag(Ra)*KT^-1*KV^-1;
%Tg = Tm*abs(Kr^-1); %% Da Motori a Giunti, non si è ancora capito se è giusto.
Wn = Tm^-1
%% Our Tau
MotorParametersBushelessLafert;
costanti;
load('Fv.mat');
load('BconstOur.mat');
s = 0:10:50;
%tauAmp = L/R
%tauMecc = I/Fm = (bi/kri^2)/(fv/kri^2) = bi/fv
tauAmp = zeros(1,6);
tauMecc = zeros(1,6);
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

% for i=1:6
%     figure
%     fun = (1/(tauAmp(i)*s +1))*(1/(tauMecc(i)*s+1));
%     bode (fun);
%     hold on
%     fun = (1/(tauMecc(i)*s+1));
%     bode (fun);
%     title(strcat('Giunto-',num2str(i)));
% end
%% Prof Tau
MotorParametersBushelessLafert;
costanti;
Attr_Viscoso = [33.4885
                47.1106
                42.3273
                1.77025
                5.13204
                1.13629];
Fv = diag(Attr_Viscoso);
load('BconstProf.mat');
s = 0:10:50;
%tauAmp = L/R
%tauMecc = I/Fm = (bi/kri^2)/(fv/kri^2) = bi/fv
tauAmp = zeros(1,6);
tauMecc = zeros(1,6);
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

% for i=1:6
%     figure
%     fun = (1/(tauAmp(i)*s +1))*(1/(tauMecc(i)*s+1));
%     bode (fun);
%     hold on
%     fun = (1/(tauMecc(i)*s+1));
%     bode (fun);
%     title(strcat('Giunto-',num2str(i)));
% end