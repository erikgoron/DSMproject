function [Phi,Jac,Niu,Gamma] = driver(Phi,Jac,Niu,Gamma,Nline,body,k,time)

global Driver Flag 
z=[];
z(1)=body(Driver(k).i).r(1);
z(2)=body(Driver(k).i).r(2);
z(3)=body(Driver(k).i).theta;

if (Flag.Position==1)
   Phi(Nline,1)=z(Driver(k).coord)-Driver(k).pos-Driver(k).vel*time-0.5*time^2*Driver(k).acc;
end

if (Flag.Jacobian==1)
    Jac(Nline,Driver(k).i*3+Driver(k).coord-3)=1;
end

if (Flag.Gamma==1)
    Gamma(Nline,1)=Driver(k).vel+Driver(k).acc*time;
end

if (Flag.Niu == 1)
    Niu(Nline,1)=Driver(k).acc;
end
end