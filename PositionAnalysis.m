function    [q     ] = PositionAnalysis(q0,time)
%POSITION ANALYSIS Function to control the position analysis of
%                  the mechanical system using the Newton-Raphson
% method to solve the position constraint equations %%
%... Access the global variables
global NRparameters Flag 

options = optimoptions('fsolve','FunctionTolerance',2e-1,'Display','none',...
    'SpecifyObjectiveGradient',true,'OptimalityTolerance',1e-4);

[q,fval,exitflag]=fsolve(@PhiJacEval,q0,options);

assert(exitflag>=1,'Fsolve did not converge, check again with options "display" on');
