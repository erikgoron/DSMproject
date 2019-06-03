function [Phi,Jac,Niv,Gamma]= RevRev(Phi,Jac,Niv,Gamma,Nline,body,k)

global Flag Jnt_RevRev body0
    i=Jnt_RevRev(k).i;
    j=Jnt_RevRev(k).j;
    i1=Nline;
    
    if (Flag.Position==1 || Flag.Jacobian==1 || Flag.Gamma==1)
        d = body(j).r+body(j).A*Jnt_RevRev(k).spPj-body(i).r-...
            body(i).A*Jnt_RevRev(k).spPi;
        d0= norm(body0(j).r+body0(j).A*Jnt_RevRev(k).spPj-body0(i).r-...
            body0(i).A*Jnt_RevRev(k).spPi);
    end
    
    if (Flag.Position==1)
        Phi(Nline,1) = dot(d,d)-d0^2;
    end
    
    if (Flag.Jacobian==1)
        j1=3*i-2; j2=j1+2;
        j3=3*j-2; j4=j3+2;
        Jac(i1,j1:j2) = [-d' -dot(d, body(i).B*Jnt_RevRev(k).spPi)];
        Jac(i1,j3:j4) = [d' dot(d, body(j).B*Jnt_RevRev(k).spPj)];
    end
    
    if (Flag.Gamma==1)
        dd = body(j).rd + body(j).B*Jnt_RevRev(k).spPj*body(j).thetad-...
            body(i).rd - body(i).B*Jnt_RevRev(k).spPi*body(i).thetad;
        Gamma(Nline,1) = -dot(dd,dd)-dot(d,body(i).A*Jnt_RevRev(k).spPi*body(i).thetad^2-...
            body(j).A*Jnt_RevRev(k).spPj*body(j).thetad^2);
    end
        