if not(exist('Filename','var'))
    Filename= uigetfile('*.kap','Select Model');
end

%read data from input file
H=dlmread(Filename);

% store in vars
line=1;
NBody=H(1,1);
NRevolute=H(1,2);
NTranslation=H(1,3);

if useCompositeJoints
    NRevRev=0;
    NRevTra=0;
    NGround=H(1,4);
    NSimple=H(1,5);
    NDriver=H(1,6);
    NPointsInt=H(1,7);
else
    NRevRev=H(1,4);
    NRevTra=H(1,5);
    NGround=H(1,6);
    NSimple=H(1,7);
    NDriver=H(1,8);
    NPointsInt=H(1,9);
end

% Initial Positions
for i=1:NBody
    line=line+1;
    Body(i).r=H(line,1:2);
    Body(i).phi=H(line,3);
end
%revolute joints
for k=1:NRevolute
    line=line+1;
    Jnt_Rev(k).i=H(line,1);
    Jnt_Rev(k).j=H(line,2);
    Jnt_Rev(k).spPi=H(line,3:4);
    Jnt_Rev(k).spPj=H(line,5:6);
end
%translation joints
for k=1:NTranslation
    line=line+1;
    Jnt_Translation(k).i=H(line,1);
    Jnt_Translation(k).j=H(line,2);
    Jnt_Translation(k).spPi=H(line,3:4);
    Jnt_Translation(k).spQi=H(line,5:6);
    Jnt_Translation(k).spPj=H(line,7:8);
    %Jnt_Translation(k).spQj=H(line,9:10);
end

%TO DO
%RevRev joints
for k=1:NRevRev
    line=line+1;
%     Jnt_RevRev(k).i=H(line,1);
%     Jnt_RevRev(k).j=H(line,2);
%     Jnt_RevRev(k).spPi=H(line,3:4);
%     Jnt_RevRev(k).spPj=H(line,7:8);
%     Jnt_RevRev(k).spQj=H(line,9:10);
end
%RevTra joints
for k=1:NRevTra
    line=line+1;
%     Jnt_RevTra(k).i=H(line,1);
%     Jnt_RevTra(k).j=H(line,2);
%     Jnt_RevTra(k).spPi=H(line,3:4);
%     Jnt_RevTra(k).spPj=H(line,7:8);
%     Jnt_RevTra(k).spQj=H(line,9:10);
end

%Grounded bodies
for k=1:NGround
    line=line+1;
    Ground(k).i=H(line,1);
end

%TO DO simple contstraints
for k=1:NSimple
    line=line+1;
    %Simple constraints here
end
%Drivers
for k=1:NDriver
    line=line+1;
    Driver(k).i=H(line,1);%body i
    Driver(k).coord=H(line,2);%1:X,2:Y,3:PHI
    Driver(k).pos=H(line,3);%initial position
    Driver(k).vel=H(line,4);%velocity
    Driver(k).acc=H(line,5);%acceleration
end

%Points of interest

for k=1:NPointsInt
    line=line+1;
    POI(k).i=H(line,1);
    POI(k).spP=H(line,2:3);
end

line=line+1;
%Define the Timeseries=tstart:tstep:tend
tstart=H(line,1);
tend=H(line,2);
tstep=H(line,3);
tseries=tstart:tstep:tend;
 


