clear;
close all;
 
%initial conditions
global Bx; global By; global Bz;
Bx =5e-5; By =0 ; Bz =0;
 
global Ex; global Ey; global Ez;
Ex = 0; Ey =0; Ez =0;
 
global q;
q = 1.6e-19;
 
 
 
global m;
m =9.1e-31; %we have taken the actual mass of an electron, have NOT made
%the assumption that q/m is 1.
 
k=1.38e-23;
T=1000;
v_thermal=sqrt(k*T/m);
total_time =2e-6;
global dt; %note dt about 100 times lower than tot_time is reasonable.
global counter;
counter=0;
 
dt = 0.99e-9;
 
x = 0;
y = 0;
z = 300e3; %later can take into consideration the change in g with h.
vx =0;
vy =0;
vz =v_thermal;
 
global cyclo_time;
 
cyclo_freq=q*Bx/(2*pi*m);
cyclo_time=1/cyclo_freq;
 
% set the initial and final times
global tstart;
global tfinal;
 
tstart=0;
tfinal=total_time;
% set the initial conditions in the y0 column vector
global x_init;global y_init; global z_init;
 
z_init=z;  x_init=x; y_init=y;
global comp_radius;
comp_radius=0;
global comp_freq;
comp_freq=0;
 
u_init = zeros(6,1);  
u_init(1) = x; % initial position; %theta(1)=.2;
u_init(2) = y; % initial velocity
u_init(3) = z;
u_init(4) = vx;
u_init(5) = vy;
u_init(6) = vz;
 
options=odeset('RelTol',1e-5); %we have used options for the ode,
                               %check what are its implications
[t,u] = ode45(@q3_ode_drift_vel,[tstart:dt:tfinal],u_init,close);
 
% store the solution that comes back into x and v arrays
pos_x = u(:,1);
pos_y = u(:,2);
pos_z = u(:,3);
vel_x = u(:,4);
vel_y = u(:,5);
vel_z = u(:,6);
 
plot3(pos_x,pos_y,pos_z)