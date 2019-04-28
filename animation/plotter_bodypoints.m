
%initialize
bodyPoints=cell(Nbody,1);
%to find out the limits of the plot

for k = 1:Nrevolute
    i=Jnt_revolute(k).i;
    j=Jnt_revolute(k).j;
    spPi=Jnt_revolute(k).spPi;
    spPj=Jnt_revolute(k).spPj;
    bodyPoints{i}=[bodyPoints{i} spPi'];
    bodyPoints{j}=[bodyPoints{j} spPj'];
    

    
end
   
for k = 1:Npointsint
    i=Points_int(k).i;
    spP=Points_int(k).spP;
    bodyPoints{i}=[bodyPoints{i} spP'];

end








