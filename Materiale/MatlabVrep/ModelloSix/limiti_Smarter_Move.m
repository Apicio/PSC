%I vettori seguenti contengono i limiti dei giunti dello SmartSix su
%slitta.
%Il primo giunto e' prismatico e fa riferimento alla slitta.
%N.B.: Tutti  i limiti  sono riferiti a grandezze lato giunto (a valle dei
%riduttori)


%limiti delle coppie erogate dai motori lato giunti
limiti_coppia =[877.8982 1462.6928 558.3315 46.3556 58.4212 46.8812]; %N-Nm. Il primo giunto e' prismatico (slitta)

%%%%%%%%%%%%%%%%%%%LIMITI FISICI DEL MANIPOLATORE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
limiti_giunti_min = [-2.9671  -3.0543  -1.5708   -3.6652  -2.2689 -3.1416]; %[m rad(x6)] fine-corsa minimo in DH ai giunti
limiti_giunti_max = [2.9671   1.1345   1.3963    3.6652   2.2689  9.4248]; %[m rad(x6)] fine-corsa massimo in DH valori ai giunti

 dqmaxcomau = [2.433 2.7925 2.9671 7.8534 6.5443 9.5986]; %[m/s rad/s (x6)] velocita' massime ai giunti 
ddqmaxcomau = [20 20 20 35 45 45]; %%[m/s^2 rad/s^2 (x6)]  accelerazioni massime ai giunti




