function [Phi,Jac,Niv,Gamma]= JointRevolute(Phi,Jac,Niv,Gamma,Nline,body,k)

global Flag Jnt_revolute 
    i=Jnt_revolute(k).i;
    j=Jnt_revolute(k).j;
    i1=Nline;
    i2=i1+1;
    
    if (Flag.Position==1)
        Phi(i1:i2,1)=body(i).r+body(i).A*Jnt_revolute(k).spi-body(j).r-body(j).A*Jnt_revolute(k).spj;
    end
    
    if (Flag.Jacobian==1)
        j1=3*i-2; j2=j1+2;
        j3=3*j-2; j4=j3+2;
        Jac(i1:i2,j1:j2)=[eye(2) body(i).B*Jnt_revolute(k).spi];
        Jac(i1:i2,j3:j4)=[-eye(2) -body(j).B*Jnt_revolute(k).spj];
    end
    
    if (Flag.Gamma==1)
        Gamma(i1:i2,1)=body(i).A*Jnt_revolute(k).spi*body(i).thetad^2-body(j).A*Jnt_revolute(k).spi*body(j).thetad^2;
    end
    
end
