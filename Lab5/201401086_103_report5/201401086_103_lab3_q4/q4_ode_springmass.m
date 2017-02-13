function F=q4_ode_springmass(t,u)
% function output =name(input)
% right-hand side function for Matlab's ODE solver,


% In our case we will use:
% u(1) -> x
% u(2) -> v

% declare the globals so its value
% set in the main script can be used here
global cnst;
global beta;
global b;

drive_force = 10*sin(100 * t);
% make the column vector F filled with zeros
F=zeros(length(u),1);

% Now build the elements of F
%
% so the equation dx/dt=v means that F(1)=u(2)
F(1)=u(2);
% Again, in our original ODEs we have:

% so the equation dv/dt=-....
F(2)=-cnst*u(1)-b*u(2)+drive_force;