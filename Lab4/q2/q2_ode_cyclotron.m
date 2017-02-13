function F = q2_ode_cyclotron(t,u)
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
global q; global m; global g;
global x_init; global y_init; global z_init;
global max_dist; global half_time;

%Bz=0.11*u(1); //uncomment this when we want a position dependent field
F(1) = u(4);
F(2) = u(5);
F(3) = u(6);
F(4) = q/m * (Ex + u(5)*Bz - By*u(6));
F(5) = q/m * (Ey + u(6)*Bx - Bz*u(4));
F(6) = q/m * (Ez + u(4)*By - Bx*u(5)) - g;

%method of finding frequency and radius using the analytical solution
%if abs(t-cyclo_time/2) <= 2e-8 && flag == 0
%    comp_radius = sqrt( (u(1)-x_init)^2 + (u(2)-y_init)^2+ (u(3)-z_init)^2 )/2
%    comp_time = 2 * t
%    flag = 1;
%end

%method of finding the maximum distance and half time period
%radius = max_dist / 2 and frequency = inverse of 2*half time period
if sqrt( (u(1)-x_init)^2 + (u(2)-y_init)^2 + (u(3)-z_init)^2 ) >= max_dist
   max_dist = sqrt( (u(1)-x_init)^2 + (u(2)-y_init)^2 + (u(3)-z_init)^2 );
   half_time = t;
end