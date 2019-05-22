% Format of the input for the Dynamic Analysis Program to be developed:
% 1.NBody, NRevolute, NTranslation, NRev-Rev, NRev-Tra, Nground, NSimple,Ndriver,NPoints,Nappliedforces,Nspring/damp/actuat 
% 2.For each Rigid Body:
% Xinit, Yinit, PHIinit, XDinit, YDinit, PHIDinit, Mass,Inertia,
% 3.For each Revolute Joint:
% Body_i, Body_j, XI_P_i, ETA_P_i, XI_P_j, ETA_P_j
% 4.For each Translation Joint:
% Body_i, Body_j, XI_P_i, ETA_P_i, XI_Q_i, ETA_Q_i, XI_P_j, ETA_P_j
% 5.For each Revolute-Revolute Joint:
% Body_i, Body_j, XI_P_i, ETA_P_i, XI_P_j, ETA_P_j
% 6.For each Revolute-Translation Joint:
% Body_i, Body_j, XI_P_i, ETA_P_i, XI_Q_i, ETA_Q_i, XI_P_j, ETA_P_j
% 7.For each Ground Constraint:
% Bodyi, Xi, Yi, PHIi
% 8.For each Simple Constraint:
% Bodyi, Coordinate (use 1 for X, or 2 for Y, or 3 for PHI) 
% 9.For each Driver Constraint:
% BodyNumber, Driven_Coordinate (use 1 for X, or 2 for Y, or 3 for PHI), Position_init, Veloc_init, Accel_init
% 10.For each Point-of-Interest to be reported:
% Body_i, XI_P_i, ETA_P_i
% 12.For each applied force :
% Body i, XI_P_i, ETA_P_i,Force FX,Force FY, Moment M.
% 13.For each Spring/Damp/Acuat :
% Body i,Body j,Spring const, undeformed spring length, Damp. const, Actuator force, XI_P_i, ETA_P_i, XI_P_j, ETA_P_j,
% 14.Starting_time, Final_time, Report_time_increment
% 15.Gravity data:
% Gravity force, Gravity direction: Xgr,Ygr
% 16.Integration data:
% alpha, beta


global  Nbody Nrevolute Ntrans Nrevrev Nrevtra Nground Nsimple Ndriver Npointsint Napplforces Nsprdampers

global Jnt_revolute tend tstart tstep q0 qd0 Jnt_trans Ground Points_int Jnt_RevRev Jnt_RevTra
global Ncoord Nconst tspan Driver body Simple Force_applied Spr_Damper Gravity alpha beta 

if not(exist('Filename','var'))
    Filename= uigetfile('*.rtf','Select Model');
end

%read data from input file
H=dlmread(Filename);
%check if the number of lines is correct
% assert(sum(H(1,:))+4==size(H,1),['number of lines of inputfile is',...
%       'not correct, or there is a mistake in the first line']);
% store in vars
line=1;
Nbody=H(1,1);
Nrevolute=H(1,2);
Ntrans=H(1,3);
Nrevrev=H(1,4);
Nrevtra=H(1,5);
Nground=H(1,6);
Nsimple=H(1,7);
Ndriver=H(1,8);
Npointsint=H(1,9);
Napplforces=H(1,10);
Nsprdampers=H(1,11);
Ncoord=3*Nbody;
Nconst=2*Nrevolute+2*Ntrans+Nrevrev+Nrevtra+...
    3*Nground+Nsimple+Ndriver;

