function [p, phi, R, A] = cindir(q, str)
q = [q(1:2).*1000, q(3:8)];
% Definiamo la Matrice di DH
DH = [      %alpha      teta    d           a;
			-0.5*pi		-0.5*pi	298.5       0   	; %Link b0 di conversione per adattamento a V-Rep.
			0.5*pi		-0.5*pi	q(1)        0	    ; %Link b1
			0.5*pi		0.5*pi	q(2)        0		; %Link b2
            -0.5*pi     q(3)    450         150     ; %Link 0
            0		    q(4)    0           590     ; %Link 1
            -0.5*pi     q(5)    0           130     ; %Link 2
            0.5*pi      q(6)    647.07      0       ; %Link 3
            -0.5*pi     q(7)    0           0       ; %Link 4
            0           q(8)    95          0      ]; %Link 5

Ab0b1 = zeros(4,4);
Ab1b2 = zeros(4,4);
Ab20 = zeros(4,4);
A01 = zeros(4,4);
A12 = zeros(4,4);
A23 = zeros(4,4);
A34 = zeros(4,4); 
A45 = zeros(4,4); 
A56 = zeros(4,4);
A6e = [eye(3,3) [0 0 84.8]' ; zeros(1,3) 1]; 
Ab0e = ones(4,4);
A = struct('Ab0b1',Ab0b1,'Ab1b2',Ab1b2,'Ab20',Ab20,'A01',A01,'A12',A12,'A23',A23,'A34',A34,'A45',A45,'A56',A56,'A6e',A6e,'Ab0e',Ab0e);
fn = fieldnames(A);
for i=1:9
	A.(fn{i}) = [   cos(DH(i,2))   -sin(DH(i,2))*cos(DH(i,1))   sin(DH(i,2))*sin(DH(i,1))    DH(i,4)*cos(DH(i,2));
                    sin(DH(i,2))   cos(DH(i,2))*cos(DH(i,1))    -cos(DH(i,2))*sin(DH(i,1))   DH(i,4)*sin(DH(i,2));
                    0              sin(DH(i,1))                 cos(DH(i,1))                 DH(i,3)             ;
                    0              0                            0                            1                  ];
end
A.Ab0e = A.Ab0b1*A.Ab1b2*A.Ab20*A.A01*A.A12*A.A23*A.A34*A.A45*A.A56*A.A6e;
R = A.Ab0e(1:3, 1:3);
p = A.Ab0e(1:3, end);
p = p./1000;
% Calcoliamo gli angoli di Eulero tramite apposita funzione, passiamo str che assumerà valore 'ZXZ' oppure 'RPY' a seconda dei casi.
phi = mytform2eul(A.Ab0e,str);
if (strcmp(str,'ZYZ') ~= 0) && (abs(phi(2)) == 0 || abs(phi(2)) == pi)  
    disp('Warning: The resulting ZYZ angles are singular');
end
if (strcmp(str,'ZYX') ~= 0) && (abs(phi(2)) == pi/2 || abs(phi(2)) == (3/2)*pi)  
    disp('Warning: The resulting ZYX angles are singular');
end
end

