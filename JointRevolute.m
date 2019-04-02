function [Phi,Jac,Niu,Gamma] = JointRevolute(Phi,Jac,Niu,Gamma,Nline,Body,Jnt_Revolute,k)
%JointRevolute adds lines  to Phi,Jac,Niu,Gamma for joint and bodies
%   Detailed explanation goes here
global Flag
%initialize
i=Jnt_Revolute(k).i;
j=Jnt_Revolute(k).j;
i1=Nline;
i2=i1+1;

%.. Assemble position constraint eq
if (Flag.Position == 1)
    Phi(i1:i2,1)=Body(i).r+Body(i).A*JntRevolute(k).spPi-...
                Body(j).r+Body(j).A*JntRevolute(k).spPj;
end
%...Assemble Jacoian Matrix
if (Flag.Jacobian == 1)
    j1=3*i-2;j2=j1+2;
    j3=3*j-2;j4=j3+2;

end

