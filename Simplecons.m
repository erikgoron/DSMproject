function [Phi,Jac,Niu,Gamma] = Simplecons(Phi,Jac,Niu,Gamma,Nline,body,k)

global Simple q00

z=[];
z(1)=body(Simple(k).i).r(1);
z(2)=body(Simple(k).i).r(2);
z(3)=body(Simple(k).i).theta;

if (Flag.Position==1)
    Phi(Nline)=z(Simple(k).coord)-q00(3*(Simple(k).i-1)+Simple(k).coord);
  
end

if (Flag.Jacobian==1)
    Jac(Nline,Simple(k).i*3+Simple(k).coord-3)=1; 
end

end
