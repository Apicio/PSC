function out = noiseCompensation(qdDH, dqdDH, ddqdDH)
[G, Cordq, Fsdq, ~, B] = generateModel(qdDH, dqdDH);
load('Bconst.mat')
ParametriMotori
Inertia = Kr^-1*(B - Bconst)*Kr^-1*ddqdDH';
Gravity = Kr^-1*G;
StaticFriction = Fsdq; % Dal regressore questo termine sembrerebbe già lato motori. Manca un Kr^-1 ?
Coriolis = [Cordq(1)/(kr(1)^2) 
            Cordq(2)/(kr(2)^2) 
            Cordq(3)/(kr(3)^2) 
            Cordq(4)/(kr(4)^2) 
            Cordq(5)/(kr(5)^2) 
            Cordq(6)/(kr(6)^2)];
out = Coriolis + Inertia + StaticFriction + Gravity;
end

