global vrep client JointHandle Mode
IP = '127.0.0.1';
Port = 19998;
Timeout = 5000; %timeout for response (ms)
SampleTimeComm =  10; %ms



vrep=remApi('remoteApi','extApi.h');
client = vrep.simxStart(IP, Port, true, true, Timeout, SampleTimeComm);
Mode = vrep.simx_opmode_oneshot; %communication mode (see manual remote API)


%Read from simulator the pointers to joints
pause(0.2);



for i=1:6
    [err, JointHandle(i)] = vrep.simxGetObjectHandle(client, ['Joint', num2str(i), 'Sx'],  vrep.simx_opmode_oneshot_wait);
   if(err)
       error(['Err reading pointer to revolute joint ', num2str(2)]);
   end
end

%[temp, ForceSensorId] = vrep.simxGetObjectHandle(['ForceSensor'],  vrep.simx_opmode_oneshot_wait);
%[temp, EndEffectorId] = vrep.simxGetObjectHandle(client, ['EESx'],  vrep.simx_opmode_oneshot_wait);

  

 err=vrep.simxStartSimulation(client, vrep.simx_opmode_oneshot_wait);
 if(err>1)
   error(['Err staarting simulation']);
 end
 
