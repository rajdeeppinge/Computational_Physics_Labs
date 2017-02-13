clear;
close all;

%initial conditions
global Bx; global By; global Bz;
Bx = 5e-5; By = 0; Bz = 0;           %Earth's magnetic field is constant and is taken in x-direction

global Ex; global Ey; global Ez;
Ex = 0; Ey = 0; Ez = 0;              %Electric field is zero

global q;               %charge of electron
q = -1.6e-19;
global m;               %mass of electron
m = 9.1e-31;
global g
g = 9.8;

k = 1.38e-23;             %Boltzmann's constant
T = 1000;                 %Temperature in kelvin
v_thermal = sqrt(k*T/m);  %Thermal velocity

%time scale
total_time = 1e-6;       
dt = 1e-9;

%initial position
x = 0;
y = 0;
z = 300e3;          %in z-direction 300km above surface

%initial velocity
vx = 0;
vy = 0;
vz = v_thermal;

%Analytical solution

%cyclotron frequency
cyclo_freq = abs(q)*Bx/(2*pi*m)

%time period
global cyclo_time;
cyclo_time = 1/cyclo_freq

%cyclotron radius
cyclo_rad = m*v_thermal/(abs(q)*Bx)



%Computational result

% set the initial and final times
tstart = 0;
tfinal = total_time;

% set the initial conditions in the y0 column vector
global x_init; global y_init; global z_init;
z_init = z;  x_init = x; y_init = y;           %storing the initial values

%variables to find maximum distance from which we get radius as well as the
%half time of one complete revolution
global max_dist;
max_dist = -1;
global half_time;
half_time = 0;

u_init = zeros(6,1);  
u_init(1) = x;
u_init(2) = y; 
u_init(3) = z;
u_init(4) = vx;
u_init(5) = vy;
u_init(6) = vz;

options=odeset('RelTol',1e-5);
[t,u] = ode45(@q2_ode_cyclotron, [tstart:dt:tfinal], u_init, options);

% store the solution that comes back into x and v arrays
pos_x = u(:,1);
pos_y = u(:,2);
pos_z = u(:,3);
vel_x = u(:,4);
vel_y = u(:,5);
vel_z = u(:,6);


%finding radius and frequency computationally
comp_radius = max_dist / 2
comp_time = half_time * 2
comp_freq = 1 / comp_time

%plotting the graph
plot3(pos_x,pos_y,pos_z)
xlabel('X axis')
ylabel('Y axis')
zlabel('Z axis')
title('Cyclotron motion of electron')
