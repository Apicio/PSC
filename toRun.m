clc; clear all; close all;

% Dichiarazione funzione di costo da minimizzare. 
% Input rappresenta il parametro rispetto a cui minimizzare
costanti;
lam1=1; lam2=1;

cost = @(input)costFunctional(input(1:6,1:N), input(7:12,1:N), input(13:18,1:N),lam1,lam2);
options = optimset('Display', 'iter')%, 'MaxFunEvals', 1*10^7,'MaxIter', 1*10^7, 'Algorithm','sqp');
%min = fminsearch(cost, x0, options)


min2 = fminsearchbnd(cost,x0, -1*ones(18,N), 1*ones(18,N),options)