% .... ANIMATION
close all
%how many times to repeat
repeatAnimation=5;
%option to play animation frame by frame by pressing enter
frameByFrame=true;
%animation speed, default = 1= realtime
frameDelay=0.1; %or manually set tstep after reading input data
%stop animation anytime with Ctrl+C

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
    bodyt{i}=table;
    %using table because i can dynamically assign variables 
    i2=i*3; % 3 6 9
    i1=i2-2; % 1 4 7
    bodyt{i}.Variables=q0mat(i,1:3);
    bodyt{i}.Properties.VariableNames={'X','Y','PHI'};
end
%read data like this: body{2}.X
%%%%%%%%%% ....... COLLECT THE POINTS that we wanna draw for each body
%at the moment its revolute joints and points of interest
%rotation matrix for local coords
A=@(phi) [cos(phi) -sin(phi);sin(phi) cos(phi)];
%initialize
%using cell data type, indexing with {i}
bodyPoints=cell(Nbody,1);
%to find out the limits of the plot
problemjoints=[];
for k = 1:Nrevolute
    i=Jnt_revolute(k).i;
    j=Jnt_revolute(k).j;
    spPi=Jnt_revolute(k).spi;
    spPj=Jnt_revolute(k).spj;
    bodyPoints{i}=[bodyPoints{i} spPi];
    bodyPoints{j}=[bodyPoints{j} spPj];
    b=bodyt{i};
    center=[b.X(1);b.Y(1)];
    points= A(b.PHI(1))*spPi;
    
    p1=center+points;
    
        
    b=bodyt{j};
    center=[b.X(1);b.Y(1)];
    points= A(b.PHI(1))*spPj;
    
    p2=center+points;
    
    if norm(p1-p2)>1e-1
        warning(['problem joint ',num2str(k),', body ',...
            num2str(i),', body ',num2str(j),', dist ',num2str(norm(p1-p2))])
        problemjoints=[problemjoints,[k;i;j;p1;p2]];
    end
    
    
    
    
end

%TODO: other joints
   
for k = 1:Npointsint
    i=Points_int(k).i;
    spP=Points_int(k).spP;
    bodyPoints{i}=[bodyPoints{i} spP'];

end

%%%%%%% ..... GET RESULTS FROM SIMULATION

% turn off a warning 



%%%%%% ...... PLOTTING

%...    for each timestep, draw the bodies
%as lines between center and joints/POIs
lines=[];
%a color for each body
color=rand(Nbody,3)*0.0;
% if size(ground)~=[0,0]
% for g=ground(:,1)'
%     color(g,:)=[1 0 0];
% end
% end
% if size(drivers)~=[0,0]
% for d=drivers(:,1)'
%     color(d,:)=[0 1 0];
% end
% end
%initialize the xlim and ylim values
maxplot=[0 0];
minplot=[0 0];




%in the first iteration,dont plot, calculate the xlim and ylim
%so that we have a constant sized window. 
%then repeat the plotting a few time
fig1=figure;
for doPlot=1   %[0,ones(1,repeatAnimation)]
for kt=1:1
    for i=1:Nbody
        if i==Ground(1).i
           % continue;
        end

        b=bodyt{i};
        center=[b.X(kt);b.Y(kt)];
        points= A(b.PHI(kt))*bodyPoints{i};
        for j=1:size(points,2)
            px=center(1)+points(1,j);
            py=center(2)+points(2,j);
            if doPlot
                l=plot([center(1) px],...
                        [center(2) py],...
                        '-o',...
                        'Color',color(i,:));

                    hold on;
                    axis equal;
                %xlim([minplot(1) maxplot(1)]);
                %ylim([minplot(2) maxplot(2)]);
                lines=[lines l];
            else
                maxplot=max(maxplot,[px py]);
                minplot=min(minplot,[px py]);
                l=[];
            end

        end
    end
    if doPlot
        %to pause at every timestep until user
        %presses enter
        if frameByFrame
            break
        else
           
            %makes the program wait for a bit, 
            pause(frameDelay);
            if ~ishandle(fig1)
                break;
            end
            
        end
        
    end
   
    for l=lines
         l.delete()
    end

end
if ~ishandle(fig1)
    break;
end
end

        
        


