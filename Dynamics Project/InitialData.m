global Flag q0 q00 body0 qd

Flag.Position = 0;
Flag.Jacobian = 0;
Flag.Niu=0;
Flag.Gamma=0;
q00=q0;
[body0]=Preprocessdata(q0,qd);