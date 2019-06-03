function [g]= ForceContact(g,body,Contactforce,Ncontactforces)


% v0=0.01;
% v0ff=0.01;
% n=1.3;
% ce=0.01;
% cf=0.2;

%smoothing length
dy0=5e-4;

for k=1:Ncontactforces
i=Contactforce(k).i;


spPi=Contactforce(k).spi;
groundY=Contactforce(k).y;
kc=Contactforce(k).k;
c=Contactforce(k).c;

cPi = body(i).r+body(i).A*spPi;
cPid= body(i).rd+ body(i).B*spPi*body(i).thetad;

%interference
dy=groundY-cPi(2);
%velocity y
ddy=-cPid(2);
%velocity x
ddx=cPid(1);

if dy>0
%     if ddy<=-v0
%         fn=ce*kc*dy^n;
%     elseif ddy>-v0 &&ddy<v0
%         r=ddy/v0;
%         fn=ce+(1-ce)*(3*r^2-2*r^3);
%     elseif ddy>=v0
%         fn=kc*dy^n;
%     end
    
%        c_smooth=1-exp(-3*norm(ddx)/v0ff);
%     ffri=-c_smooth*c*fn*sign(ddx);

    
 %normal force
    fn=kc*dy+(c*ddy)*(1-exp(-dy/dy0));
 %friction force
    ffri=-c*ddx*(1-exp(-dy/dy0));


    f=[ffri;fn];
    
   [g] = ApplyForce(g,f,0,spPi,body,i);
  
else
    continue
end
end

end
