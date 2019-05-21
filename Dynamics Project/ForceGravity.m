function [g] = ForceGravity(Body, NBodies, grav, Ncoord)

% Initialize force vector
g=zeros(Ncoord,1);

%add gravity force to the vector
for i=1:NBodies
    i1 = 3*i-2
    i2=i1+1;
    g(i1:i2,1) = Body(i).mass*grav;
end

end
