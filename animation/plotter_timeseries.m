



%..... put the data into indexable variables for each body,point
if fromPlt
time=plt(:,1);
for i=1:NBody
    %cell array of tables (1 for each body)
    body{i}=table;
    %using table because i can dynamically assign variables
    body{i}.Variables=plt(:,(i-1)*9+2:9*i+1);
    body{i}.Properties.VariableNames={'X','Y','PHI','XD','YD','PHID','XDD','YDD','PHIDD'};
end
for i=1:NPointsInt
    point{i}=table;
    point{i}.Variables=plt(:,(i+NBody-1)*6+2:6*(i+NBody)+1);
    point{i}.Properties.VariableNames={'X','Y','XD','YD','XDD','YDD'};
end
end

if fromPositions
time=1:size(plt,1)';
for i=1:NBody
    %cell array of tables (1 for each body)
    body{i}=table;
    %using table because i can dynamically assign variables
    
    i2=i*3; % 3 6 9
    i1=i2-2; % 1 4 7
    body{i}.Variables=plt(:,i1:i2);
    body{i}.Properties.VariableNames={'X','Y','PHI'};
end
end

%read date with body{2}.X

%...    for each timestep, draw the bodies
%as lines between center and joints/POIs
lines=[];
%a color for each body
color=rand(NBody,3);

%initialize the xlim and ylim values
maxplot=[0 0];
minplot=[0 0];

%rotation matrix for local coords
A=@(phi) [cos(phi) -sin(phi);sin(phi) cos(phi)];
%in the first iteration,dont plot, calculate the xlim and ylim
%so that we have a constant sized window. 
%then repeat the plotting a few times
for doPlot=[0,ones(1,repeatAnimation)]
for kt=1:length(time)
    for i=1:NBody
        if i==Ground(1).i
            continue;
        end

        b=body{i};
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
                xlim([minplot(1) maxplot(1)]);
                ylim([minplot(2) maxplot(2)]);
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
            input('press enter','s');
        else
           
            %makes the program wait for a bit, 
            pause(frameDelay);
        end
        
    end
   
    for l=lines
         l.delete()
    end
end
end

        
        

