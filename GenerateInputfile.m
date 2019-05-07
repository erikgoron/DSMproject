clear all
load('joints_bodies');
Nbody=size(bodies,1);
Nrev=size(joints,1);

jmat=zeros(Nrev,6);
for k=1:16
    jmat(k,1)=joints.b1(k);
    jmat(k,2)=joints.b2(k);
    if joints.b1_jloc(k)==0
        b1_loc=bodies.P_left(joints.b1(k));
    elseif joints.b1_jloc(k)==1
        b1_loc=-bodies.P_left(joints.b1(k));
    else
        b1_loc=-5.11;
    end
    jmat(k,3)=b1_loc;
    
    if joints.b2_jloc(k)==0
        b2_loc=bodies.P_left(joints.b2(k));
    elseif joints.b2_jloc(k)==1
        b2_loc=-bodies.P_left(joints.b2(k));
    end
    jmat(k,5)=b2_loc;
    
         
end
bodies.X0=bodies.X0-30;
bvar=bodies.Variables;

bvar(:,4)=round(bvar(:,4)*2*pi/360,3);
bodiesmat=bvar(:,2:4);
Nground=1;
Ndriver=1;
l1=[Nbody,Nrev,0,0,0,Nground,0,Ndriver,0];

% zeros(sum(l1),9);
% line=1;
% bigmat(line,1:9)=l1;
% line=line+1;
% bigmat(line:(line+Nbody-1),1:3)=bodiesmat;
% line=line+Nbody;
% bigmat(line:(line+Nrev-1),1:6)=jmat;
% line=line+Nrev;
% ground, driver, time

ground= [12,-30,0,0];
drivers=[11,3,1.3963,pi,0];
timeseries=[0,2,0.105];

%csvwrite('input1-rev.csv',bigmat);

csvwrite('l1.csv',l1);
csvwrite('body_input.csv',bodiesmat);
csvwrite('joints_input.csv',jmat);
csvwrite('grounds.csv',ground);
csvwrite('drivers.csv',drivers);
csvwrite('timeseries.csv',timeseries);
tempfiles={'l1.csv','body_input.csv','joints_input.csv',...
    'grounds.csv','drivers.csv','timeseries.csv'};
system(['copy /b ',strjoin(tempfiles,'+'),' strandbeest_v2.rtf']);
system(['del ',strjoin(tempfiles,' ')]);


    