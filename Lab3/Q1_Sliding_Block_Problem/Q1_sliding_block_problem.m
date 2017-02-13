clear;
close all;

%defining initial values
g = 9.8;
theta_degree = 80;
theta = (pi/180) * theta_degree;    %in radians
init_vel = 0;
init_pos = 0;

global const
const = g * sin(theta);

total_time = 10;
dt = 0.1;
time = 0:dt:total_time;

% Analytical solution
acceleration = g * sin(theta);
velocity = g * sin(theta) * time + init_vel;
position = g/2 .* sin(theta) .* time .* time + init_vel .* time + init_pos;





%Computational solution
tstart = 0;
tfinal = total_time;

% set the initial conditions in the u_init column vector
u_init = zeros(2,1);  
u_init(1) = init_pos; % initial position
u_init(2) = init_vel; % initial velocity

% solve using ode45
[t, u]=ode45(@q1_sliding_motion, [tstart:dt:tfinal], u_init);

% store the answer
x_pos = u(:, 1);
v_vel = u(:, 2);




%plotting the graphs
plot(time, velocity)
hold on;
plot(time, v_vel,'c^')
title('velocity vs time')
xlabel('time')
ylabel('speed')

figure
plot(time, position)
hold on;
plot(time, x_pos,'y+')
title('displacement vs time')
xlabel('time')
ylabel('distance')
