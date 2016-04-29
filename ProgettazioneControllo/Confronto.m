%% Our Wn
load('BconstOur.mat');
ParametriMotori
I = Kr^-1*Bconst*Kr^-1;
Tm = I*Ra*Kt^-1*Kv^-1;
%Tg = Tm*abs(Kr^-1); %% Da Motori a Giunti, non si è ancora capito se è giusto.
Wn = Tm^-1
%% Prof Wn
load('BconstProf.mat');
I = Kr^-1*Bconst*Kr^-1;
Tm = I*Ra*Kt^-1*Kv^-1;
%Tg = Tm*abs(Kr^-1); %% Da Motori a Giunti, non si è ancora capito se è giusto.
Wn = Tm^-1
%% Our Tau
load('Fv.mat');
load('BconstOur.mat');
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
%% Prof Tau
Attr_Viscoso = [33.4885
                47.1106
                42.3273
                1.77025
                5.13204
                1.13629];
Fv = diag(Attr_Viscoso);
load('BconstProf.mat');
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