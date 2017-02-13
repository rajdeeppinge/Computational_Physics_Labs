clear;
close all;

% declaring initial values
dt = 0.1;
total_time = 10;

init_velocity = 100; %m/s
a = 10;     %force constant (maybe gravity)
b = 1;      %friction constant because of air drag

% Finite difference method
num_ite = total_time / dt; %100

% initializing arrays
velocity = zeros(num_ite, 1);
time = zeros(num_ite, 1); %arrays made

%initial conditions
velocity(1) = init_velocity;
time(1) = 0;

% simulating step-wise
for step = 1:num_ite-1
    velocity(step+1) = velocity(step) + ( a - b * velocity(step) ) * dt;
    time(step+1) = time(step) + dt;
end

%plotting the graph
figure
plot(time, velocity)
xlabel('time')
ylabel('speed')