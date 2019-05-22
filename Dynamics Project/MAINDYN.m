clear all
global tspan body Nbody Ncoord 

Filename='4bardyn.rtf';

Readinputdata

% Vector with initial conditions y0
y0=q2y(body,Nbody);

[t,y]=ode45(@FuncEval,tspan,y0);

for k=1:size(tspan,2)
    Positions(:,k)=y(k,1:Ncoord);
    Velocities(:,k)=y(k,Ncoord+1:2*Ncoord);
end

Animate;


