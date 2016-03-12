LimitiManipolatore;
N=10;
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
x0 = ones(18,N);
for i=1:N
    x0(1:6,i) = 0.5*(limiti_giunto_sup + limiti_giunto_inf)';
    x0(7:12,i) = ones(6,1);
    x0(13:18,i) = ones(6,1);
end