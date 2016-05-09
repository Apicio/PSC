function out = noiseCompensation(qdDH, dqdDH, ddqdDH)
[G, Cor, Fsdq, ~, B] = generateModel(qdDH, dqdDH);
load('Bconst.mat')
ParametriMotori
dqdm = Kr*dqdDH';
ddqdm = Kr*ddqdDH';
Inertia = Kr^-1*(B - Bconst)*Kr^-1*ddqdm;
Coriolis = Kr^-1*Cor*Kr^-1*dqdm;
StaticFriction = [Fsdq(1)/kr(1)^2;
                  Fsdq(2)/kr(2)^2;
                  Fsdq(3)/kr(3)^2;
                  Fsdq(4)/kr(4)^2;
                  Fsdq(5)/kr(5)^2;
                  Fsdq(6)/kr(6)^2];
              
Gravity = Kr^-1*G;
out = Coriolis + Inertia + StaticFriction + Gravity;
end

