function [qd,Jac] = VelocityAnalysis(q,time)
%VELOCITY ANALYSIS Function to control the velocity analysis of
% the mechanical system

%... Access the global variables
global Flag body 
Preprocessdata(q)

%... Evaluate the Jacobian matrix and right-hand-side of velocity equations Flags.Position = 0;
Flag.Jacobian = 1;
Flag.Niu = 1;

[~,Jac,Niu,~] = KinematicConstraints(body,time);
%
%... Obtain the system velocities
qd = Jac\Niu;
%... Finish function
end
       