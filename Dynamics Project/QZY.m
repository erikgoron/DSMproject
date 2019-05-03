function [Yphi] = QZY(Body, NBodies)

%   Form the vector with initial conditions
for i=1:NBodies
    i1 = 3i-2;
    i2 = i1+1;
    i3 = i2+1;
    y(i1:i2,1) = Body(i).r;
    y(i3:i3,1) = Body(i).theta;
    i4 = NCoordinates+i1;
    i5 = i4+1;
    i6 = i5+1;
    y(i4:i5,1) = Body(i).rd;
    y(i6:i6,1) = Body(i).thetad;
end

    