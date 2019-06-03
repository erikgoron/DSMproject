clear all
global tspan body Nbody Ncoord



%  Filename='4bardyn.rtf';
% Filename='test2DAP.rtf';
Filename='strandbeestDAP_v4.2.9.rtf';
load('jb_v4.2.8.mat');

ReadInputDAP

% Vector with initial conditions y0
y0=q2y(body,Nbody);
 options = odeset('RelTol',1e-1,'AbsTol',1e-2,'Stats','on','OutputFcn',@myodeprint);
  options=odeset();
[t,y]=ode45(@FuncEval,tspan,y0,options);

for k=1:size(tspan,2)
    Positions(:,k)=y(k,1:Ncoord);
    Velocities(:,k)=y(k,Ncoord+1:2*Ncoord);
    [lambda(:,k),Accelerations(:,k)]=getLambdas(tspan(k),y(k,:)');
end

figure
Njoints = Nrevolute+Nrevrev+Nrevtra+Ntrans;
for i=1:2:2*Njoints
    j = (i+1)/2;
    normlambda(j,:) = sqrt(lambda(i,:).^2+lambda(i+1,:).^2);
    plot(tspan, normlambda(j,:));
    hold on 
end

% hold off

GetPointsOfInterest



Animate2;

% figure
% plot(t,PosPOI(:,2),t,PosPOI(:,4))
% 
% function status=myodeprint(t,y,flagg)
% if strcmp(flagg,'done')
%     status = 0;
%     return
% end
%  body=y2Body(y,[],45);
%  body(11).r
%  t
%  status=0;
% end

% plot(PosPOI(:,5),PosPOI(:,6))
