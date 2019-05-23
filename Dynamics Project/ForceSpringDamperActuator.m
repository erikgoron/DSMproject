function [g] = ForceSpringDamperActuator(g, body, Spr_Damper, Nsprdampers)

global ld
% for each spring-damper-actuator
for k=1:Nsprdampers
    i = Spr_Damper(k).i;
    j = Spr_Damper(k).j;
    
   % Calculate vector d
   d = body(i).r+body(i).A*Spr_Damper(k).spPi-...
       body(j).r-body(j).A*Spr_Damper(k).spPj;
   l = sqrt(dot(d,d));
   u = d/l;
   dd = body(i).rd+body(i).B*Spr_Damper(k).spPi*body(i).thetad-...
        body(j).rd-body(j).B*Spr_Damper(k).spPj*body(j).thetad;
   ld = -dot(dd,u);
   
   % Force contributions
   fk = Spr_Damper(k).k*(Spr_Damper(k).l0-l);
   fd = Spr_Damper(k).c*ld;
   fa = Spr_Damper(k).a;
   f = (fk+fd+fa)*u;

   % Apply spring-damper-actuator force to bodies i & j
   [g] = ApplyForce(g,f,Spr_Damper(k).spPi,body,i);
   [g] = ApplyForce(g,-f,Spr_Damper(k).spPj,body,j);
end
 
end