function traj = genTraj(path, sorting, numOfJoints, numOfPoints, times, F)
traj = zeros(numOfJoints,times(end)*F+1);
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
           
           fillStart = (j-2)*(times(j)-times(j-1))*F+1;
           fillEnd = (j-1)*(times(j)-times(j-1))*F+1;
           traj(i,fillStart:fillEnd) = p2pInterpolate(startQ, startDQ, startDDQ, endQ, endDQ, endDDQ, startT, endT, F);
        end 
    end
end

