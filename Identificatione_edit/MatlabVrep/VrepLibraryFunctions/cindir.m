function [p, phi, R, A] = cindir(q, str)
LimitiManipolatore
syms teta alfa d a teta1 teta2 teta3 teta4 teta5 teta6 d d1 d2
dim = size(q);

for i=1:dim(2)
    if limiti_giunto_inf(i)<0 && limiti_giunto_sup(i)>0
        if q(i) < limiti_giunto_inf(i) 
            q(i) = limiti_giunto_inf(i);
            disp(strcat('Warning: Lower bound of Joint_',num2str(i),' reached'))
            disp(strcat('Joint_',num2str(i),' is setted to its lowest value'))
        end
        if q(i) > limiti_giunto_sup(i)
            q(i) = limiti_giunto_sup(i);
            disp(strcat('Warning: Upper bound of Joint_',num2str(i),' reached'))
            disp(strcat('Joint_',num2str(i),' is setted to its maximum value'))
        end
    elseif limiti_giunto_inf(i)>0 && limiti_giunto_sup(i)<0
        if q(i) > limiti_giunto_inf(i) 
            q(i) = limiti_giunto_inf(i);
            disp(strcat('Warning: Lower bound of Joint_',num2str(i),' reached'))
            disp(strcat('Joint_',num2str(i),' is setted to its lowest value'))
        end
        if q(i) < limiti_giunto_sup(i)
            q(i) = limiti_giunto_sup(i);
            disp(strcat('Warning: Upper bound of Joint_',num2str(i),' reached'))
            disp(strcat('Joint_',num2str(i),' is setted to its maximum value'))
        end
    end
end

% q =[0 0 0 -pi/2 0 0 0 0];
% Definiamo la Matrice di DH in maniera simbolica.
DH = [      %alpha      teta    d       a;
			-0.5*pi		-0.5*pi	298.5	0   	; %Link m0 di conversione per adattamento a V-Rep.
			0.5*pi		-0.5*pi	d1		0	    ; %Link m1
			0.5*pi		0.5*pi	d2	    0		; %Link m2
            -0.5*pi     teta1   450     150     ; %Link 0
            0		    teta2   0       590     ; %Link 1
            -0.5*pi     teta3   0       130     ; %Link 2
            0.5*pi      teta4   647.07  0       ; %Link 3
            -0.5*pi     teta5   0       0       ; %Link 4
            0           teta6   95      0      ]; %Link 5

% teta1 = 0, teta2 = -pi/2, teta3 = 0, teta4 = 0, teta5 = 0, teta6 = 0;
% d1 = 0
% d2 = 0
DH = eval(subs(DH,[d1,d2,teta1,teta2,teta3,teta4,teta5,teta6],q));
A = [   cos(teta)   -sin(teta)*cos(alfa)   sin(teta)*sin(alfa)    a*cos(teta);
        sin(teta)   cos(teta)*cos(alfa)    -cos(teta)*sin(alfa)   a*sin(teta);
        0           sin(alfa)              cos(alfa)              d          ;
        0           0                       0                     1          ];
% Controlliamo Passo Passo se il centro delle varie terne è coerente con lo schema presente nel DataSheet.
% Pe = [0 0 0 1]'
Am0m1 = eval(subs(A,[alfa,teta,d,a],DH(1,1:end)));
Am1m2 = eval(subs(A,[alfa,teta,d,a],DH(2,1:end)));
Am20 = eval(subs(A,[alfa,teta,d,a],DH(3,1:end)));
% Po = [0 0 298.5 1]';
% disp (Am0m1*Am1m2*Am10*Pe == Po);
A01 = eval(subs(A,[alfa,teta,d,a],DH(4,1:end)));
% Po = [150 0 450+298.5 1]';
% disp (Am0m1*Am1m2*Am10*A01*Pe == Po);
A12 = eval(subs(A,[alfa,teta,d,a],DH(5,1:end)));
% Po = [150 0 450+590+298.5 1]';
% disp(Am0m1*Am1m2*Am10*A01*A12*Pe == Po);
A23 = eval(subs(A,[alfa,teta,d,a],DH(6,1:end)));
% Po = [150 0 450+590+130+298.5 1]';
% disp(Am0m1*Am1m2*Am10*A01*A12*A23*Pe == Po);
A34 = eval(subs(A,[alfa,teta,d,a],DH(7,1:end)));
% Po = [150+647.07 0 450+590+130+298.5 1]';
% disp(Am0m1*Am1m2*Am10*A01*A12*A23*A34*Pe == Po);
A45 = eval(subs(A,[alfa,teta,d,a],DH(8,1:end)));
% disp(Am0m1*Am1m2*Am10*A01*A12*A23*A34*A45*Pe == Po);
A56 = eval(subs(A,[alfa,teta,d,a],DH(9,1:end)));
% Po = [150+647.07+95 0 450+590+130+298.5 1]';
% disp(Am0m1*Am1m2*Am10*A01*A12*A23*A34*A45*A56*Pe == Po);
A6e = [eye(3,3) [0 0 84.8]' ; zeros(1,3) 1];
% Po = [150+647.07+95+88.4 0 450+590+130+298.5 1]';
% disp(Am0m1*Am1m2*Am10*A01*A12*A23*A34*A45*A56*A6e*Pe == Po);

Am0e = Am0m1*Am1m2*Am20*A01*A12*A23*A34*A45*A56*A6e;
% Pe = [0 0 0 1]'
% Po = [(150+647.07+95) 0 (450+590+130) 1]'
% Ricordando la struttura
%     |  R   p | 
% A = |  0   1 |
% Possiamo estrarre i diversi elementi richiesti.
R = Am0e(1:3, 1:3);
p = Am0e(1:3, end);
% Costruiamo la struttura in cui memorizzare tutte le matrici di Roto-Traslazione
A = struct('Am0m1',Am0m1,'Am1m2',Am1m2,'Am10',Am20,'A01',A01,'A12',A12,'A23',A23,'A34',A34,'A45',A45,'A56',A56,'A6e',A6e,'Am0e',Am0e);
% Calcoliamo gli angoli di Eulero tramite apposita funzione, passiamo str che assumerà valore 'ZXZ' oppure 'RPY' a seconda dei casi.
phi = tform2eul(Am0e,str);
if (strcmp(str,'ZYZ') == 1) && (abs(phi(2)) == 0 || abs(phi(2)) == pi)  
    disp('Warning: The resulting angles are singular');
end
if (strcmp(str,'ZYX') == 1) && (abs(phi(2)) == pi/2 || abs(phi(2)) == (3/2)*pi)  
    disp('Warning: The resulting angles are singular');
end
