clear all
global q  Jac tstart tstep tend time qd qdd q0 q00 body0 Flag 

%comment to suppress warning about "variable is changing size every
%iteration
%#ok<*SAGROW>

% Filename='rameurrevrev.rtf';

Readinputdata

q00=q0;
Flag.Position = 0;
Flag.Jacobian = 0;
Flag.Niu=0;
Flag.Gamma=0;
[body0]=Preprocessdata(q0,qd);

Readinputdata

k = 0;
for time = tstart : tstep : tend
k = k + 1;
 
%... Position Analysis
[q ] = PositionAnalysis(q0,time);

%... Velocity Analysis
[qd,Jac] = VelocityAnalysis(q,time);

% %... Acceleration Analysis
[qdd ] = AccelerationAnalysis(q,qd,Jac,time);
% %
% %... Store variables for reporting
 t(k)= time;

Positions(:,k) = q; 
Velocities(:,k) = qd;
Accelerations(:,k) = qdd;

%... Estimation of positions for next time step
q0=q+ 0.9*(qd*tstep+ qdd*tstep.^2/2);
end 

Animate

