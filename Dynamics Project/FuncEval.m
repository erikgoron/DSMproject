function [yd] = FuncEval(t,y)

%   Accessing memory
global Body NBodies Gravity Spr_Damper
global Nsprdampers Force_applied Napplforces

%   Updating local information
[Body] = y2Body(y,Body,NBodies);

%   Mass matrix
[Mass] = MakeMassMatrix(Body,NBodies);

%   Force vector
[g] = MakeForceVector(Body,Spr_Damper,Nsprdampers,...
    Force_applied,Napplforces);

%   Jacobian Matrix and acceleration equations
Flag.Position=0;
Flag.Jacobian=1;
Flag.Velocity=0;
Flag.Acceleration=1;
[~,Jac,~,Gamma]=MakeJacobianGamma();

%   Leading matrix and vector of equations of motion
Mass=[M, Jac'; Jac, zeros(Nconstraints,Nconstraints)];
Force=[g;Gamma]

%   Solving system of equations to get accelerations and Lagrange multipliers
b=Mass\Force;

%   Forming the auxiliary vector yd
yd=[y(Ncoord+1:2*Ncoord);b(1:Ncoord)];

end




