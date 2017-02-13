function F = q1_ode(t,u)

% Here,
% u(1) -> x
% u(2) -> y
% u(3) -> vx
% u(4) -> vy

% declare the global variables to be used
global G;
global Ms;
%global Me;
%global R;
global x_init; global y_init;

global x_max;

global HalfTimePeriod;
global MajorAxisLength;


% make the column vector F
F=zeros(length(u),1);


% dx/dt=vx
F(1)=u(3);
% dy/dt=vy
F(2)=u(4);

curr_radius = sqrt(u(1)*u(1)+u(2)*u(2));

% equation of dvx/dt
F(3) = -G*Ms*u(1)/((curr_radius)^3);
% equation of dvy/dt
F(4) = -G*Ms*u(2)/((curr_radius)^3);


if ( sqrt( (u(1)-x_init)*(u(1)-x_init) + (u(2)-y_init)*(u(2)-y_init) ) > MajorAxisLength )
    MajorAxisLength = sqrt( (u(1)-x_init)*(u(1)-x_init) + (u(2)-y_init)*(u(2)-y_init) );
    HalfTimePeriod = t;
end