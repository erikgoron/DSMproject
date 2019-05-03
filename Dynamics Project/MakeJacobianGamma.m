function [Phi,Jac,Niu,Gamma] = MakeJacobianGamma

%   Accessing memory
global Flag Body NBodies Ncoord Nconstraints % et il en manque plein

%   Initializing vectors and Jacobian matrix
Phi = zeros(Ncoord,1);
Jac = zeros(Nconstraints,Ncoord);
Niu = zeros(Ncoord,1);
Gamma = zeros(Ncoord,1);

%   Contribution of revolute joints
Nline = 1;
for k=1:Nrevolute
    [Phi,Jac,Niu,Gamma] = Jnt_revolute(Phi,Jac,Niu,Gamma,Nline,Body,...
        Jnt_revolute,k);
    Nline=Nline+2;
end

%   Contribution of translation joints
Nline = 1;
for k=1:Ntrans
    [Phi,Jac,Niu,Gamma] = Jnt_trans(Phi,Jac,Niu,Gamma,Nline,Body,...
        Jnt_trans,k);
    Nline=Nline+2;
end

%   Contribution of Rev-Rev joints
Nline = 1;
for k=1:Nrevrev
    [Phi,Jac,Niu,Gamma] = Jnt_revrev(Phi,Jac,Niu,Gamma,Nline,Body,...
        Jnt_revrev,k);
    Nline=Nline+1;
end

%   Contribution of Rev-Trans joints
Nline = 1;
for k=1:Nrevtra
    [Phi,Jac,Niu,Gamma] = Jnt_revtra(Phi,Jac,Niu,Gamma,Nline,Body,...
        Jnt_revtra,k);
    Nline=Nline+1;
end

%   Contribution of all other joints and driver, mais je sais pas faire
%   encore
