function [g]= ForceContact(g,body,Contactforce,Ncontactforce)


k=1;
i=Contactforce(k).i;


spPi=Contactforce(k).spPi';
groundY=Contactforce(k).y;
k=Contactforce(k).k;
c=Contactforce(k).c;

v0=50;


cPi = body(i).r+body(i).A*spPi;
cPid= body(i).rd+ body(i).B*spPi*body(i).thetad;

d=groundY-cPi(2);
ddy=cPid(2);
ddx=cPid(1);

if d>0
    fn=k*d-v0*ddy;
    fn=max(fn,0);
    ffri=-Contactforce(k).c*fn*sign(ddx);
    f=[ffri;fn];
    
   [g] = ApplyForce(g,f,spPi,body,i);
  
else
    return
end


end
