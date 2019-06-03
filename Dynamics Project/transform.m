% clear all
% load('jb_v4.4.2.mat')
% v=[11,22,34,45];
% bodies.Y0(v)=bodies.Y0(v)*2;
% bodies.Size(v)=bodies.Size(v)*2;
% h=[46,23];
% bodies.Y0(h)=bodies.Y0(h)*2;
Njoints=68;
joints.j_no=[1:68]';

j2=joints;
j2.b1=j2.b1+100*j2.b1_jloc;
j2.b2=j2.b2+100*j2.b2_jloc;

g=graph(j2.b1',j2.b2',1:68);

close all


[bins,binsizes] = conncomp(g);
lonelybins=find(binsizes==1);
lonelynodes=find(sum(bins==lonelybins'));
g=rmnode(g,lonelynodes);

[bins,binsizes] = conncomp(g);
outedges(g,1)
ca=cell(1,length(binsizes));
for kn=1:length(bins)
    bn=bins(kn);
    eg=outedges(g,kn)
    jno=g.Edges.Weight(eg)'
    
    ca{bn}=unique([ca{bn},jno]);
end

plot(g,'EdgeLabel',g.Edges.Weight)

histcounts(weak_bins,'BinMethod','integers');
c1={1,[2,3],[4,5],[6,7,8],[9,10],[11,12],[13,14,33],15,16} ;  
for k=1:size(c1,2)
    c2{k}=c1{k}+16;
end    
    