function [Phi,Jac,Niu,Gamma] = ground(Phi,Jac,Niu,Gamma,Nline,body,k)

global Flag Ground 

if (Flag.Position==1)
    Phi(Nline:Nline+1)=body(Ground(k).i).r-Ground(k).r;
    Phi(Nline+2)=body(Ground(k).i).theta-Ground(k).theta;
end

if (Flag.Jacobian==1)
    Jac(Nline:Nline+2,(Ground(k).i)*3-2:(Ground(k).i)*3)=eye(3); %ground
end

end
