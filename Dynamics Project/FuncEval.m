function [yd] = FuncEval(t,y)

%   Accessing memory
global body Nbody  Flag alpha beta 
global  Ncoord Nconst 

%   Updating local information
[body] = y2Body(y,body,Nbody);

%   Mass matrix
[M] = MakeMassMatrix(body,Nbody);

%   Force vector
[g] = MakeForceVector(body);

%   Jacobian Matrix and acceleration equations
Flag.Position=1;
Flag.Jacobian=1;
Flag.Velocity=0;
Flag.Gamma=1;
Flag.Niu=0;
[Phi,Jac,Niu,Gamma]=KinematicConstraints(body,t);

%   Leading matrix and vector of equations of motion
Mass=[M, Jac'; Jac, zeros(Nconst,Nconst)];
Force=[g;Gamma-2*alpha*(Jac*y(Ncoord+1:2*Ncoord)-Niu)-beta^2*Phi];  
%   Solving system of equations to get accelerations and Lagrange multipliers
b=Mass\Force;

%   Forming the auxiliary vector yd
yd=[y(Ncoord+1:2*Ncoord);b(1:Ncoord)];

end




