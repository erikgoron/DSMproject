function [Phi,Jac,Niv,Gamma]=KinematicConstraints(body,time)

global Nrevolute
global Flag Nline Ntrans Ground
global Ncoord Nconst w Driver

Phi=zeros(Nconst,1);
Jac=zeros(Nconst,Ncoord);
Niv=zeros(Ncoord,1);
Gamma=zeros(Ncoord,1);

Nline=1;

for k=1:Nrevolute
    [Phi,Jac,Niv,Gamma]=JointRevolute(Phi,Jac,Niv,Gamma,Nline,body,k);
    Nline=Nline+2;
end

for k=1:Ntrans
     [Phi,Jac,Niv,Gamma]=Trans(Phi,Jac,Niv,Gamma,Nline,body,k);
     Nline=Nline+2;
end

%Ground
if (Flag.Position==1)
    Phi(Nline:Nline+1)=body(Ground(1).i).r;
    Phi(Nline+2)=body(Ground(1).i).theta;
    Nline=Nline+3;
end

%driver
if (Flag.Position==1)
    [Phi]=driver(Phi,body,Nline,time);
end

if (Flag.Jacobian==1)
    Jac(Nline:Nline+2,(Ground(1).i)*3-2:(Ground(1).i)*3)=eye(3); %ground
    Nline=Nline+3;
    Jac(Nline,Driver(1).i*Driver(1).coord)=1; %driver
end


%if (Flag.Position==1)
%    [Phi]=simpleconstraints(Phi,body,Nline);
%end

if (Flag.Niv == 1)
    Niv(end)= w;
    
end

end

