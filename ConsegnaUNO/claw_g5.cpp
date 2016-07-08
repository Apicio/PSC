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
     u = 1.818*uOld - 0.8182*uOldOld + 9958*e - 16840*eOld + 7119*eOldOld;
     return u;
}
