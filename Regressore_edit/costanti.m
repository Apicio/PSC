LimitiManipolatore;
N=43;
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
    x0(7:12,i) = zeros(6,1);
    x0(13:18,i) = zeros(6,1);
end

    
    % times =  linspace(tstart,tend,size(min,2));
t1 = 0;
t2 =t1 +1*1; % primo
t3 =t2 +1*1;
t4 =t3 +1*1;
t5 =t4 +1*1;
t6 =t5 +1*1;
t7 =t6 +1*0.3;
t8 =t7 +1*0.3;
t9 =t8 +1*1;
t10=t9 +1*1;
t11=t10+1*1;
t12=t11+1*1;
t13=t12+1*1;
t14=t13+1*0.3;
t15=t14+1*0.3;
t16=t15+1*0.3;
t17=t16+1*0.3;
t18=t17+1*1;
t19=t18+1*1;
t20=t19+1*1;
t21=t20+1*1;
t22=t21+1*1;
t23=t22+1*1;
t24=t23+1*1;
t25=t24+1*1;
t26=t25+1*0.3;
t27=t26+1*1;
t28=t27+1*1;
t29=t28+1*1;
t30=t29+1*1;
t31=t30+1*0.2;
t32=t31+1*1;
t33=t32+1*0.2;
t34=t33+1*1;
t35=t34+1*1;
t36=t35+1*0.2;
t37=t36+1*0.2;
t38=t37+1*1;
t39=t38+1*1;
% t40=t39+1*1;
% t41=t40+1*1;
% t42=t41+1*1;
% t43=t42+1*1;