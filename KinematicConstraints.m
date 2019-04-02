function [Phi, Jac, Niu, Gamma] = KinematicConstraints (q, qd, time);
global
for i=1:NBody;
    i1 = 3*i-2;
    i2 = i1+1;
    i3 = i2+1;
    body(i).r = q(i1:i2,1);
    body(i).theta = q(i3,1);
    cost = cos(body(i).theta);
    sint = sin(body(i).theta);
    body(i).A = [cost -sint; sint cost];
    body(i).B = [-sint -cost; cost -sint];
end;
for k = 1:NRevolute
    [Phi, Jac, Gamma] = JointRevolute(Phi, Jac, Niu, Gamma, Nline, Body, IntRevolute, K);
    Nline = Nline+2;
end;
   
for k = 1:NTranslation
    [Phi, Jac, Gamma] = JointTranslation(Phi, Jac, Niu, Gamma, Nline, Body, IntTranslation, K);
    Nline = Nline+2;
end;

for k = 1:NRevRev
    [Phi, Jac, Gamma] = JointRevRev(Phi, Jac, Niu, Gamma, Nline, Body, IntRevRev, K);
    Nline = Nline+1;
end;

for k = 1:NRevTra
    [Phi, Jac, Gamma] = JointRevTra(Phi, Jac, Niu, Gamma, Nline, Body, IntRevTra, K);
    Nline = Nline+1;
end;

    
   