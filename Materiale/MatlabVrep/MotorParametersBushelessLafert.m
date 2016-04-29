T = 0.001; %Passo di campionamento
Tf = 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%DATI MOTORI%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Dati elettrici e meccanici dei motori dello smart-Six. Il motore numero 1
%f� riferimento alla slitta.



%MOTORE 1 (lafert B56.01P 3.5Nm pagina 48 catalogo lafert brusheless)
La(1)  = 64.5*10^-3; %Henry
Kt(1)  = 1.63;       %costante di coppia Nm/A
Ra(1)  = 38.1;       %Ohm
kv(1)  = 0.95;       %costante elettrica V*s/rad
ktp(1) = 1;         %costante sensore posizione
ktv(1) = 1;         %costante sensore velocità
kta(1) = 1;         %costante sensore accelerazione
Imax(1) = 3.5/Kt(1); %corrente massima
kr(1) = -147.8019;   %rapporto di trasmissione (un valore negativo significa che la rotazione in senso 
%orario del motorie provoca una rotazione in senso antiorario del giunto e viceversa) 


%MOTORE 2 (lafert B63.06I 5Nm pagina 48 catalogo lafert brusheless)
La(2) = 28.5*10^-3; %Henry
Kt(2) = 1.63;       %costante di coppia Nm/A
Ra(2) = 5.50;       %Ohm
kv(2) = 0.94;       %costante elettrica V*s/rad
ktp(2) = 1;         %costante sensore posizione
ktv(2) = 1;         %costante sensore velocità
kta(2) = 1;         %costante sensore accelerazione
Imax(2) = 3.5/Kt(2);
kr(2) = 153;        %rapporto di trasmissione (un valore negativo significa che la rotazione in senso 
%orario del motorie provoca una rotazione in senso antiorario del giunto e viceversa) 


%MOTORE 3 (lafert B56.01P 3.5Nm pagina 48 catalogo lafert brusheless)
La(3) = 64.5*10^-3; %Henry
Kt(3) = 1.63;       %costante di coppia Nm/A
Ra(3) = 38.1;       %Ohm
kv(3) = 0.95;       %costante elettrica V*s/rad
ktp(3) = 1;         %costante sensore posizione
ktv(3) = 1;         %costante sensore velocità
kta(3) = 1;         %costante sensore accelerazione
Imax(3) = 3.5/Kt(3); %corrente massima
kr(3) = 141;        %rapporto di trasmissione (un valore negativo significa che la rotazione in senso 
%orario del motorie provoca una rotazione in senso antiorario del giunto e viceversa) 

%MOTORE 4 (lafert B28.D4S 0.40 0.35Nm pagina 42 catalogo lafert brusheless) 
La(4) = 289*10^-3; %Henry
Kt(4) = 1.45;        %costante di coppia Nm/A
Ra(4) = 229;         %Ohm
kv(4) = 0.84;        %costante elettrica V*s/rad
ktp(4) = 1;         %costante sensore posizione
ktv(4) = 1;         %costante sensore velocità
kta(4) = 1;         %costante sensore accelerazione
Imax(4) = 3.5/Kt(4); %corrente massima
kr(4) = -51.417;     %rapporto di trasmissione (un valore negativo significa che la rotazione in senso 
%orario del motorie provoca una rotazione in senso antiorario del giunto e viceversa) 

%MOTORE 5 (lafert B28.D4S 0.40 0.35Nm pagina 42 catalogo lafert brusheless) 
La(5) = 289*10^-3; %Henry
Kt(5) = 1.45;       %costante di coppia Nm/A
Ra(5) = 229;       %Ohm
kv(5) = 0.84;       %costante elettrica V*s/rad
ktp(5) = 1;         %costante sensore posizione
ktv(5) = 1;         %costante sensore velocità
kta(5) = 1;         %costante sensore accelerazione
Imax(5) = 3.5/Kt(5); %corrente massima
kr(5) =  81;     %rapporto di trasmissione (un valore negativo significa che la rotazione in senso 
%orario del motorie provoca una rotazione in senso antiorario del giunto e viceversa) 

%MOTORE 6 (lafert B28.D4S 0.40 0.35Nm pagina 42 catalogo lafert brusheless) 
La(6) = 289*10^-3; %Henry
Kt(6) = 1.45;       %costante di coppia Nm/A
Ra(6) = 229;       %Ohm
kv(6) = 0.84;       %costante elettrica V*s/rad
ktp(6) = 1;         %costante sensore posizione
ktv(6) = 1;         %costante sensore velocità
kta(6) = 1;         %costante sensore accelerazione
Imax(6) = 3.5/Kt(6); %corrente massima
kr(6) =  50;     %rapporto di trasmissione (un valore negativo significa che la rotazione in senso 
%orario del motorie provoca una rotazione in senso antiorario del giunto e viceversa) 


Kr = diag(kr); %matrice dei rapporti di riduzione