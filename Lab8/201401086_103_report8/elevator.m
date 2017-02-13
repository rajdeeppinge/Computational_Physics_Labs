% This is a programme to simulate the motion of a ball in elevator
% reference frame
clear;
close all;

%define the basic parameters
mass = 1;       %mass of the ball

g = -9.8 ;      %gravitational acceleration, convetion, the downward direction is negative.

a_elevator = -5; %acceleration of the elevator

% effective acceleration acting on the ball
global g_eff;
g_eff = g - a_elevator;


total_time = 10;
tstart = 0;
tfinal = total_time;
dt = total_time/100;


y_init = 0;     % assuming the vertical direction is y direction
v_init = 20;

% values to be given to ode solver
u0=zeros(2,1);  
u0(1) = y_init; % initial position
u0(2) = v_init; % initial velocity

% ode solver
options = odeset('RelTol',1e-8);
[t,u] = ode45(@elevator_ode, [tstart:dt:tfinal], u0, options);

% store the solution
y = u(:, 1);
vy = u(:, 2);

x = zeros(length(y), 1); %since 1 dimensional motion
vx = zeros(length(y), 1);


% plot the position vs. time
plot(x, y)
title('Position wrt to the elevator frame')
xlabel('position of ball in x-direction (m)');
ylabel('position of ball in y-direction (m)');

% generating quiver plot
x = zeros(length(y), 1); %since 1 dimensional motion
vx = zeros(length(y), 1);

figure
quiver(x, y, vx, vy)
title('quiver plot')
xlabel('x');
ylabel('y');