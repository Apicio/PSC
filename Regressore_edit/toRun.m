clc; clear all; close all;

% Dichiarazione funzione di costo da minimizzare. 
% Input rappresenta il parametro rispetto a cui minimizzare
costanti;
cost = @(input)costFunctional(input(1:6,1:N), input(7:12,1:N), input(13:18,1:N));
options = optimset('Display', 'iter', 'MaxFunEvals', 1*10^7,'MaxIter', 1*10^7);
%min = fminsearch(cost, x0), options)


min2 = fminbnd(cost, limInf, limSup,options)