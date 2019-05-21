clear all
global q  Jac tstart tstep tend time qd qdd q0  

%comment to suppress warning about "variable is changing size every
%iteration
%#ok<*SAGROW>


% Filename='rameurrevtrans.rtf';
% Filename='strandbeest_v4.rtf';



Readinputdata
InitialData

% Vector with initial conditions yphi
y0=q2y(Body,NBodies);

[t,y]=ode45(@FuncEval(t,y),tspan,y0);

%Post process data and report

