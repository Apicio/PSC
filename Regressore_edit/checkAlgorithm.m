function checkAlgorithm(points, N)
% Usata per testare la bontà dell'algoritmo di regressione
W = computeW(points(1:6,1:N), points(7:12,1:N), points(13:18,1:N),N);
load('PigrecaNominale.mat');
T_cap = W*pigregan;
Pi_cap = pinv(W)*T_cap;

Differenza_tra_Tau_nominale_e_Tau_colcolate = mean(W*Pi_cap - T_cap)
Valore_di_Costo = costFunctional(points(1:6,1:N), points(7:12,1:N), points(13:18,1:N), N)
end

