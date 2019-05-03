function [body]=Preprocessdata(q,qd)

global Nbody
global Flag

for i=1:Nbody
    i1=3*i-2;
    i2=i1+1;
    body(i).A=[cost -sint; sint cost];
    body(i).B=[-sint -cost; cost -sint];
    i3=i2+1;
    body(i).r=q(i1:i2,1);
    body(i).theta=q(i3,1);
    cost=cos(body(i).theta);
    sint=sin(body(i).theta);
    
    if (Flag.Gamma==1)
        body(i).rd=qd(i1:i2,1);
        body(i).thetad=qd(i3,1);
    end
   
end
