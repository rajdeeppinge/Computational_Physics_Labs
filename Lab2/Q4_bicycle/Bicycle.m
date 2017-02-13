clear; 
close all;

% initializing
total_time = 300; %% length of simulation
init_vel = 12.5;
dt = 0.1;
niter = total_time / dt;

% declaring arrays
time = zeros(niter, 1);
speedr = zeros(niter, 1);

% initial values
time(1) = 0;
speedr(1) = init_vel;

mass = 75;
constant = .5;
density = 1.225;
area = 0.165:0.165e-3:0.5;
power = constant * density * init_vel * init_vel * init_vel * area;

figure
plot(area, power)

const_force = power / 5;

% for loop to simulate using finite difference method
for step=1:niter-1
    if(const_force*speedr(step) >= power)
        speedr(step+1) = speedr(step)+power*dt/ (mass*speedr(step)) - ( dt*constant*density*area*speedr(step)*speedr(step) )/(mass);
    else
        speedr(step+1) = speedr(step)+const_force*dt/mass;
    end
    
    time(step+1) = time(step) + dt;
end

% plotting the graph
figure
plot(time, speedr)
xlabel('time')
ylabel('speed')