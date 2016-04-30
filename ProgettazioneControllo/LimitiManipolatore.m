
limiti_coppia =[877.8982 1462.6928 558.3315 46.3556 58.4212 46.8812];


%%%%%%%%%%%%%%%%%%%LIMITI FISICI DEL MANIPOLATORE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
limiti_giunto_inf = [-200 -200 -2.9671   -3.0543    -1.5708    -3.6652    -2.2689    -43.9823]; %m m radx6
limiti_giunto_sup = [ 200  200  2.9671    1.1345     1.3963     3.6652     2.2689     50.2655]; %m m radx6
dqmaxcomau = [2 2 2.433 2.7925 2.9671 7.8534 6.5443 9.5986]; %velocita' massime ai giunti m/s m/s rad/sx6
ddqmaxcomau = [0.5 0.5  20 20 20 35 45 45]; %accelerazioni massime ai giunti m/s^2 m/s^2 rad/s^2x6

kr = [-147.8019  153.0000  141.0000  -51.4170   81.0000   50.0000];
Kr = diag(kr);
Q = diag(dqmaxcomau(3:end));
Wdes = Kr*Q