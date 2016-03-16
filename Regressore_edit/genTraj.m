function traj = genTraj(path, sorting, numOfJoints, numOfPoints, times, F)
traj = [];
k = 1;
    for i=1:numOfJoints
        for j=2:numOfPoints
           jointStartConf =  path(:,sorting(j-1));
           jointEndConf =  path(:,sorting(j));
           
           startT = times(j-1);
           endT = times(j);
           startQ = jointStartConf(i);
           endQ = jointEndConf(i);
           startDQ = jointStartConf(i+6);
           endDQ = jointEndConf(i+6);
           startDDQ = jointStartConf(i+12);
           endDDQ = jointEndConf(i+12);
           
           temp = p2pInterpolate(startQ, startDQ, startDDQ, endQ, endDQ, endDDQ, startT, endT, F);
           
           traj(i,k:size(temp,2)+k-1) = p2pInterpolate(startQ, startDQ, startDDQ, endQ, endDQ, endDDQ, startT, endT, F);
           k = size(temp,2)+k;
        end
        k= 1;
    end
end

