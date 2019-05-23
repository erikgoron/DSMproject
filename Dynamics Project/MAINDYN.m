clear all
global tspan body Nbody Ncoord

Filename='4bardyn.rtf';

ReadInputDAP

% Vector with initial conditions y0
y0=q2y(body,Nbody);
[t,y]=ode45(@FuncEval,tspan,y0,opts);

for k=1:size(tspan,2)
    Positions(:,k)=y(k,1:Ncoord);
    Velocities(:,k)=y(k,Ncoord+1:2*Ncoord);
    lambda(:,k)=getLambdas(tspan(k),y(k,:)');
end

Njoints = Nrevolute+Nrevrev+Nrevtra+Ntrans;
for i=1:2:2*Njoints
    j = (i+1)/2;
    normlambda(j,:) = sqrt(lambda(i,:).^2+lambda(i+1,:).^2);
    plot(tspan, normlambda(j,:));
    hold on 
end

hold off




% Animate;


