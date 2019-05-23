%initial positions from calculated positions
ipos=[];
for k=1:Nbody
    bd=body{k}.Variables;
    ipos=[ipos;bd(1,1:6)];
end
csvwrite('ipos.csv',ipos);
fileread('ipos.csv')
system('del ipos.csv');