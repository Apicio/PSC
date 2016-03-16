function [Phi] = mytform2eul(A, str)
dim = size(A);
if dim(1) == dim(2) == 4
R = A(1:3, 1:3);
else
    R = A;
end
if (strcmp(str,'ZYX') == 1)
    cos_teta = sqrt(R(1,1)^2 + R(2,1)^2);
    if cos_teta == 0
        teta = atan2(-R(3,1),cos_teta);
        phi = 0;
        psi = sin(teta)*atan2(R(1,2),R(2,2));
        Phi = [phi, teta, psi];
        disp('Warning: The resulting ZYX angles are singular');
    else
        teta1 = atan2(-R(3,1),cos_teta);
        phi1 = atan2(R(2,1),R(1,1));
        psi1 = atan2(R(3,2),R(3,3));
        Phi1 = [phi1, teta1, psi1];
        
        teta2 = atan2(-R(3,1),-cos_teta);
        phi2 = atan2(-R(2,1),-R(1,1));
        psi2 = atan2(-R(3,2),-R(3,3));
        Phi2 = [phi2, teta2, psi2];
        
        Phi = Phi2;
    end   
end
if (strcmp(str,'ZYZ') == 1)
    sin_teta = sqrt(R(1,3)^2 + R(2,3)^2);
    if sin_teta == 0
        teta = -atan2(sin_teta, R(3,3));
        phi = 0;
        psi = cos(teta)*atan2(-R(1,2),R(2,2));
        Phi = [phi, teta, psi];
        disp('Warning: The resulting ZYZ angles are singular');
    else
        teta1 = atan2(sin_teta,R(3,3));
        phi1 = atan2(R(2,3),R(1,3));
        psi1 = atan2(R(3,2),-R(3,1));
        Phi1 = [phi1, teta1, psi1];
        
        teta2 = atan2(-sin_teta,R(3,3));
        phi2 = atan2(-R(2,3),-R(1,3));
        psi2 = atan2(-R(3,2),R(3,1));
        Phi2 = [phi2, teta2, psi2];
        
        Phi = Phi2;
    end   
end
end
