function [Phi,Jac,Niu,Gamma]=KinematicConstraints(body,time)

global Nrevolute
global Flag Nline Ntrans Ground Nrevtra
global Ncoord Nconst w Driver

Phi=zeros(Nconst,1);
Jac=zeros(Nconst,Ncoord);
Niu=zeros(Nconst,1);
Gamma=zeros(Nconst,1);

Nline=1;

for k=1:Nrevolute
    [Phi,Jac,Niu,Gamma]=JointRevolute(Phi,Jac,Niu,Gamma,Nline,body,k);
    Nline=Nline+2;
end

for k=1:Ntrans
     [Phi,Jac,Niu,Gamma]=Trans(Phi,Jac,Niu,Gamma,Nline,body,k);
     Nline=Nline+2;
end

for k=1:Nrevtra
     [Phi,Jac,Niu,Gamma]=RevTra(Phi,Jac,Niu,Gamma,Nline,body,k);
     Nline=Nline+1;
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

if (Flag.Niu == 1)
    Niu(end)= w;
    
end

end

