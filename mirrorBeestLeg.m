%initial positions from calculated positions
% ipos=[];
% for k=1:12
%     bd=body{k}.Variables;
%     ipos=[ipos;bd(2,:)];
% end
clearvars
load('jb_v3.2.mat')
dist=180;

j0=joints.Variables;
joints.j_no=joints.j_no +34;
joints.b1=joints.b1 +25;
joints.b2=joints.b2 +25;
j1=joints.Variables;
jf=table;
jf.Variables=[j0;j1];
jf.Properties.VariableNames=joints.Properties.VariableNames;
joints=jf;

b0=bodies.Variables;
bodies.X0=bodies.X0+dist;
bodies.Bodies=bodies.Bodies+25;
b1=bodies.Variables;

bf=table;
bf.Variables=[b0;b1];
bf.Properties.VariableNames=bodies.Properties.VariableNames;
bodies=bf;
save('jb_v4.mat','bodies','joints');