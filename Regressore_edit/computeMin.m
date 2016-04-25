% clc; clear all; close all;

% Dichiarazione funzione di costo da minimizzare. 
% Input rappresenta il parametro rispetto a cui minimizzare
N = 75;
jointLimit
cost = @(input)costFunctional(input(1:6,:), input(7:12,:), input(13:18,:), N);
limiti_giunto_inf = [-2.9671   lim(1,1)    lim(1,2)    -3.6652    -2.2689    -43.9823].*0.9; %m m radx6
limiti_giunto_sup = [2.9671    lim(2,1)    lim(2,2)     3.6652     2.2689     50.2655].*0.9; %m m radx6
dqmaxcomau = [2.433 2.7925 2.9671 7.8534 6.5443 9.5986]; %velocita' massime ai giunti m/s m/s rad/sx6
ddqmaxcomau = [20 20 20 35 45 45]; %accelerazioni massime ai giunti m/s^2 m/s^2 rad/s^2x6

limInf = ones(18,N);
limSup = ones(18,N);

for i=1:N
    limInf(1:6,i) = limiti_giunto_inf';
    limInf(7:12,i) = -dqmaxcomau';
    limInf(13:18,i) = -ddqmaxcomau';
    limSup(1:6,i) = limiti_giunto_sup';
    limSup(7:12,i) =  dqmaxcomau';
    limSup(13:18,i) = ddqmaxcomau';
end

options = optimset('Display', 'iter', 'MaxFunEvals', 700000,'MaxIter',1000, 'Algorithm', 'sqp','UseParallel',true, 'ObjectiveLimit', 10, 'TolX', 1*10^-4);
%min = fminsearch(cost, x0, options)


%min2 = fminsearchbnd(cost,hol, limInf, limSup,options)
min3 = fmincon(cost, hol,[],[],[],[],limInf,limSup,[],options)