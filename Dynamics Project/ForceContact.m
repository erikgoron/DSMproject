function [g]= ForceContact(g,body,contact)

global Contactforce 
i=Contactforce(k).i;
j=Contactforce(k).ct;






R=[0 -1;1 0];
ni=[0;-1];
nj=[0;1];
ti=R*ni;


dd=body(i).rd+body(i).B*Contactforce(k).spi*body(i).thetad-...
    body(j).rd+body(j).B*Contactforce(k).spj*body(j).thetad;
ddn=dot(dd,ni);

vt=dd-ddn*ni;

ffri=-Contactforce(k).c*fn*vt/(norm(vt));
