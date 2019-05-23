
%load('plt4bar.mat')


warning('off','MATLAB:table:RowsAddedExistingVars');
NBody=4;

time=plt(:,1);
%plt=[0*plt(1,:);plt(1:end-2,:)];

%last line is NaN
plt=plt(1:end-1,:);
%Vel(2)=plt.vel(1)
for i=1:NBody
    %cell array of tables (1 for each body)
    body{i}=table;
    %using table because i can dynamically assign variables
    body{i}.Variables=plt(:,(i-1)*9+2:9*i+1);
    body{i}.Properties.VariableNames={'X','Y','PHI','XD','YD','PHID','XDD','YDD','PHIDD'};
end


PositionsT=Positions';
VT=Velocities';
AT=Accelerations';
for i=1:NBody
    %cell array of tables (1 for each body)
    bodyp{i}=table;
    %using table because i can dynamically assign variables 
    i2=i*3; % 3 6 9
    i1=i2-2; % 1 4 7
    bodyp{i}.Variables=[PositionsT(:,i1:i2),VT(:,i1:i2),AT(:,i1:i2)] ;
    bodyp{i}.Properties.VariableNames={'X','Y','PHI','XD','YD','PHID','XDD','YDD','PHIDD'};
end

for i=1:NBody
    %cell array of tables (1 for each body)
    dif{i}=table;
    %using table because i can dynamically assign variables 
    i2=i*3; % 3 6 9
    i1=i2-2; % 1 4 7
    dif{i}.Variables=round(plt(:,(i-1)*9+2:9*i+1)-[PositionsT(:,i1:i2),VT(:,i1:i2),AT(:,i1:i2)],3) ;
    dif{i}.Properties.VariableNames={'X','Y','PHI','XD','YD','PHID','XDD','YDD','PHIDD'};
end
