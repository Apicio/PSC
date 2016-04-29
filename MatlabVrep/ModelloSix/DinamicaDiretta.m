function [ddqDH] = DinamicaDiretta(u)
%Calcola la dinamica diretta del COMAU su base mobile ......
%In ingresso:
%u [26, 1] che contiene in sequenza
%tau :  coppie ai giunti
%qDH :  posizioni ai giunti in convenzione Denavit-Hartenberg
%dqDH:  velocità ai giunti in convenzione  Denavit-Hartenberg


%In uscita:
%ddqDH: accelerazioni ai giunti


%NOTE:
%       I contributi vengono calcolati a partire dal file phi.m fornito da COMAU
%       il quale lavora in convenzione COMAU, quindi le variabili qDH,
%       dqDH e ddqDH vengono prima covertite in convenzione COMAU, in
%       seguito le coppie in uscita vengono convertite tramite la
%       matrice H (definita in costanti.m) in convenzione DH

tau(:, 1) = u(1:8);
qDH(:, 1) = u(9:16);
dqDH(:, 1) = u(17:24);


Bq = MatriceInerzia(qDH);

CCentrCoriol(:,1) = CCentrifugoCoriolis(qDH, dqDH);
Attr_Viscoso(:,1) = CAViscoso(dqDH);
Gravita(:,1) = CGravita(qDH);

ddqDH = Bq^-1*(tau-CCentrCoriol-Attr_Viscoso-Gravita);



