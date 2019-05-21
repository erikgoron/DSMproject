function [g] = ForceExternal(g, Force_applied, Napplforces)

    % For each external applied force
    for k=1:Napplforces
        i = Force_applied(k).i;
        [g] = ApplyForce(g,Force_applied(k).f,Force_applied(k).spPi,Body,i);
        i3 = 3*i;
        g(i3:i3,1) = g(i3,i3,1)+Force_applied(k).n;
    end
    
end
        
    
    