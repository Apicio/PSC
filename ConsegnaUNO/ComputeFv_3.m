load('utilis/pigreca.mat')
cd utilis
Fv(:,1) = regAttVis([1,0,0,0,0,0])*pigreca;
Fv(:,2) = regAttVis([0,1,0,0,0,0])*pigreca;
Fv(:,3) = regAttVis([0,0,1,0,0,0])*pigreca;
Fv(:,4) = regAttVis([0,0,0,1,0,0])*pigreca;
Fv(:,5) = regAttVis([0,0,0,0,1,0])*pigreca;
Fv(:,6) = regAttVis([0,0,0,0,0,1])*pigreca;
save('Fv.mat','Fv')