function [g]= ForceContact(g,body,ContactGround,Ncontactground)
i=1;
spPi=[1,0]';
groundY=0;
k=1000;
c=50;

B=[0 -1;1 0];

cPi = body(i).r+body(i).A*spPi;
cPid= body(i).rd+ body(i).B*spPi*body(i).thetad;

d=groundY-cPi(2);
dd=cPid(2);
ddx=cPid(1);

if d>0
    f=[-c*ddx ;k*d-c*dd];
   [g] = ApplyForce(g,f,spPi,body,i);
  
else
    return
end


end
