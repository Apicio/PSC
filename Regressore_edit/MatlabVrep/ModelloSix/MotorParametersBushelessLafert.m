%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%DATI MOTORI%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Dati elettrici e meccanici dei motori dello smart-Six. Il motore numero 1
%fà riferimento alla slitta.

%MOTORE 1 (slitta) (lafert B56.01P 3.5Nm pagina 48 catalogo lafert brusheless)
La(1)  = 64.5*10^-3; %Henry
Kt(1)  = 1.63;       %costante di coppia Nm/A
Ra(1)  = 38.1;       %Ohm
kv(1)  = 0.95;       %costante elettrica V*s/rad
Imax(1) = 3.5/Kt(1); %corrente massima
kr(1) = 24.4;        %rapporto di trasmissione
%Im(1) = 1e-3*0.073;  %momento di inerzia


%MOTORE 2 (slitta) (lafert B56.01P 3.5Nm pagina 48 catalogo lafert brusheless)
La(2)  = 64.5*10^-3; %Henry
Kt(2)  = 1.63;       %costante di coppia Nm/A
Ra(2)  = 38.1;       %Ohm
kv(2)  = 0.95;       %costante elettrica V*s/rad
Imax(2) = 3.5/Kt(2); %corrente massima
kr(2) = 24.4;        %rapporto di trasmissione
%Im(1) = 1e-3*0.073;  %momento di inerzia



%MOTORE 3 (lafert B56.01P 3.5Nm pagina 48 catalogo lafert brusheless)
La(3)  = 64.5*10^-3; %Henry
Kt(3)  = 1.63;       %costante di coppia Nm/A
Ra(3)  = 38.1;       %Ohm
kv(3)  = 0.95;       %costante elettrica V*s/rad
Imax(3) = 3.5/Kt(3); %corrente massima
kr(3) = -147.8019;   %rapporto di trasmissione (un valore negativo significa che la rotazione in senso 
%orario del motorie provoca una rotazione in senso antiorario del giunto e viceversa) 
%Im(2) = 1e-3*0.073;  %momento di inerzia

%MOTORE 3 (lafert B63.06I 5Nm pagina 48 catalogo lafert brusheless)
La(4) = 28.5*10^-3; %Henry
Kt(4) = 1.63;       %costante di coppia Nm/A
Ra(4) = 5.50;       %Ohm
kv(4) = 0.94;       %costante elettrica V*s/rad
Imax(4) = 3.5/Kt(4);
kr(4) = 153;        %rapporto di trasmissione (un valore negativo significa che la rotazione in senso 
%orario del motorie provoca una rotazione in senso antiorario del giunto e viceversa) 
%Im(3) = 1e-3*0.855;  %momento di inerzia

%MOTORE 4 (lafert B56.01P 3.5Nm pagina 48 catalogo lafert brusheless)
La(5) = 64.5*10^-3; %Henry
Kt(5) = 1.63;       %costante di coppia Nm/A
Ra(5) = 38.1;       %Ohm
kv(5) = 0.95;       %costante elettrica V*s/rad
ktp(5) = 1;         %costante sensore
Imax(5) = 3.5/Kt(5); %corrente massima
kr(5) = 141;        %rapporto di trasmissione (un valore negativo significa che la rotazione in senso 
%orario del motorie provoca una rotazione in senso antiorario del giunto e viceversa) 
%Im(4) = 1e-3*0.073;  %momento di inerzia

%MOTORE 5 (lafert B28.D4S 0.40 0.35Nm pagina 42 catalogo lafert brusheless) 
La(6) = 289*10^-3; %Henry
Kt(6) = 1.45;        %costante di coppia Nm/A
Ra(6) = 229;         %Ohm
kv(6) = 0.84;        %costante elettrica V*s/rad
ktp(6) = 1;          %costante sensore
Imax(6) = 3.5/Kt(6); %corrente massima
kr(6) = -51.417;     %rapporto di trasmissione (un valore negativo significa che la rotazione in senso 
%orario del motorie provoca una rotazione in senso antiorario del giunto e viceversa) 
%Im(5) = 1e-3*0.013;  %momento di inerzia

%MOTORE 6 (lafert B28.D4S 0.40 0.35Nm pagina 42 catalogo lafert brusheless) 
La(7) = 289*10^-3; %Henry
Kt(7) = 1.45;       %costante di coppia Nm/A
Ra(7) = 229;       %Ohm
kv(7) = 0.84;       %costante elettrica V*s/rad
ktp(7) = 1;         %costante sensore
Imax(7) = 3.5/Kt(7); %corrente massima
kr(7) =  81;     %rapporto di trasmissione (un valore negativo significa che la rotazione in senso 
%orario del motorie provoca una rotazione in senso antiorario del giunto e viceversa) 
%Im(6) = 1e-3*0.013;  %momento di inerzia

%MOTORE 7 (lafert B28.D4S 0.40 0.35Nm pagina 42 catalogo lafert brusheless) 
La(8) = 289*10^-3; %Henry
Kt(8) = 1.45;       %costante di coppia Nm/A
Ra(8) = 229;       %Ohm
kv(8) = 0.84;       %costante elettrica V*s/rad
ktp(8) = 1;         %costante sensore
Imax(8) = 3.5/Kt(8); %corrente massima
kr(8) =  50;     %rapporto di trasmissione (un valore negativo significa che la rotazione in senso 
%orario del motorie provoca una rotazione in senso antiorario del giunto e viceversa) 
%Im(7) = 1e-3*0.013;  %momento di inerzia

Kr = diag(kr); %matrice dei rapporti di riduzione
Ra = diag(Ra);
Kt = diag(Kt);
Kv = diag(kv);