end % end of assembling

y0 = 100;
gamma = -2;
for i=1:M
    % Import Robin conditions
    if(i<M)
        h = sqrt((x(i+1)-k(i))^2+(y(i+1)-y(i))^2);
        kg(i,i)=ky(i,i)+p*h/3;
        kg(i+1,i+1)=ky(i+1,i+1)+p*h/3;
        kg(i,i+1)=ky(i,i+1)+p*h/6;
        kg(i+1,i)=ky(i+1,i)+p*h/6;
        fg(i)=fg(i)+gamma*h/2;
        fg(i+1)=fg(i+1)+gamma*h/2;
    else
        h=sqrt((x(1)-x(i))^2+(y(1)-y(+1))^2)
        kg(i,i)=ky(i,i)+p*h/3;
        kg(1,1)=ky(1,1)+p*h/3;
        kg(i,1)=ky(i,1)+p*h/6;
        kg(1,i)=ky(1,i)+p*h/6;
        fg(i)=fg(i)+gamma*h/2;
        fg(1)=fg(1)+gamma*h/2;
    end
end

kr=kg;
fr=fg;
kr=sparse(kr);
u=kr\fr;

% Exact solution
uex=1-x.^2-y.^2
figure(2);
erru=abs(u-uex);
trisurf(TRI,x,y,erru);
grid on
        