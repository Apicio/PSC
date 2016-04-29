function [err]=SendPoseToVRep(in)
%Invia a vrep la posizione ai giunti del manipolatore.
%Da usare in simulink. Il vettore "in" è costituito da [time JointDH] (dimensione [8,1])

global vrep client JointHandle Mode




t = in(1);
JointDH = in(2:end);
err(1:7) = 0;


if(t>0.01)
err = setPosDH(vrep, client, JointHandle, JointDH, Mode);
end