clear all
global   

%comment to suppress warning about "variable is changing size every
%iteration
%#ok<*SAGROW>


% Filename='rameurrevtrans.rtf';
% Filename='strandbeest_v4.rtf';

Readinputdata
InitialData

% Vector with initial conditions y0
y0=q2y(body,NBody);

[t,y]=ode45(@FuncEval,tspan,y0);

%Post process data and report

