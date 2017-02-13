function F=q4_ode_springmass(t,u)
% function output =name(input)
% right-hand side function for Matlab's ODE solver,

% In our case we will use:
% u(1) -> x
% u(2) -> v

% declare the globals so its value
% set in the main script can be used here
global const;
global beta;
global b;

% make the column vector F equal to length of u
F=zeros(length(u),1);

% dx/dt=v
F(1)=u(2);

% dv/dt
F(2)=-const*u(1)-b*u(2);