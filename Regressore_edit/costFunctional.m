function  cost = costFunctional(qDH, dqDH, ddqDH, N)
%Rappresentazione della funzione di costo
%   Il funzionale di costo che si vuole minimizzare è nella forma:

%       f = k1*cond(Ws) + k2/lamMIN(Ws*Ws^T)

% Minimizzando il secondo termine stiamo garantendo di rimanere lontani
% dalle singolarità nel mentre il manipolatore si muove per misurare i
% parametri dinamici, il primo termine ci piacerebbe fosse unitario in
% quanto questo significherebbe essere immuni ai rumori di misura. Questo
% significa che l'algoritmo di ottimizzazione del funzionale di costo può
% trovare una soluzione la cui precisione NON è peggiore di quella fatta
% sui dati in ingresso (Ws). NOTA BENE: questo non significa che
% l'algoritmo converge prima. 

%DOMANDA: Vogliamo cond(Ws) unitario. E' il suo limite inferiore. 

%n*N>= p 
%n = 6 -> num variabili di giunto
%p = 52 -> numero di colonne del regressore dopo la riduzione. Inizialmente
%          erano ovviamente 13*6, ovvero 13 parametri per ogni var di giunto.
%Scegliamo N di conseguenza. 
% N = 10.

WN = zeros(6*N,52);
for i = 1:N
   start = (i-1)*6+1;
   stop = i*6;
   WN(start:stop,:) = Regressore(qDH(:,i),dqDH(:,i),ddqDH(:,i));
end 
 s = svd(WN);
 cost = max(s)/min(s) + 1/min(s);
end

 

