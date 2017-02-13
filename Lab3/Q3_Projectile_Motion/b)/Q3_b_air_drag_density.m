clear 
close all;

% declaring constants and initial values
total_time=500;
dt=0.1;
npoints = total_time/dt; 

global constx;
constx = 0;

global g;
g = 9.8;

global mass;
mass = 1; %kg

global B;
B = 4e-5 * mass;

global y0;
y0 = 1000;

init_pos_x = 0;
init_pos_y = 0;

theta_degree = 48;
theta = (pi/180) * theta_degree;    %in radians

wind_vel_x = -50;  %m/s
wind_vel_y = 0;
init_vel = 750;
vx = init_vel * cos(theta);
vy = init_vel * sin(theta);



%Computational solution
tstart = 0;
tfinal = total_time;

% set the initial conditions in the u_init column vector
u_init = zeros(7,1);  
u_init(1) = init_pos_x; % initial position x-dir
u_init(2) = init_pos_y; % initial position y-dir
u_init(3) = vx; % initial velocity x-dir
u_init(4) = vy; % initial velocity y-dir
u_init(5) = init_vel;
u_init(6) = wind_vel_x;
u_init(7) = wind_vel_y;

% using ODE-solver to solve the ODE
[t, u]=ode45(@q3_b_ode_air_drag_density, [tstart:dt:tfinal], u_init);

x_pos = u(:, 1);
y_pos = u(:, 2);
vx_vel = u(:, 3);
vy_vel = u(:, 4);



% plotting graph
plot(x_pos, y_pos)
title('motion of a projectile')
xlabel('x')
ylabel('y')