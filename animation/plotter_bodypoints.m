
%initialize
bodyPoints=cell(NBody,1);
%to find out the limits of the plot

for k = 1:NRevolute
    i=Jnt_Rev(k).i;
    j=Jnt_Rev(k).j;
    spPi=Jnt_Rev(k).spPi;
    spPj=Jnt_Rev(k).spPj;
    bodyPoints{i}=[bodyPoints{i} spPi'];
    bodyPoints{j}=[bodyPoints{j} spPj'];
    

    
end
   
for k = 1:NPointsInt
    i=POI(k).i;
    spP=POI(k).spP;
    bodyPoints{i}=[bodyPoints{i} spP'];

end








