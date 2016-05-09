function out = noiseCompensation(qdDH, dqdDH, ddqdDH)
[G, Cor, Fsdq, ~, B] = generateModel(qdDH, dqdDH);
load('Bconst.mat')
ParametriMotori
Inertia = Kr^-1*(B - Bconst)*ddqdDH';
Coriolis = [Cor(1)/kr(1);
            Cor(2)/kr(2);
            Cor(3)/kr(3);
            Cor(4)/kr(4);
            Cor(5)/kr(5);
            Cor(6)/kr(6)];
Gravity = Kr^-1*G;
out = Coriolis + Inertia + Gravity;
end

