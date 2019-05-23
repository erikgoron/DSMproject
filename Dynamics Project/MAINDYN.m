clear all
global tspan body Nbody Ncoord

% Filename='4bardyn.rtf';
Filename='test1.DAP.rtf';
Filename='strandbeestDAP_v3.2.rtf';
ReadInputDAP

% Vector with initial conditions y0
y0=q2y(body,Nbody);
 options = odeset('RelTol',5e-2,'Stats','on');
 options=odeset();
[t,y]=ode45(@FuncEval,tspan,y0,options);

for k=1:size(tspan,2)
    Positions(:,k)=y(k,1:Ncoord);
    Velocities(:,k)=y(k,Ncoord+1:2*Ncoord);
    lambda(:,k)=getLambdas(tspan(k),y(k,:)');
end



Animate;


