function [g] = ForceGravity(body, Nbody, Gravity, Ncoord)

% Initialize force vector
g=zeros(Ncoord,1);

%add gravity force to the vector
for i=1:Nbody
    i1 = 3*i-2;
    i2=i1+1;
    g(i1:i2,1) = body(i).mass*Gravity.force*Gravity.direction;
end

end
