function [Phi,Jac,Niu,Gamma]= RevTra(Phi,Jac,Niu,Gamma,Nline,body,k)

global Flag Jnt_RevTra
    i=Jnt_RevTra(k).i;
    j=Jnt_RevTra(k).j;
    i1=Nline;
    i2=i1+1;
    
    if (Flag.Position==1)
        d=body(i).r+body(i).A*Jnt_RevTra(k).spPi-...
            body(j).r-body(j).A*Jnt_RevTra(k).spPj;
        dd = body(i).rd + body(i).B*Jnt_RevTra(k).spPi*body(i).thetad-...
            body(j).rd + body(j).B*Jnt_RevTra(k).spPj*body(j).thetad
        hj=body(j).A*Jnt_RevTra(k).hj;
        Phi=dot(hj,d)-l0;
    end
    
    if (Flag.Jacobian==1)
        j1=3*i-2;j2=j1+2; 
        j3=3*j-2; j4=j3+2;
        Jac(i1:i2,j1:j2) = [hj' -dot(hj, body(i).B*Jnt_RevTra(k).spPi)];
        Jac(i1:i2,j3,j4) = [-hj' dot(d, body(j).B*Jnt_RevTra(k).hj)-...
            dot(hj,body(j).B*Jnt_RevTra(k).spPj)];
    end
    
    if(Flag.Gamma==1)
        Gamma = dot(dd,body(j).B*Jnt_RevTra(k).spPj*body(j).thetad)+...
            dot(d,body(j).A*Jnt_RevTra(k).spPj*body(j).thetad^2)-...
            dot(dd,body(j).B*Jnt_RevTra(k).hj*body(j).thetad)-...
            dot(hj,(body(j).A*Jnt_RevTra(k).spPj*body(j).thetad^2-...
            body(i).A*Jnt_RevTra(k).spPi*body(i).thetad^2));
    end
        
        