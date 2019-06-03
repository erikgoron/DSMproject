clear all
addpath 'Dynamics Project'
%load('joints_bodiesLR');
load('jb_v4.4.1.mat')
% load('bodies_L_at_pi_2_rad.mat');
% load('bodies_R_at_pi_2_rad.mat');

%model Parameters
jointPos=-5.11; % -5.11
leg2length=47.08; %47.08;
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
    elseif loc>1
        assert(b2==47,'oops wrong b2_jloc');
        a=[-20.91-95,-95,-85,-85+20.91];
        loc48(3:10)=[a,-a];
        b2_loc=loc48(loc);
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



ground= [47,bodies.X0(47),0,0];%[12,0,0,pi];
drivers=[11,3,bodies.Phi0(11),0.17,0;
        34,3,bodies.Phi0(34),0.17,0;];%10/360*2*pid
drivers=[];
POI=[1,-bodies.Size(1)/2,0;
    13,-bodies.Size(1)/2,0];
timeseries=[0,0,1];

Nground=size(ground,1);
Ndriver=size(drivers,1);
Npointsint=size(POI,1);
Nrevrev=0;
Nsimple=0;

l1=[Nbody,Nrev,0,Nrevrev,0,Nground,0,Ndriver,Npointsint];

csvwrite('l1.csv',l1);
csvwrite('body_input.csv',bodiesmat);
csvwrite('joints_input.csv',jmat);
csvwrite('grounds.csv',ground);
csvwrite('drivers.csv',drivers);
csvwrite('POI.csv',POI);
csvwrite('timeseries.csv',timeseries);
tempfiles={'l1.csv','body_input.csv','joints_input.csv',...
    'grounds.csv','drivers.csv','POI.csv','timeseries.csv'};
Filename='strandbeest_v4.4KAP.rtf';

system(['copy /b ',strjoin(tempfiles,'+'),' ',Filename]);
system(['del ',strjoin(tempfiles,' ')]);


ReadinputKAP
PlotInitialPos2


    