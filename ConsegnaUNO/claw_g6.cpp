//  9340 z^2 - 1.556e04 z + 6475      U(z)
//  ----------------------------  =  -----
//       z^2 - 1.8 z + 0.8            E(z)
//   U(z)(z^2 - 1.8 z + 0.8) = E(z)(9340 z^2 - 1.556e04 z + 6475)
//   U(z)*z^2 = U(z)(1.8*z - 0.8) + E(z)(9340 z^2 - 1.556e04 z + 6475)
//   u(k+2) = 1.8*u(k+1) - 0.8*u(k) + 9340*e(k+2) - 15560*e(k+1) + 6475*e(k)
//   u(k) = 1.8*u(k-1) - 0.8*u(k-2) + 9340*e(k) - 15560*e(k-1) + 6475*e(k-2)
//   Funzione di trasferimento ottenuta da InitFuntionIm.m
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
     u = 1.818*uOld - 0.8182*uOldOld + 9969*e - 16860*eOld + 7130*eOldOld;
     return u;
}
