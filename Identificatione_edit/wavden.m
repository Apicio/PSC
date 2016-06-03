function out_signal = wavden(in_signal, wav, Thr, F)
     n = wmaxlev(length(in_signal), wav); 
     n = max(14, n);
%      [c, l] = wavedec(in_signal, n, wav); 
%      c((abs(c) <= Thr))=0;
     t = wpdec(in_signal,4,wav);
     wpviewcf(t,4);
     out_signal = waverec(c,l,wav);
end

