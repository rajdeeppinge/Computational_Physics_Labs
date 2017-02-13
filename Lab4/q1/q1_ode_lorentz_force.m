function F = q1_ode_lorentz_force(t,u)
% function output =name(input)
% right-hand side function for Matlab's ODE solver,
F=zeros(length(u),1);

% In our case we will use:
% u(1) -> x
% u(2) -> y
% u(3) -> z
% u(4) -> vx
% u(5) -> vy
% u(6) -> vz

% declare the globals so its value
% set in the main script can be used here
global Bx; global By; global Bz;
global Ex; global Ey; global Ez;
global q; global m; %global g;

%Bz=0.11*u(1); //uncomment this when we want a position dependent field

F(1) = u(4);
F(2) = u(5);
F(3) = u(6);
F(4) = q/m * (Ex + u(5)*Bz - By*u(6));
F(5) = q/m * (Ey + u(6)*Bx - Bz*u(4));
F(6) = q/m * (Ez + u(4)*By - Bx*u(5));% - g;       % -g is to see the effect of gravity