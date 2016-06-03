function traj = genTraj(path, sorting, numOfJoints, numOfPoints, startT, endT, F)
% Funzione utilizzata per la gernerazione della traiettoria a partire dal minimo di W.

traj = [];
k = 1;
    for i=1:numOfJoints
        for j=2:numOfPoints
           jointStartConf =  path(:,sorting(j-1));
           jointEndConf =  path(:,sorting(j));
           
           startQ = jointStartConf(i);
           endQ = jointEndConf(i);
           startDQ = jointStartConf(i+6);
           endDQ = jointEndConf(i+6);
           startDDQ = jointStartConf(i+12);
           endDDQ = jointEndConf(i+12);
           
           temp = p2pInterpolate(startQ, startDQ, startDDQ, endQ, endDQ, endDDQ, startT, endT, F);
           stop = size(temp,2)+k-1;
           traj(i,k:stop) = temp;
           k = stop;
        end
        k= 1;
    end
end

