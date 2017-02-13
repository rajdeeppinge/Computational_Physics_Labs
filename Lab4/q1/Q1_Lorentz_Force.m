clear;
close all;

%initial conditions
global Bx; global By; global Bz;    %magnetic field
Bx = 0; By = 1 ; Bz = 0; 

global Ex; global Ey; global Ez;    %electric field
Ex = 0; Ey = 0; Ez = 0;

global q;               %charge
q = 1.6e-19;

global g;               %gravitational constant
global m;               %mass of particle
m = 9.1e-31;
g=9.8;

%time scale
total_time = 100;
dt = 10;

%initial position
x = 0;
y = 0;
z = 0;

%initial velocity
vx = 1;
vy = 0;
vz = 1;

% set the initial and final times
tstart=0;
tfinal=total_time;

% set the initial conditions in the y0 column vector
u_init = zeros(6,1);  
u_init(1) = x;
u_init(2) = y;
u_init(3) = z;
u_init(4) = vx;
u_init(5) = vy;
u_init(6) = vz;

%solving using ode-solver
options=odeset('RelTol',1e-5);
[t,u] = ode45(@q1_ode_lorentz_force, [tstart:dt:tfinal], u_init, options);

% store the solution that comes back into x and v arrays
pos_x = u(:,1);
pos_y = u(:,2);
pos_z = u(:,3);
vel_x = u(:,4);
vel_y = u(:,5);
vel_z = u(:,6);

plot3(pos_x,pos_y,pos_z)
xlabel('X axis')
ylabel('Y axis')
zlabel('Z axis')
title('motion under constant and uniform magnetic field')