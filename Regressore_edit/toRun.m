clc; clear all; close all;

% Dichiarazione funzione di costo da minimizzare. 
% Input rappresenta il parametro rispetto a cui minimizzare
costanti;
load('x0_826.mat');
lam1=1; lam2=1;

cost = @(input)costFunctional(input(1:6,1:N), input(7:12,1:N), input(13:18,1:N),lam1,lam2, N);
options = optimset('Display', 'iter', 'MaxFunEvals', 700000,'MaxIter',1000, 'Algorithm', 'sqp','UseParallel',true, 'ObjectiveLimit', 10, 'TolX', 1*10^-4);
%min = fminsearch(cost, x0, options)


%min2 = fminsearchbnd(cost,hol, limInf, limSup,options)
min3 = fmincon(cost, hol,[],[],[],[],limInf,limSup,[],options)