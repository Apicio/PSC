function [ diff ] = checkAlgorithm(points, N)
%CHECKALGORITHM Summary of this function goes here
%   Detailed explanation goes here

W = computeW(points(1:6,1:N), points(7:12,1:N), points(13:18,1:N));
load('PigrecaNominale.mat');
T_cap = W*pigregan;
Pi_cap = pinv(W)*T_cap;

diff = W*Pi_cap - T_cap;

end

