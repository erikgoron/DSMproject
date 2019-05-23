clear all
addpath nogit
%load('joints_bodies');
load('jb_v3.2.mat')
load('iposvel_v3.2.mat')
%load('bodies_L_at_pi_2_rad.mat');
% load('bodies_R_at_pi_2_rad.mat');

%model Parameters
linDens=1; %linear density of the bars


jointPos=-5.11; % -5.11



% leg2length=47.08; %47.08;
% bodies.Size(2)=leg2length;
% bodies.Size(2+12)=leg2length;

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


% bvar=bodies.Variables;
% bodiesmat=bvar(:,2:4);

for i=1:Nbody
    L=bodies.Size(i);
    m(i)=L*linDens;
    I(i)=m(i)*L^2/12;
end
bodiesmat=[ipos,m',I'];

bodiesmat(1:Nbody,4:6)=0;

% jmat(jmat(:,1)==25,:)=[];
% jmat(jmat(:,2)==25,:)=[];
% Nrev=size(jmat,1);
% bodiesmat=bodiesmat(1:24,:);
% Nbody=size(bodiesmat,1);


ground=[]; %[12,bodies.X0(12),0,0;
%     24,bodies.X0(24),0,bodies.Phi0(24);];%[12,bodies.X0(12),0,0;];%[12,0,0,pi];
drivers=[];%[11,3,bodies.Phi0(11),0.17,0;];%10/360*2*pi
simple=[];
POI=[1,-bodies.Size(1)/2,0;...
    13,-bodies.Size(13)/2,0;];
forces=[];
springs=[];
contactforce=[1,-bodies.Size(1)/2,-60,100,50
            13,-bodies.Size(13)/2,-60,100,50];

gravity=[9.81,0,-1];
integra=[1,0]; %alpha, beta

Nground=size(ground,1);
Ndriver=size(drivers,1);
Npointsint=size(POI,1);
Nrevrev=0;
Nsimple=0;
Napplforces=size(forces,1);
Nsprdampers=size(springs,1);
Ncontactforces=size(contactforce,1);
% 1.NBody, NRevolute, NTranslation, NRev-Rev, NRev-Tra, Nground, NSimple,
%          Ndriver,NPoints,Nappliedforces,Nspring/damp/actuat 
l1=[Nbody,Nrev,0,Nrevrev,0,Nground,Nsimple,...
    Ndriver,Npointsint,Napplforces,Nsprdampers,Ncontactforces];
timeseries=[0,5,0.05];



csvwrite('l1.csv',l1);
csvwrite('body_input.csv',bodiesmat);
csvwrite('joints_input.csv',jmat);
csvwrite('grounds.csv',ground);
csvwrite('drivers.csv',drivers);
csvwrite('simple.csv',simple);
csvwrite('POI.csv',POI);
csvwrite('forces.csv',forces);
csvwrite('springs.csv',springs);
csvwrite('contactforce.csv',contactforce);
csvwrite('timeseries.csv',timeseries);
csvwrite('gravity.csv',gravity);
csvwrite('integra.csv',integra);
tempfiles={'l1.csv','body_input.csv','joints_input.csv',...
    'grounds.csv','drivers.csv','simple.csv','POI.csv',...
    'forces.csv','springs.csv','contactforce.csv','timeseries.csv','gravity.csv','integra.csv'};
Filename='strandbeestDAP_v3.2.rtf';

system(['copy /b ',strjoin(tempfiles,'+'),' ',Filename]);
system(['del ',strjoin(tempfiles,' ')]);

% 
ReadInputDAP
ground=12;
Ground.i=12;
PlotInitialPos2


    