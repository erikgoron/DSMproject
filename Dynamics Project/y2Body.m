function [Body] = y2Body(y,Body,NBodies);

%   Transfer the positions to local variables
for i=1:NBodies;
    i1=3*i-2;
    i2=i1+1;
    i3=i2+1;
    Body(i).r=y(i1:i2,1);
    Body(i).theta=y(i3,1);
    
    %   Transformation matrix
    cost=cos(Body(i).theta);
    sint=sin(Body(i).theta);
    Body(i).A=[cost -sint; sint cost];
    Body(i).B=[-sint -cost; cost -sint];
    
    %   Transfer velocities to local variables  
    i1=i1+Ncoord;
    i2=i1+1;
    i3=i2+1;
    Body(i).rd=y(i1:i2,1);
    Body(i).thetad=y(i3,1); 
end

    
    