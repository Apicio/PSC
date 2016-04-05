if(exist('vrep', 'var')&& exist('client', 'var'))
 vrep.simxStopSimulation(client, vrep.simx_opmode_oneshot_wait);
 vrep.simxFinish(client);
 clear vrep;
end;