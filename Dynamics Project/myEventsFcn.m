function status = myEventsFcn (t,y,flag)
global u 
status=0;
switch (flag)
case 'init'
   u=t(1);
case '[]'
   u=[u;t];
case 'done'
   
end