function [g] = MakeForceVector(body)
global Nbody Spr_Damper Nsprdampers Ncoord  Force_applied Napplforces
global  Gravity 
[g] = ForceGravity(body, Nbody, Gravity, Ncoord);
% Spring-damper-actuator forces
[g] = ForceSpringDamperActuator(g, body, Spr_Damper, Nsprdampers);

% %Contact forces
[g] = ForceContact(g, Body, Contact,...):
% 
% % Tire contact force
% [g] = ForceTire(g, Body, Tire,...):

% External applied forces
[g] = ForceExternal(g, Force_applied, Napplforces);

end

