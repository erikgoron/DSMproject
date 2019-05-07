function [Phi,Jac] = PhiJacEval(q)
%PHIEVAL returns the Position Constraint function result
%   Detailed explanation goes here
global time Flag
Flag.Position = 1;
Flag.Jacobian = 0;
Flag.Niu=0;
Flag.Gamma=0;

body = Preprocessdata(q,false); 

[Phi,~,~,~] = KinematicConstraints(body,time);

Flag.Position = 0;
Flag.Jacobian = 1;
Flag.Niu=0;
Flag.Gamma=0;


[~,Jac,~,~] = KinematicConstraints(body,time);


end

