function F = ode_vehicle(t,u)
% function output =name(input)
% right-hand side function for Matlab's ODE solver,


% In our case we will use:
% u(1) -> x
% u(2) -> v

% declare the globals so its value
% set in the main script can be used here
%global g_eff; global R; 
%global g; %global a_rocket;
%global a_hori;

% make the column vector F filled with zeros
F=zeros(length(u),1);

% Now build the elements of F
%
% so the equation dx/dt=v means that F(1)=u(2)
F(1) = u(2);

F(2) = 0;
% Again, in our original ODEs we have: