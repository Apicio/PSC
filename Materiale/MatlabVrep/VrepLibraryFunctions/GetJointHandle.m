function [err JointId]=GetJointHandle(vrep, clientID, mode)
%Prende da vrep i puntatori ai giunti. In uscita err >0, se vi � errore in
%lettura. Il giunto numero 1 � la slitta

%1) vrep è l'oggetto vrep precedentemente creato
%2) clientID è il descrittore del socket di comunicazione restituito da vrep.simxStart
%3) mode è la modalità di comunicazione. Vedere documentazione API
%4) JointID è il vettore di sette elementi contenente i puntatori ai giunti
%in vrep. Il primo elemento punta alla slitta





err = 0;
for i=1:6
    
    [temp, JointId(i)] = vrep.simxGetObjectHandle(clientID, ['Joint', num2str(i), 'Sx'],  mode);
    err = err+temp;
    
end
