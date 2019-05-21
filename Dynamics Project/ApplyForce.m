function [g] = ApplyForce(g,f,spPi,Body,i)

% Transport moment
R = [0 -1;1 0];
n = f'*R*(Body(i).A*spPi);

% Add to vector force
i1 = 3*i-2;
i2 = i1+1;
i3 = i2+1;
g(i1:i2,1) = g(i1:i2,1)+f;
g(i3:i3,1) = g(i3:i3,1)+n;

end 