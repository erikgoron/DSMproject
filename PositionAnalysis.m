function    [q     ] = PositionAnalysis(q0,time)
%POSITION ANALYSIS Function to control the position analysis of
%                  the mechanical system using the Newton-Raphson
% method to solve the position constraint equations %%
%... Access the global variables
global NRparameters Flag 

options = optimoptions('fsolve','FunctionTolerance',1e-2,'Display','none');

[q,fval,exitflag]=fsolve(@PhiEval,q0,options);

assert(exitflag>=1,'Fsolve did not converge, check again with options "display" on');
