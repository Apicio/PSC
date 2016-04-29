function Phi = regAttVis(dqDH)
dq = zeros(6,1);
dq(:,1) = dh2comau_vel(dqDH*180/pi);
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
    for i = 1 : n
      % attrito viscoso
        Phi(i,k+2*i) = dqm(i);
    end % for i

H=[ -1     0     0     0     0     0
     0     1     0     0     0     0
     0     0    -1     0     0     0
     0     0     0    -1     0     0
     0     0     0     0     1     0
     0     0     0     0     0    -1];
 Phi=(H')^-1*Phi;