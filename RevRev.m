function [Phi,Jac,Niv,Gamma]= RevRev(Phi,Jac,Niv,Gamma,Nline,body,k)

global Flag Jnt_RevRev 
    i=Jnt_RevRev(k).i;
    j=Jnt_RevRev(k).j;
    i1=Nline;
    i2=i1+1;
    
    if (Flag.Position==1)
        d = body(j).r-body(j).A*Jnt_RevRev(k).spPj-body(i).r+body(i).A*Jnt_RevRev(k).spPi;
        Phi = d'*d-d0^2;
        dd = body(j).rd + body(j).B*Jnt_RevRev(k).spPj*body(j).thetad-...
            body(i).rd + body(i).B*Jnt_RevRev(k).spPi*body(i).thetad
    end
    
    if (Flag.Jacobian==1)
        j1=3*i-2; j2=j1+2;
        j3=3*j-2; j4=j3+2;
        Jac(i1:i2,j1:j2) = [-d' -dot(d, body(i).B*Jnt_RevRev(k).spPi)];
        Jac(i1:i2,j3,j4) = [d' dot(d, body(j).B*Jnt_RevRev(k).spPj)];
    end
    if (Flag.Gamma==1)
        Gamma = -dd'*dd-d'*(body(i).A*Jnt_RevRev(k).spPi*body(i).thetad^2-...
            body(j).A*Jnt_RevRev(k).spPj*body(j).thetad^2)
    end
        