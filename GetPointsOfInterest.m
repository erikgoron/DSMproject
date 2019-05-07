PositionsT=Positions';
% turn off a warning
warning('off','MATLAB:table:RowsAddedExistingVars');
for i=1:Nbody
    %cell array of tables (1 for each body)
    body{i}=table;
    %using table because i can dynamically assign variables
    i2=i*3; % 3 6 9
    i1=i2-2; % 1 4 7
    body{i}.Variables=PositionsT(:,i1:i2);
    body{i}.Properties.VariableNames={'X','Y','PHI'};
end

PosPOI=zeros(length(t),Npointsint*2);

for kt=1:length(t)
    
    for k = 1:Npointsint
        i=Points_int(k).i;
        spP=(Points_int(k).spP)';
        b=body{i};
        center=[b.X(kt);b.Y(kt)];
        point= A(b.PHI(kt))*spP;
        p=center+point;
        PosPOI(kt,k:k+1)=p';
    end
end

plot(PosPOI(:,1),PosPOI(:,2))