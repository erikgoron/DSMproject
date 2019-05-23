%clear all
addpath nogit
% load('joints_bodies');
%load('jb_v3.2.mat')
%load('bodies_L_at_pi_2_rad.mat');
% load('bodies_R_at_pi_2_rad.mat');

%model Parameters
% jointPos=-5.11; % -5.11
% leg2length=47.08; %47.08;
% bodies.Size(2)=leg2length;
%bodies.Size(2+12)=leg2length;

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

Nground=1;
Ndriver=1;
Npointsint=0;
Ntran=0;
Nrevrev=0;
%Nrev=Nrev-Nrevrev;
Nrevtran=1;
Nsimple=0;
l1=[Nbody,Nrev,Ntran,Nrevrev,Nrevtran,Nground,Nsimple,Ndriver,Npointsint];
revtran=[2,3,1,0,1.5,0,1.118,0];
ground= [2,1,0,0];
drivers=[1,3,bodies.Phi0(1),pi/18,0];
simple=[];
POI=[];
timeseries=[0,36,1];



csvwrite('l1.csv',l1);
csvwrite('body_input.csv',bodiesmat);
csvwrite('joints_input.csv',jmat);
csvwrite('revtran.csv',revtran);
csvwrite('grounds.csv',ground);
csvwrite('drivers.csv',drivers);
csvwrite('simple.csv',simple);
csvwrite('POI.csv',POI);
csvwrite('timeseries.csv',timeseries);
tempfiles={'l1.csv','body_input.csv','joints_input.csv','revtran.csv',...
    'grounds.csv','drivers.csv','simple.csv','POI.csv','timeseries.csv'};
Filename='test_2.rtf';

system(['copy /b ',strjoin(tempfiles,'+'),' ',Filename]);
system(['del ',strjoin(tempfiles,' ')]);



Readinputdata
PlotInitialPos2


    