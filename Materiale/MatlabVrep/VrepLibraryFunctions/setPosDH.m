function [err]=setPosDH(vrep, clientID, JointID, JointDH, mode)
%Invia a vrep la posizione ai giunti del manipolatore

%1) vrep è l'oggetto vrep precedentemente creato
%2) clientID è il descrittore del socket di comunicazione restituito da vrep.simxStart
%3) JointID [7x1] è il puntatore agli oggetti giunti restituito da vrep.simxGetObjectHandle
%4) JointDH [7,1] è la posizione ai giunti in DH da inviare a vrep
%5) mode è la modalità di comunicazione. Vedere documentazione API


%in rad;

for i=1:length(JointID)
err(i) = vrep.simxSetJointPosition(clientID, JointID(i), JointDH(i),   mode);

end