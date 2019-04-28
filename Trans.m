function [Phi,Jac,Niv,Gamma]=Trans(Phi,Jac,Niv,Gamma,Nline,body,k)

global Jnt_trans Flag
i=Jnt_trans(k).i;
j=Jnt_trans(k).j;
i1=Nline
i2=i1+1;

if (Flag.Position==1 || Flag.Jacobian==1 || Flag.Gamma==1)
    si=body(i).A*Jnt_trans(k).spi;
    sij=body(i).r+body(i).A*Jnt_trans(k).spPi...
        -body(j).r-body(j).A*Jnt_trans(k).spPj;
    hj=body(j).A*Jnt_trans(k).hj;
  
end

if (Flag.Position==1)
    Phi(i1:i2,1)=[dot(hj,si);...
        dot(hj,sij)];
end

if (Flag.Jacobian==1)
    j1=3*i-2;j2=j1+2; j3=3*j-2; j4=j3+2;
    aux=dot(sij,body(j).B*Jnt_trans(k).hj)-dot(hj,body(j).B*Jnt_trans(k).spPj);
    Jac(i1:i2,j1:j2)=[0 0 dot(hj,body(i).B*Jnt_trans(k).spi);...
        hj' dot(hj,body(i).B*Jnt_trans(k).spPi)];
    Jac(i1:i2,j3:j4)=[0 0 dot(si,body(j).B*Jnt_trans(k).hj);...
        -hj' aux];
end

% if (Flag.Gamma==1)
%     Gamma(i1:i2,1)=
    

    