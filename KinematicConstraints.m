function [Phi,Jac,Niu,Gamma]=KinematicConstraints(body,time)

global Nrevolute Ndriver
global Flag Nline Ntrans Nground Nrevtra
global Ncoord Nconst w Driver Ground

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
for k=1:Nground
     [Phi,Jac,Niu,Gamma]=ground(Phi,Jac,Niu,Gamma,Nline,body,k);
     Nline=Nline+3
end

% driver
for k=1:Ndriver 
    [Phi,Jac,Niu,Gamma]=driver(Phi,Jac,Niu,Gamma,Nline,body,k,time);
    Nline=Nline+1;
end
% 
% if (Flag.Jacobian==1)
%     Jac(Nline,Driver(1).i*Driver(1).coord)=1; %driver
% end
% 
% %if (Flag.Position==1)
%    [Phi]=simpleconstraints(Phi,body,Nline);
%end



% if (Flag.Position==1)
%     [Phi]=driver(Phi,body,Nline,time);
%     Nline=Nline+1;
% end

end




