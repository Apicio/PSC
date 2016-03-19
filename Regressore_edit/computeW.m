function WN = computeW(qDH, dqDH, ddqDH, N)
% calcola l'espressione di W al varirare di qDH, dqDH, ddqDH, N usata in checkAlgorithm
WN = ones(N*6,52);
for i = 1:N
   start = (i-1)*6+1;
   stop = i*6;
   WN(start:stop,:) = Regressore(qDH(:,i),dqDH(:,i),ddqDH(:,i));
end
end

