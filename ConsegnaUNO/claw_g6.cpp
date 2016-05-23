double claw_g6(double qd, double qc){ 
/* Declaration */
     static double u;
     static double uOld;
     static double uOldOld;
     static double eOldOld;
     static double eOld;
     static double e;
     static int init;
/* Inizializzazione */
     if(init){
        uOldOld = 0;
        uOld = 0;
        u = 0;
        eOldOld = 0;
        eOld = 0;
        e = 0;
        init = 0;
     }
/* Control Law */    
     uOldOld = uOld;
     uOld = u;
     eOldOld = eOld;
     eOld = e;
     e = qd-qc;
     u = 1.549*uOld - 0.5488*uOldOld + 600*e + 3244*eOld - 3260*eOldOld;
     return u;
}
