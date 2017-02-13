clear;
close all;

dt = 1e-4;
total_time = 1;

etime = 0:dt:total_time; %time array

init_population = 1; 
a = 10;  %increase factor
b = 3; %decrease factor

num_ite = total_time/dt; % number of iterations = 1000



% Exact solution

%let us see if formula is correct for exact solution
%epopulation = 10 * init_population * exp(10 * etime) / (10 - 3 * init_population * (1 - exp(10 * etime) ) );
const = log(init_population/(a-(b*init_population)))/a;
epopulation = zeros(num_ite+1,1);

for j = 1:(num_ite+1)
    epopulation(j) = a*( exp( a*(etime(j)+const) ) )/( 1+b*exp( a*( etime(j)+const ) ) );
end

%plotting the graph for exact solution
plot(etime,epopulation)
xlabel('time')
ylabel('population')


% Finite difference method

%initializing arrays
population = zeros(num_ite,1);
time = zeros(num_ite,1); %arrays made

%initial conditions
population(1) = init_population;
time(1) = 0;

for step=1:num_ite-1
    population(step+1) = population(step) + ( a * population(step) - b * ( population(step) * population(step) ) ) * dt;
    time(step+1) = time(step) + dt;
end

% plotting the graph for finite difference method
figure
plot(time, population)
xlabel('time')
ylabel('popualtion')

% combined graph comparing the two solutions
figure
plot(etime, epopulation, '+r', time, population)
xlabel('time')
ylabel('population')
