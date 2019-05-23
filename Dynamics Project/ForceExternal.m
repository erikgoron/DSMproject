function [g] = ForceExternal(g,body, Force_applied, Napplforces)

    % For each external applied force
    for k=1:Napplforces
        i = Force_applied(k).i;
        [g] = ApplyForce(g,Force_applied(k).f,Force_applied(k).spPi,body,i);
        
    end
    
end
        
    
    