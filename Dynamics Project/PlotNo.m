clear all
Filename='strandbeestDAP_v4.2.rtf';

 
ReadInputDAP
ground=12;
Ground.i=12;

close all
%how many times to repeat
repeatAnimation=5;
%option to play animation frame by frame by pressing enter
frameByFrame=true;
%animation speed, default = 1= realtime
frameDelay=0.1; %or manually set tstep after reading input data
%stop animation anytime with Ctrl+C


%%%%%%%%%% ....... COLLECT THE POINTS that we wanna draw for each body
%at the moment its revolute joints and points of interest

%initialize
%using cell data type, indexing with {i}
bodyPoints=cell(Nbody,1);
%to find out the limits of the plot

for k = 1:Nrevolute
    i=Jnt_revolute(k).i;
    j=Jnt_revolute(k).j;
    spPi=Jnt_revolute(k).spi;
    spPj=Jnt_revolute(k).spj;
    bodyPoints{i}=[bodyPoints{i} spPi];
    bodyPoints{j}=[bodyPoints{j} spPj];
    
end

%TODO: other joints
   
for k = 1:Npointsint
    i=Points_int(k).i;
    spP=Points_int(k).spP;
    bodyPoints{i}=[bodyPoints{i} spP'];

end

%%%%%%% ..... GET RESULTS FROM SIMULATION

% turn off a warning 
warning('off','MATLAB:table:RowsAddedExistingVars');
% for i=1:Nbody
%     %cell array of tables (1 for each body)
%     body{i}=table;
%     %using table because i can dynamically assign variables 
%     i2=i*3; % 3 6 9
%     i1=i2-2; % 1 4 7
%     body{i}.Variables=PositionsT(:,i1:i2);
%     body{i}.Properties.VariableNames={'X','Y','PHI'};
% end
for i=1:Nbody
    %cell array of tables (1 for each body)
    bodytab{i}=table;
    %using table because i can dynamically assign variables 
    i2=i*3; % 3 6 9
    i1=i2-2; % 1 4 7
    bodytab{i}.Variables=q0mat(i,1:3);
    bodytab{i}.Properties.VariableNames={'X','Y','PHI'};
end
%read data like this: body{2}.X


%%%%%% ...... PLOTTING

%...    for each timestep, draw the bodies
%as lines between center and joints/POIs
lines=[];
%a color for each body
color=rand(Nbody,3)*0.0;

%initialize the xlim and ylim values
maxplot=[0 0];
minplot=[0 0];

%rotation matrix for local coords
A=@(phi) [cos(phi) -sin(phi);sin(phi) cos(phi)];


%in the first iteration,dont plot, calculate the xlim and ylim
%so that we have a constant sized window. 
%then repeat the plotting a few time
fig1=figure;
kt=1;
for i=1:Nbody
    if i==Ground(1).i
        % continue;
    end
    
    b=bodytab{i};
    center=[b.X(kt);b.Y(kt)];
    points= A(b.PHI(kt))*bodyPoints{i};
    
    for j=1:size(points,2)
        px=center(1)+points(1,j);
        py=center(2)+points(2,j);
        
        l=plot([center(1) px],...
            [center(2) py],...
            '-',...
            'Color',color(i,:));
        
        hold on;
        axis equal;
        
        lines=[lines l];
        
        maxplot=max(maxplot,[px py]);
        minplot=min(minplot,[px py]);
        l=[];
        
        
    end
    label=center+ A(b.PHI(kt))*[0;-3];
    text(label(1),label(2),num2str(i),'HorizontalAlignment','center')
    
end
xlim([minplot(1)-10 maxplot(1)+10]);
ylim([minplot(2)-10 maxplot(2)+10]);




        
        


