function [M] = MakeMassMatrix (Body, NBodies)

global Ncoord

M = zeros(Ncoord,Ncoord);
for i=1:NBodies
    i1=3*i-2;
    i2=i1+1;
    i3=i2+1;
    M(i1,i1)=Body.mass;
    M(i2,i2)=Body.mass;
    M(i3,i3)=Body.mass;
end
end
