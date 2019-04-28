function [Phi] = driver(Phi,body,Nline,time)
global omega0 w Driver

Phi(Nline,1)=body(Driver(1).i).theta-omega0-w*time;
