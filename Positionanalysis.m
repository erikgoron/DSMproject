function    [q     ] = Positionanalysis(q,time)
%POSITION ANALYSIS Function to control the position analysis of
%                  the mechanical system using the Newton-Raphson
% method to solve the position constraint equations %%
%... Access the global variables
global NRparameters Flag Phi Jac body 

%... Setup a very large initial error
error = 10.0*NRparameters.tolerance;

%... Initialize the iteration counter
k =0;

%... Start the iterative procedure (Newton-Raphson Method)
while (error >= NRparameters.tolerance)
k = k+1;

%... Evaluate the Position Constraint Equations
Flag.Position = 1;
Flag.Jacobian = 0;
Flag.Niv=0;
Flag.Gamma=0;

Preprocessdata(q); 

[Phi,~,~,~] = KinematicConstraints(body,time);

%... Evaluate the Jacobian matrix
    Flag.Position = 0;
    Flag.Jacobian = 1;
    [~,Jac,~,~]    = KinematicConstraints(body,time);

%... Calculate the iteration step
    deltaq         = Jac\Phi;

%... Update positions
q = q-deltaq;

%... Evaluate the error function
    error = max(abs(deltaq));
    
%... Check if the maximum number of iterations is exceeded
    if (k>NRparameters.MaxIteration)
        formatSpec = 'Iterations ( %d ) exceeds maximum ( %d )';
        fprintf(formatSpec,k,NRparameters.MaxIteration);
        break
    end
end

