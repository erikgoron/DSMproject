function [M] = MakeMassMatrix (body, Nbody)

global Ncoord

M = zeros(Ncoord,Ncoord);
for i=1:Nbody
    i1=3*i-2;
    i2=i1+1;
    i3=i2+1;
    M(i1,i1)=body.mass;
    M(i2,i2)=body.mass;
    M(i3,i3)=body.Inertia;
end
end
