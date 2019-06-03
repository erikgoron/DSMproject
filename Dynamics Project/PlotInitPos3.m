% .... ANIMATION
% addpath nogit


%close all
%how many times to repeat
repeatAnimation=1;
%option to play animation frame by frame by pressing enter
frameByFrame=true;
%animation speed, default = 1= realtime
frameDelay=0.1; %or manually set tstep after reading input data
%stop animation anytime with Ctrl+C
skipmod=2; %show only every n frame

doGif=false;

load('joint_locations_4.2.8.mat')


%%%%%%%%%% ....... COLLECT THE POINTS that we wanna draw for each body
%at the moment its revolute joints and points of interest

%initialize
%using cell data type, indexing with {i}
bodyPoints=cell(Nbody,1);
%to find out the limits of the plot

% for k = 1:Nrevolute
%     i=Jnt_revolute(k).i;
%     j=Jnt_revolute(k).j;
%     spPi=Jnt_revolute(k).spi;
%     spPj=Jnt_revolute(k).spj;
%     bodyPoints{i}=[bodyPoints{i} spPi];
%     bodyPoints{j}=[bodyPoints{j} spPj];
%     
% end
for k=1:Nbody
    sz=bodies.Size(k);
    bodyPoints{k}=[-sz/2, sz/2; 0 0];
end

% for k = 1:Nrevtra
%     i=Jnt_RevTra(k).i;
%     j=Jnt_RevTra(k).j;
%     spPi=Jnt_RevTra(k).spPj;
%     spQj=Jnt_RevTra(k).spQj;
%     spPj=Jnt_RevTra(k).spPi;
%     
% end

%TODO: other joints
% 
% for k = 1:Npointsint
%     i=Points_int(k).i;
%     spP=Points_int(k).spP;
%     bodyPoints{i}=[bodyPoints{i} spP'];
%     
% end

%%%%%%% ..... GET RESULTS FROM SIMULATION

% turn off a warning
warning('off','MATLAB:table:RowsAddedExistingVars');
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
color=rand(Nbody,3)*0.85*0;
%color=color*0;

%initialize the xlim and ylim values
maxplot=[0 0];
minplot=[0 0];

%rotation matrix for local coords
A=@(phi) [cos(phi) -sin(phi);sin(phi) cos(phi)];


%in the first iteration,dont plot, calculate the xlim and ylim
%so that we have a constant sized window.
%then repeat the plotting a few time
fig1=figure;
colormap('jet');
t=1;
for doPlot=[0,ones(1,repeatAnimation)]
    for kt=1%1:length(t)
        
        for i=1:Nbody

            
            b=bodytab{i};
            center=[b.X(kt);b.Y(kt)];
            points= A(b.PHI(kt))*bodyPoints{i};
            px=[center(1),center(1)]+points(1,:);
            py=[center(2),center(2)]+points(2,:);
            if doPlot
                l=plot([px],...
                    [py],...
                    '-o',...
                    'Color',color(i,:));
                if ~ishandle(fig1)
                    break;
                end
                hold on;
                if ~ishandle(fig1)
                    break;
                end
                axis equal;
                if ~ishandle(fig1)
                    break;
                end
                xlim([minplot(1) maxplot(1)]);
                ylim([minplot(2) maxplot(2)]);
                lines=[lines l];
            else
                maxplot=max(maxplot,[px(1) py(1)]);
                minplot=min(minplot,[px(1) py(1)]);
                l=[];
            end
            
            
        end
        if doPlot
%             tx=text(-50,50,num2str(t(kt)));
%             lines=[lines,tx];
%             
% %             for kjb=1:Njloc
%                 bin=jbins{kjb};
%                 lmb=[];
%                 for kbi=1:size(bin,2)
%                     kj=bin(kbi);
%                     i2=2*kj;
%                     i1=i2-1;
%                     lmb(kbi)=norm(lambda(i1:i2,kt));
%                     
%                     
%                     if kbi==1
%                         i=Jnt_revolute(kj).i;
%                         
%                         spPi=Jnt_revolute(kj).spi;
%                         b=bodytab{i};
%                         center=[b.X(kt);b.Y(kt)];
%                         fpoint(:,kjb)=center+ A(b.PHI(kt))*spPi;
%                     end
%                     
%                 end
%                 maxf(kjb)=max(lmb);
%                 
%             end
            
%             
%             sctr=scatter(fpoint(1,:),fpoint(2,:),25,maxf,'filled');
%             cbr=colorbar;
%             lines=[lines,sctr,cbr];
            
                


                
                
            
            
            if doGif
                drawnow
                filename='anim.gif';
                % Capture the plot as an image
                frame = getframe(fig1);
                im = frame2im(frame);
                [imind,cm] = rgb2ind(im,256);
                % Write to the GIF File
                if kt == 1
                    imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.03);
                else
                    imwrite(imind,cm,filename,'gif','WriteMode','append');
                end
            end
            
            %to pause at every timestep until user
            %presses enter
            
            if frameByFrame
                input('press enter','s');
            else
                
                %makes the program wait for a bit,
                pause(frameDelay);
                if ~ishandle(fig1)
                    break;
                end
            end
        end
        if kt~=length(t)
            for l=lines
                l.delete()
            end
        end
        
        
    end
    if ~ishandle(fig1)
        break;
    end
end





