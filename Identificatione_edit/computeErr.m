function [ err ] = computeErr( vect1, vect2, numJoints )
%COMPUTEERR accetta due vettori colonna
%   Calcola l'errore medio particolarizzato per il singolo giunto. 

err_on_VS = abs(vect1-vect2);
err = zeros(numJoints,1);

for i=1:numJoints
    err(i) = mean(err_on_VS(i:numJoints:end));
end

end