% Initial Positions
q0=[];
q0mat=[];
for i=1:Nbody
    line=line+1;
    body(i).r= H(line,1:2)';
    body(i).theta=  H(line,3);
    body(i).rd= H(line,4:5)';
    body(i).thetad= H(line,6);
    body(i).mass=   H(line,7);
    body(i).J=    H(line,8);
    q0=[q0;H(line,1:3)'];
    qd0=[qd0;H(line,4:6)'];
    q0mat=[q0mat;H(line,1:3)];
end

%Revolute joints
for k=1:Nrevolute
    line=line+1;
    Jnt_revolute(k).i=H(line,1)';
    Jnt_revolute(k).j=H(line,2)';
    Jnt_revolute(k).spi=H(line,3:4)';
    Jnt_revolute(k).spj=H(line,5:6)';
end

%Translation joints
for k=1:Ntrans
    line=line+1;
    Jnt_trans (k).i=H(line,1)';
    Jnt_trans (k).j=H(line,2)';
    Jnt_trans (k).spPi=H(line,3:4)';
    Jnt_trans (k).spQi=H(line,5:6)';
    Jnt_trans (k).spPj=H(line,7:8)';
    Jnt_trans (k).spQj=H(line,9:10)';
    Jnt_trans(k).spi=Jnt_trans(k).spPi-Jnt_trans(k).spQi;
    Jnt_trans(k).spj=Jnt_trans(k).spPj-Jnt_trans(k).spQj;
    Jnt_trans(k).hj=[Jnt_trans(k).spj(2,1);...
    -Jnt_trans(k).spj(1,1)];
end


% RevRev joints
for k=1:Nrevrev
    line=line+1;
    Jnt_RevRev(k).i=H(line,1);
    Jnt_RevRev(k).j=H(line,2);
    Jnt_RevRev(k).spPi=H(line,3:4)';
    Jnt_RevRev(k).spPj=H(line,5:6)';
end
% RevTra joints
for k=1:Nrevtra
    line=line+1;
    Jnt_RevTra(k).j=H(line,1);
    Jnt_RevTra(k).i=H(line,2);
    Jnt_RevTra(k).spPj=H(line,5:6)';
    Jnt_RevTra(k).spQj=H(line,3:4)';
    Jnt_RevTra(k).spPi=H(line,7:8)';
    Jnt_RevTra(k).spj=Jnt_RevTra(k).spPj-Jnt_RevTra(k).spQj;
    Jnt_RevTra(k).hj=[-Jnt_RevTra(k).spj(2,1);...
    Jnt_RevTra(k).spj(1,1)];
end

% Grounded bodies
for k=1:Nground
    line=line+1;
    Ground(k).i=H(line,1)';
    Ground(k).r=H(line,2:3)';
    Ground(k).theta=H(line,4)';
end

% Simple contstraints
for k=1:Nsimple
    line=line+1;
    Simple(k).i=H(line,1);
    Simple(k).coord=H(line,2);
end
% Drivers
for k=1:Ndriver
    line=line+1;
    Driver(k).i=H(line,1);%body i
    Driver(k).coord=H(line,2);%1:X,2:Y,3:PHI
    Driver(k).pos=H(line,3);%initial position
    Driver(k).vel=H(line,4);%velocity
    Driver(k).acc=H(line,5);%acceleration
end

% Points of interest 
for k=1:Npointsint
    line=line+1;
    Points_int(k).i=H(line,1);
    Points_int(k).spP=H(line,2:3);
end

%   Applied forces
for k=1:Napplforces
    line = line+1;
    Force_applied(k).i=H(line,1);
    Force_applied(k).spPi=H(line,2:3)';
    Force_applied(k).f=H(line,4:5)';
    Force_applied(k).mu=H(line,6);
end

%   Spring and Dampers
for k=1:Nsprdampers 
    line=line+1;
    Spr_Damper(k).i=H(line,1);
    Spr_Damper(k).j=H(line,2);
    Spr_Damper(k).k=H(line,3);
    Spr_Damper(k).l0=H(line,4);
    Spr_Damper(k).c=H(line,5);
    Spr_Damper(k).a=H(line,6);
    Spr_Damper(k).spPi=H(line,7:8)';
    Spr_Damper(k).spPj=H(line,9:10)';
end

line=line+1;
tstart=H(line,1);
tstep=H(line,3);
tend=H(line,2);
tspan=tstart:tstep:tend;
%tseries=H(line,1):H(line,3):H(line,2);

%   Gravity acceleration
line=line+1;
Gravity.force=H(line,1); %9.81
Gravity.direction=H(line,2:3)'; %[0 -1]

%   Integration information
line=line+1;
alpha=H(line,1);
beta=H(line,2);

