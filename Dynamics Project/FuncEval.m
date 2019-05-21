function [yd] = FuncEval(t,y)

%   Accessing memory
global body Nbody Gravity Spr_Damper Flag
global Nsprdampers Force_applied Napplforces Ncoord

%   Updating local information
[body] = y2Body(y,body,Nbody);

%   Mass matrix
[Mass] = MakeMassMatrix(body,Nbody);

%   Force vector
[g] = MakeForceVector(body,Spr_Damper,Nsprdampers,...
    Force_applied,Napplforces);

%   Jacobian Matrix and acceleration equations
Flag.Position=0;
Flag.Jacobian=1;
Flag.Velocity=0;
Flag.Acceleration=1;
[~,Jac,~,Gamma]=KinematicConstraints(body,t);

%   Leading matrix and vector of equations of motion
Mass=[M, Jac'; Jac, zeros(Nconstraints,Nconstraints)];
Force=[g;Gamma];

%   Solving system of equations to get accelerations and Lagrange multipliers
b=Mass\Force;

%   Forming the auxiliary vector yd
yd=[y(Ncoord+1:2*Ncoord);b(1:Ncoord)];

end




