clear 
close all;

% declaring constants and initial values
g=9.8;

total_time=1000;
dt=.5;

global constx
constx = 0;

global consty
consty = g;

init_pos_x = 0;
init_pos_y = 0;

theta_degree = 45;
theta = (pi/180) * theta_degree;    %in radians
%init_vel = 1000;

global R
R = 6.4e5;  % radius of earth in meters

init_vel = 750;




% Exact Solution

time_of_flight = 2*init_vel*sin(theta) / g;
time = 0;
npoints = ceil(time_of_flight/dt) + 10; 

vx = zeros(npoints,1);
vy = zeros(npoints,1);

vx(1) = init_vel * cos(theta);
vy(1) = init_vel * sin(theta);

x = zeros(npoints,1);
y = zeros(npoints,1);
time = zeros(npoints,1);

x(1) = 0;
y(1) = 0;
time(1) = 0;

for step = 2 : npoints
   time(step) = time(step-1) + dt;
   x(step) = x(step-1) + vx(step-1) * dt;
   vx(step) = vx(step-1);
   y(step) = y(step-1) + vy(step-1) * dt;
   vy(step) = vy(step-1) - g * ( R / (R+y(step-1)) )^2 * dt;
end


%Computational solution
tstart = 0;
tfinal = total_time;

% set the initial conditions in the u_init column vector
u_init = zeros(4,1);  
u_init(1) = init_pos_x; % initial position x-dir
u_init(2) = init_pos_y; % initial position y-dir
u_init(3) = vx(1); % initial velocity x-dir
u_init(4) = vy(1); % initial velocity y-dir
%u_init(5) = g;

% using ODE-solver to solve the ODE
[t, u]=ode45(@q3_projectile_ideal, [tstart:dt:tfinal], u_init);

x_pos = u(:, 1);
y_pos = u(:, 2);
vx_vel = u(:, 3);
vy_vel = u(:, 4);



% plotting graph
plot(x,y)
title('motion of a projectile')
xlabel('x')
ylabel('y')

hold on;
plot(x_pos, y_pos, 'y+')
title('motion of a projectile')
xlabel('x')
ylabel('y')