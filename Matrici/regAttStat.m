function Phi = regAttStat(dqDH)
%
% SIX - Gennaio 2005
%
% Phi = phi(q,dq,ddq)
%
% Calcola il regressore ridotto in numerico
% 
% Ingressi:
%   q,dq,ddq : vettori 6x1 secondo convenzioni DH (rad link)
%
% Uscite:
%   Phi : regressore ridotto in numerico
%
% Note:
%   le coppie in uscita sono in convenzione DH e sono quelle richieste agli attuatori (a valle dei riduttori)
%
% File letti:
%   costanti.m : definizione delle costanti dinamiche utilizzate


% **********************************************************************************************************************
% Costanti
% **********************************************************************************************************************

q = zeros(6,1);
dq = zeros(6,1);
ddq = zeros(6,1);

dq(:,1) = dh2comau_vel(dqDH*180/pi);
% Lettura dei dati registrati in "costanti.m"
 
%costanti;

Kr = diag([-1.478018575851390
   1.530000000000000
   1.410000000000000
  -0.514170040485830
   0.810000000000000
   0.500000000000000])*100;


% Velocit� dei motori
  dqm = (Kr*dq) * (pi/180); % in convenzione COMAU in rad/sec

  Phi = zeros(6,40);

      [n,k] = size(Phi);
    soglia = 0.5;
    for i = 1 : n
      % attrito statico
        if abs(dqm(i)) > soglia
          Phi(i,k+1+2*(i-1)) = dqm(i)/abs(dqm(i));
        else
          Phi(i,k+1+2*(i-1)) = dqm(i)/soglia;
        end % if
      % attrito viscoso
        Phi(i,k+2*i) = 0;
    end % for i
  % Contributi dovuti agli attriti
%     [n,k] = size(Phi);
%     for i = 1 : n
%       % attrito statico
%         if abs(dqm(i)) > soglia
%           Phi(i,k+1+2*(i-1)) = dqm(i)/abs(dqm(i));
%         else
%           Phi(i,k+1+2*(i-1)) = dqm(i)/soglia;
%         end % if
%       % attrito viscoso
%         Phi(i,k+2*i) = dqm(i);
%     end % for i
H=[ -1     0     0     0     0     0
     0     1     0     0     0     0
     0     0    -1     0     0     0
     0     0     0    -1     0     0
     0     0     0     0     1     0
     0     0     0     0     0    -1];
 Phi=(H')^-1*Phi;