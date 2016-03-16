function [ diff ] = checkAlgorithm(points, N, lam1,lam2)
%CHECKALGORITHM Summary of this function goes here
%   Detailed explanation goes here

W = computeW(points(1:6,1:N), points(7:12,1:N), points(13:18,1:N),N);
load('PigrecaNominale.mat');
T_cap = W*pigregan;
Pi_cap = pinv(W)*T_cap;

diff = mean(W*Pi_cap - T_cap);
costFunctional(points(1:6,1:N), points(7:12,1:N), points(13:18,1:N),lam1,lam2, N)

end

