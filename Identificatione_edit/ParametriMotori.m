% Resistenza Ohm
ra(1) = 0.87;
ra(2) = 1.7;
ra(3) = 0.87;
ra(4) = 34;
ra(5) = 34;
ra(6) = 34;
Ra = diag(ra);
% Indittanza mH
la(1) = 3*10^-3;
la(2) = 12*10^-3;
la(3) = 3*10^-3;
la(4) = 15*10^-3;
la(5) = 15*10^-3;
la(6) = 15*10^-3;
La = diag(la);
% Momento di inerzia J motore+freno [Kg*m^2]
in(1) = 0.00043;
in(2) = 0.00042;
in(3) = 0.00043;
in(4) = 0.00003;
in(5) = 0.00003;
in(6) = 0.00003;
In = diag(in);
% Kv Voltage constant Vrms/1000RPM
kv(1) = 43;
kv(2) = 62.9;
kv(3) = 43;
kv(4) = 30.8;
kv(5) = 30.8;
kv(6) = 30.8;
Kv = diag(kv);
% Kt = Torque constant Nm/Arms
kt(1) = 0.7;
kt(2) = 1.04;
kt(3) = 0.7;
kt(4) = 0.51;
kt(5) = 0.51;
kt(6) = 0.51;
Kt = diag(kt);
% Kr
kr(1) = -147.8019;
kr(2) = 153.0000;
kr(3) = 141.0000;
kr(4) = -51.4170;
kr(5) =  81.0000;
kr(6) =  50.0000;
Kr = diag(kr);
Kra = Kr;
Kra(6,5) = -1;
% Io
io(1) = 5;
io(2) = 4.8;
io(3) = 5;
io(4) = 0.69;
io(5) = 0.69;
io(6) = 0.69;
Io = diag(io);





