clear;
close all;

% define total time and time step
dt = 0.1;
total_time = 100;

% Exact Solution
time = 0:dt:total_time; %time array
velocity = 50; %m/s

dist = velocity * time;

plot(time, dist)
xlabel('time')
ylabel('distance')



% Finite difference method
num_ite = total_time / dt; %1000

% creating arrays
position = zeros(num_ite,1);
etime = zeros(num_ite,1);

%initial conditions
position(1) = 0;
etime(1) = 0;

% simulate using for loop
for step = 1:num_ite-1
    position(step+1) = position(step) + velocity * dt;
    etime(step+1) = etime(step) + dt;
end

% plot the graph
figure
plot(etime,position)
xlabel('time')
ylabel('distance')

% combined graph of both the solutions comparing the two
figure
plot(time, dist, '+r', etime, position)
xlabel('time')
ylabel('distance')