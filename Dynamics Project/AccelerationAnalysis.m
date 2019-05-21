function    [qdd   ] = AccelerationAnalysis(q,qd,Jac,time)
%ACCELERATION ANALYSIS Function to control the acceleration analysis of % the mechanical system
%... Access the global variables
global Flag

%... Evaluate the right-hand-side of acceleration equations
Flag.Jacobian = 0;
Flag.Niu      = 0;
Flag.Gamma    = 1;
body=Preprocessdata(q,qd);
[~,~,~,Gamma]  = KinematicConstraints(body,time);

%... Obtain the system accelerations
qdd = Jac\Gamma;

%... Finish function
end
%gvv
