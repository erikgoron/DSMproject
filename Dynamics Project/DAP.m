% Construction of a Dynamic Analysis Program (DAP), (class 25)

clear all
%   global variables
global Body NBodies
global

%   Reading input data
[] = ReadInputData();

%   Initializing secondary data
[tspan,Body] = InitializeData();

%   Vector with initial conditions Yphi
Yphi = QZY(Body,NBodies);

%   Calling Matlab function to integrate equations of motion
[t,y] = ode45(@FuncEval(t,y),tspan,Yphi);

%   Postprocess data & results

ReportResults(t,y);

%   End Program

