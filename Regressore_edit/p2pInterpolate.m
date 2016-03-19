function pol = p2pInterpolate(startQ, startDQ, startDDQ, endQ, endDQ, endDDQ, startT, endT, F)
%% POL a*x^5 + b*x^4 + c*x^3 + d*x^2 + e*x + f;
% syms startQ startDQ startDDQ startT endQ endDQ endDDQ endT F
startT = 0;
endT = 0.755;
% syms a b c d e f
    T = [startT^5,   startT^4,     startT^3,   startT^2,    startT,  1;
           endT^5,     endT^4,       endT^3,     endT^2,      endT,  1;
       5*startT^4, 4*startT^3,   3*startT^2,   2*startT,         1,  0;
         5*endT^4,   4*endT^3,     3*endT^2,     2*endT,         1,  0;
      20*startT^3,12*startT^2,     6*startT,          2,         0,  0;
        20*endT^3,  12*endT^2,       6*endT,          2,         0,  0];
            
    X = [startQ; endQ; startDQ; endDQ; startDDQ; endDDQ];
    % I = [a;b;c;d;e;f;g]
    % T*I = X
    I = pinv(T)*X;
%% Costruisco e campiono il polinomio
    k = startT:(1/F):endT;
    pol = polyval(I',k);
%     figure
%     plot(k,pol)
end

