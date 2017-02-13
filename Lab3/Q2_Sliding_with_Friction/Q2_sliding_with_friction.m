clear;
close all;

%defining initial values

global mu_s
g = 9.8;
mu_k=0.3;
mu_s=0.4;

global theta
theta_degree = 10;
theta = (pi/180) * theta_degree;    %in radians

global const;
const = g * (sin(theta)-(mu_k*cos(theta)));

init_vel = 10;
init_pos = 0;

total_time = 20;
dt = 0.1;
time = 0:dt:total_time;

npoints = total_time/dt + 1;



% Analytical solution   
acceleration = g * (sin(theta)-(mu_k*cos(theta)));

velocity = zeros(npoints, 1);
position = zeros(npoints, 1);

velocity(1) = init_vel;
position(1) = init_pos;

for step = 2 : npoints
    velocity(step) = acceleration * dt + velocity(step-1);
    position(step) = acceleration * time(step-1) * dt + init_vel*dt + position(step-1);
    time(step) = time(step-1) + dt;

    % the mass will start to slide only when theta > atan(mu_s) deg. Hence the
    % following is valid only for such angles. Hence, check this condition.
    % if angle is less an the mass is initially moving then it would eventually
    % come to rest

    if(velocity(step) <= 0)
        velocity(step) = 0;
        position(step) = position(step-1);
    end
end

%Computational solution
tstart = 0;
tfinal = total_time;

% set the initial conditions in the u_init column vector
u_init = zeros(2,1);  
u_init(1) = init_pos; % initial position
u_init(2) = init_vel; % initial velocity

[t, u]=ode45(@q2_sliding_motion, [tstart:dt:tfinal], u_init);

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