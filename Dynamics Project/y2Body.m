function [body] = y2Body(y,body,NBody);
global Ncoord 
%   Transfer the positions to local variables
for i=1:NBody;
    i1=3*i-2;
    i2=i1+1;
    i3=i2+1;
    body(i).r=y(i1:i2,1);
    body(i).theta=y(i3,1);
    
    %   Transformation matrix
    cost=cos(body(i).theta);
    sint=sin(body(i).theta);
    body(i).A=[cost -sint; sint cost];
    body(i).B=[-sint -cost; cost -sint];
    
    %   Transfer velocities to local variables  
    i1=i1+Ncoord;
    i2=i1+1;
    i3=i2+1;
    body(i).rd=y(i1:i2,1);
    body(i).thetad=y(i3,1); 
end

end

    
    