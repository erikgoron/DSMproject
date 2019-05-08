PositionsT=Positions';
VelocitiesT=Velocities';
AccelerationsT=Accelerations';
% turn off a warning
warning('off','MATLAB:table:RowsAddedExistingVars');
for i=1:Nbody
    %cell array of tables (1 for each body)
    body{i}=table;
    %using table because i can dynamically assign variables
    i2=i*3; % 3 6 9
    i1=i2-2; % 1 4 7
    body{i}.Variables=[PositionsT(:,i1:i2),VelocitiesT(:,i1:i2),AccelerationsT(:,i1:i2)];
    body{i}.Properties.VariableNames={'X','Y','PHI','XD','YD','PHID','XDD','YDD','PHIDD'};
end
A=@(phi) [cos(phi) -sin(phi);sin(phi) cos(phi)];
PosPOI=zeros(length(t),Npointsint*2);
VelPOI=zeros(length(t),Npointsint*2);
AccPOI=zeros(length(t),Npointsint*2);
for kt=1:length(t)
    
    for k = 1:Npointsint
        i=Points_int(k).i;
        spP=(Points_int(k).spP)';
        b=body{i};
        center=[b.X(kt);b.Y(kt)];
        point= A(b.PHI(kt))*spP;
        p=center+point;
        i1=2*k-1;
        PosPOI(kt,i1:i1+1)=p';
        
        v_center=[b.XD(kt);b.YD(kt)];
        v=v_center+b.PHID(kt)*[0 -1;1 0]*point;
        VelPOI(kt,i1:i1+1)=v';
        
        a_center=[b.XDD(kt);b.YDD(kt)];
        a=a_center+b.PHID(kt)^2*point-b.PHIDD(kt)*[0 -1;1 0]*point;
        AccPOI(kt,i1:i1+1)=a;
    end
end

%%% PLotting
for k = 1:Npointsint
    i1=2*k-1;
    plot(PosPOI(:,i1),PosPOI(:,i1+1));hold on
    quiver(PosPOI(:,i1),PosPOI(:,i1+1),AccPOI(:,i1),AccPOI(:,i1+1)); 
end
