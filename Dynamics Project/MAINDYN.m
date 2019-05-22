clear all
global tspan body Nbody

Filename='4bardyn.rtf';

Readinputdata

% Vector with initial conditions y0
y0=q2y(body,Nbody);

[t,y]=ode45(@FuncEval,tspan,y0);

%Post process data and report

