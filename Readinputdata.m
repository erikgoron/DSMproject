global  Nbody Nrevolute Ntrans Nrevrev Nrevtra Nground Nsimple Ndriver Npointsint
global Jnt_revolute tend tstart tstep q0 Jnt_trans Ground Points_int
global Ncoord Nconst w omega0 NRparameters Driver

NRparameters.tolerance = 0.000001;
NRparameters.MaxIteration = 20;

Filename= uigetfile('*.rtf','Select Model');
%read data from input file
H=dlmread(Filename);
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
Ncoord=3*Nbody;
Nconst=2*Nrevolute+2*Ntrans+Nrevrev+Nrevtra+...
    3*Nground+Nsimple+Ndriver;
% Initial Positions
q0=[];
for i=1:Nbody
    line=line+1;
    q0=[q0;H(line,1:3)'];
end
%revolute joints
for k=1:Nrevolute
    line=line+1;
    Jnt_revolute(k).i=H(line,1)';
    Jnt_revolute(k).j=H(line,2)';
    Jnt_revolute(k).spi=H(line,3:4)';
    Jnt_revolute(k).spj=H(line,5:6)';
end
%translation joints
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

%TO DO
%RevRev joints
for k=1:Nrevrev
    line=line+1;
%     Jnt_RevRev(k).i=H(line,1);
%     Jnt_RevRev(k).j=H(line,2);
%     Jnt_RevRev(k).d0=H(line,3);
%     Jnt_RevRev(k).spPi=H(line,4:5);
%     Jnt_RevRev(k).spQi=H(line,6:7);
%     Jnt_RevRev(k).spPj=H(line,8:9);
%     Jnt_RevRev(k).spQj=H(line,10:11);
end
%RevTra joints
for k=1:Nrevtra
    line=line+1;
%     Jnt_RevTra(k).i=H(line,1);
%     Jnt_RevTra(k).j=H(line,2);
%     Jnt_RevTra(k).spPi=H(line,3:4);
%     Jnt_RevTra(k).spPj=H(line,7:8);
%     Jnt_RevTra(k).spQj=H(line,9:10);
end

%Grounded bodies
for k=1:Nground
    line=line+1;
    Ground(k).i=H(line,1)';
end

%TO DO simple contstraints
for k=1:Nsimple
    line=line+1;
    %Simple constraints here
end
%Drivers
for k=1:Ndriver
    line=line+1;
    Driver(k).i=H(line,1);%body i
    Driver(k).coord=H(line,2);%1:X,2:Y,3:PHI
    Driver(k).pos=H(line,3);%initial position
    Driver(k).vel=H(line,4);%velocity
    Driver(k).acc=H(line,5);%acceleration
end

%%% Just one driver
omega0=Driver(k).pos;
w=Driver(k).vel;


%Points of interest
for k=1:Npointsint
    line=line+1;
    Points_int(k).i=H(line,1);
    Points_int(k).spP=H(line,2:3);
end

line=line+1;
tstart=H(line,1);
tstep=H(line,3);
tend=H(line,2);
%tseries=H(line,1):H(line,3):H(line,2);