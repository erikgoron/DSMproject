clear all
global tspan body Nbody

%comment to suppress warning about "variable is changing size every
%iteration
%#ok<*SAGROW>


Filename='4bardyn.rtf';
% Filename='strandbeest_v4.rtf';

Readinputdata


% Vector with initial conditions y0
y0=q2y(body,Nbody);

[t,y]=ode45(@FuncEval,tspan,y0);

%Post process data and report

