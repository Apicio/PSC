function [ err , rel_err] = computeErr( vect1, vect2, numJoints )
%COMPUTEERR accetta due vettori colonna
%   Calcola l'errore medio particolarizzato per il singolo giunto. 

err_on_VS = abs(vect1-vect2);
err = zeros(numJoints,1)';

for i=1:numJoints
    err(i) = mean(err_on_VS(i:numJoints:end));
end

for i=1:numJoints
    mas = max(vect2(i:numJoints:end));
    mis = min(vect2(i:numJoints:end));
    ex(i) = abs(mas-mis);
end
rel_err = err./ex.*100;
end

