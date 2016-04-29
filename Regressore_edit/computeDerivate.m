function [dx, ddx] = computeDerivate(x,T)
dim = size(x);
dx = zeros(dim);
for i=2:dim(2)-1
    dx(i) = (x(i) - x(i-1))./T; 
end
ddx = zeros(dim);
for i=3:dim(2)-1
    ddx(i) = (dx(i) - dx(i-1))./T; 
end
end