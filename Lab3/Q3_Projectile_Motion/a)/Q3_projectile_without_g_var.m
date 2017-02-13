clear 
close all;

% declaring constants and initial values
g=9.8;

total_time=150;
dt=0.1;
npoints = total_time/dt; 

global constx
global consty
constx = 0;
consty = -g;

init_pos_x = 0;
init_pos_y = 0;

theta_degree = 45;
theta = (pi/180) * theta_degree;    %in radians

init_vel = 750;
vx = init_vel * cos(theta);
vy = init_vel * sin(theta);



% Exact Solution
time_of_flight = 2*init_vel*sin(theta) / g;
time = 0:dt:time_of_flight;
x = vx * time;
y = vy * time - g/2 * time .* time;



%Computational solution
tstart = 0;
tfinal = total_time;

% set the initial conditions in the u_init column vector
u_init = zeros(4,1);  
u_init(1) = init_pos_x; % initial position x-dir
u_init(2) = init_pos_y; % initial position y-dir
u_init(3) = vx; % initial velocity x-dir
u_init(4) = vy; % initial velocity y-dir

% using ODE-solver to solve the ODE
[t, u]=ode45(@q3_projectile_ideal_without_g_var, [tstart:dt:tfinal], u_init);

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