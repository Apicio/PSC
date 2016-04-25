function  Attr_Viscoso = CAViscoso(dqDH)
% Ingressi:
%        dqDH : vettori 8x1 secondo convenzioni DH in [m/s rad/s (x6)]
% 
% Uscite:
%       Attr_Viscoso: Coppie di Attrito Viscoso F*dqDH in convenzione DH
%
% Note:
%   le coppie in uscita sono in convenzione DH e sono quelle richieste agli attuatori (a valle dei riduttori)
%


% **********************************************************************************************************************
% Costanti
% **********************************************************************************************************************

% % Lettura dei dati registrati in "costanti.m"
%   % addpath('../modello SIX/')
%   costanti;
% 
%   
%   %vettore dei parametri di attrito viscoso
%   fv = DYN.MODEL(42:2:52); 
%   %fv = theta(42:2:52); 
%   
%   dq(:, 1) = dh2comau_vel(dqDH*180/pi);
%   
%   % Velocit� dei motori
%   dqm = (Kr(2:end, 2:end)*dq) * (pi/180); % in convenzione COMAU in rad/sec
% 
% 
% %Phi = zeros(6,6);
% for i=1:6
%   Phi(i, i) = dqm(i);
% end
% 
% Attr_Viscoso = (H')^-1*Phi*fv;


Attr_Viscoso = [25.4885*dqDH(1)
                25.4885*dqDH(2)
                33.4885*dqDH(3)
                47.1106*dqDH(4)
                42.3273*dqDH(5)
                1.77025*dqDH(6)
                5.13204*dqDH(7)
                1.13629*dqDH(8)];
