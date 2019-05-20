function [g] = ForceSpringDamperActuator(g, Body, Spr_Damper, Nsprdampers)

% for each spring-damper-actuator
for k=1:Nsprdampers
    i = Spr_Damper(k).i;
    j = Spr_Damper(k).j;
    
   % Calculate vector d
   d = Body(i).r+Body(i).A*Spr_Damper(k).spPi-...
       Body(j).r+Body(j).A*Spr_Damper(k).spPj;
   l = sqrt(dot(d,d));
   u = d/l;
   dd = Body(i).rd+Body(i).B*Spr_Damper(k).spPi*Body(i).thetad-...
        Body(j).rd+Body(j).B*Spr_Damper(k).spPj*Body(j).thetad;
   ld = -dot(dd,u);
   
   % Force contributions
   fk = Spr_Damper(k).k*(Spr_Damper(k).l0-l);
   fd = Spr_Damper(k).c*ld;
   fa = Spr_Damper(k).a;
   f = (fk+fd+fa)*u;

   % Apply spring-damper-actuator force to bodies i & j
   [g] = ApplyForce(g,f,Spr_Damper(k).spPi,Body,i);
   [g] = ApplyForce(g,-f,Spr_Damper(k).spPj,Body,j)
end
 
end