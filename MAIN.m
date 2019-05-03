clear all
global q  Jac tstart tstep tend time qd qdd q0  

%comment to suppress warning about "variable is changing size every
%iteration
%#ok<*SAGROW>
 %Filename='4bar.rtf';
 Filename='strandbeest_v1.rtf';

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
q0 = q;
end 

Animate

