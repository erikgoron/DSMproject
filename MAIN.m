clear all
global q  Jac tstart tstep tend time qd qdd q0  

%comment to suppress warning about "variable is changing size every
%iteration
%#ok<*SAGROW>

Readinputdata()

k = 0;
for time = tstart : tstep : tend
k = k + 1;
 


%... Position Analysis

[q ] = PositionAnalysis(q0,time);

%... Velocity Analysis
[qd,Jac] = VelocityAnalysis(q0,time);

% %... Acceleration Analysis
[qdd ] = AccelerationAnalysis(q0,Jac,time);
% %
% %... Store variables for reporting
 t(k)= time;

Positions(:,k) = q; 
Velocities(:,k) = qd;
Accelerations(:,k) = qdd;

%... Estimation of positions for next time step
q0 = q;
end 
figure; hold on;
plot (Positions(10,:),Positions(11,:),'ro')
quiver(Positions(7,:),Positions(8,:),Velocities(7,:),Velocities(8,:));
quiver(Positions(7,:),Positions(8,:),Accelerations(7,:),Accelerations(8,:));

