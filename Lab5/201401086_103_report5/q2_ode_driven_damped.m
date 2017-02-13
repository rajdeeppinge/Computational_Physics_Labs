function F=q2_ode_driven_damped(t,u)
% function output =name(input)
% right-hand side function for Matlab's ODE solver,

% In our case we will use:
% u(1) -> theta
% u(2) -> omega

% declare the globals so its value
% set in the main script can be used here
global omega_not;
global beta;
global f0;
global omega_dri;

% make the column vector F filled with zeros
F = zeros(length(u),1);

% Now build the elements of F
%
% so the equation dx/dt=v means that F(1)=u(2)
F(1) = u(2);
% Again, in our original ODEs we have:

% so the equation dv/dt=-....
F(2) = -omega_not*omega_not*u(1) - 2*beta*u(2) - f0*cos(omega_dri*t);