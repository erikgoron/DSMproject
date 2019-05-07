%clear all
%load('joints_bodiesLR');
load('jb_v4.mat')
% load('bodies_L_at_pi_2_rad.mat');
% load('bodies_R_at_pi_2_rad.mat');

%model Parameters
jointPos=-5.11; % -5.11
leg2length=47.08; %47.08;
bodies.Size(2)=leg2length;
bodies.Size(2+12)=leg2length;

Nbody=size(bodies,1);
Nrev=size(joints,1);


jmat=zeros(Nrev,6);
for k=1:Nrev
    b1=joints.b1(k);
    b2=joints.b2(k);
    
    sz=bodies.Size(b1);
    loc=joints.b1_jloc(k);
    if loc==0 %left \xi negative
        b1_loc=-sz/2;
    elseif loc==1 %right, \xi positive
        b1_loc=sz/2;
    elseif loc==2
        b1_loc=jointPos;
    else
        error('joint1');
    end
    
    
    sz=bodies.Size(b2);
    loc=joints.b2_jloc(k);
    if loc==0 %left \xi negative
        b2_loc=-sz/2;
    elseif loc==1 %right, \xi positive
        b2_loc=sz/2;
    elseif loc==3
        b2_loc=3/2*sz;
    else
        error('joint2');
    end
    
    
    jmat(k,:)=[b1,b2,b1_loc,0,b2_loc,0];
    
         
end
%bodies.X0=-bodies.X0;
%bodies.Phi0=pi-bodies.Phi0;
%bodies.Phi0=round(bodies.Phi0*2*pi/180,3);


bvar=bodies.Variables;
bodiesmat=bvar(:,2:4);

Nground=4;
Ndriver=2;
Npointsint=2;
Nrevrev=0;
l1=[Nbody,Nrev,0,Nrevrev,0,Nground,0,Ndriver,Npointsint];
ground= [12,bodies.X0(12),0,0;...
         24,bodies.X0(24),0,pi;
         12+25,bodies.X0(12+25),0,0;...
         24+25,bodies.X0(24+25),0,pi];%[12,0,0,pi];
drivers=[11,3,bodies.Phi0(11),0.17,0;
        36,3,bodies.Phi0(36),0.17,0;];%10/360*2*pi
POI=[1,-bodies.Size(1)/2,0;
    13,-bodies.Size(1)/2,0];
timeseries=[0,36,1];



csvwrite('l1.csv',l1);
csvwrite('body_input.csv',bodiesmat);
csvwrite('joints_input.csv',jmat);
csvwrite('grounds.csv',ground);
csvwrite('drivers.csv',drivers);
csvwrite('POI.csv',POI);
csvwrite('timeseries.csv',timeseries);
tempfiles={'l1.csv','body_input.csv','joints_input.csv',...
    'grounds.csv','drivers.csv','POI.csv','timeseries.csv'};
Filename='strandbeest_v4.rtf';

system(['copy /b ',strjoin(tempfiles,'+'),' ',Filename]);
system(['del ',strjoin(tempfiles,' ')]);


Readinputdata
PlotInitialPos2


    