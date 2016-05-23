double claw_g6(double qd, double qc){ 
/* Declaration */
     static double u = 0;
     static double uOld = 0;
     static double uOldOld = 0;
     static double eOldOld = 0;
     static double eOld = 0;
     static double e = 0;
/* Control Law */    
     uOldOld = uOld;
     uOld = u;
     eOldOld = eOld;
     eOld = e;
     e = qd-qc;
//   9969 z^2 - 1.686e04 z + 7130      U(z)
//   ----------------------------  =  -----
//      z^2 - 1.818 z + 0.8182         E(z)
//   U(z)(z^2 - 1.818 z + 0.8182) = E(z)(9969 z^2 - 1.686e04 z + 7130)
//   U(z)*z^2 = U(z)(1.818*z - 0.8182) + E(z)(9969 z^2 - 1.686e04 z + 7130)
//   u(k+2) = 1.818*u(k+1) - 0.8182*u(k) + 9969*e(k+2) - 16860*e(k+1) + 7130*e(k)
//   u(k) = 1.818*u(k-1) - 0.8182*u(k-2) + 9969*e(k) - 16860*e(k-1) + 7130*e(k-2)
     u = 1.818*uOld - 0.8182*uOldOld + 9969*e - 16860*eOld + 7130*eOldOld
     return u;
}
