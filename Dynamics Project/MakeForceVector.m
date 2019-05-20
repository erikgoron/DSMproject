function [g] = MakeForceVector
global Body NBodies Spr_Damper Nsprdampers

% Gravity force
[g] = ForceGravity(Body, NBodies, grav, Ncoord);
% Spring-damper-actuator forces
[g] = ForceSpringDamperActuator(g, Body, Spr_Damper, Nsprdampers);

% %Contact forces
% [g] = ForceContact(g, Body, Contact,...):
% 
% % Tire contact force
% [g] = ForceTire(g, Body, Tire,...):

% External applied forces
[g] = ForceExternal(g, Force_applied, Napplforces);

end

