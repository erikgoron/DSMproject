function [] = ReadInputData();

%   Accessing memory
global

%   Input filename
[FileName,PathName] = uigetfile('*.txt','Select the Model Data file');

%   Reading data from input file
H = dlmread(Filename);

%   Storing data in local variables
line = 1;
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

%   Storing data for rigid bodies
for i=1:Nbody
    line=line+1;
    body(i).r=H(line,1:2);
    body(i).theta=H(line,3)
    body(i).rd=H(line,4:5);
    body(i).thetad=H(line,6);
    body(i).mass=H(line,7);
    body(i).J=H(line,8);
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

%   Applied forces
for k=1:Napllforces
    line = line+1;
    Force_applied(k).i=H(line,1);
    Force_applied(k).spPi=H(line,2:3);
    Force_applied(k).f=H(line,4:5);
    Force_applied(k).mu=H(line,6);
end

%   Spring and Dampers
for k=1:Nsprdampers 
    line=line+1:
    Spr_Damper(k).i=H(line,1);
    Spr_Damper(k).j=H(line,2);
    Spr_Damper(k).k=H(line,3);
    Spr_Damper(k).l0=H(line,4);
    Spr_Damper(k).c=H(line,5);
    Spr_Damper(k).a=H(line,6);
    Spr_Damper(k).spPi=H(line,7:8);
    Spr_Damper(k).spPj=H(line,9:10);
end

%   Time analysis 
line=line+1;
tstart=H(line,1);
tstep=H(line,3);
tend=H(line,2);

%   Gravity acceleration
line=line+1;
Gravity.force=H(line,1);
Gravity.direction=H(line,2);

%   Integration information
line=line+1;
alpha=H(line,1);
beta=H(line,2);
end

