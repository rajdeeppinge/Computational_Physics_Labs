clear;
close all;

% declaring initial values and constants
global const;
global beta;
global b;
g=9.8;
k=1000;
m=1;

const=k/m;
beta=0;
b=2*m*beta;

timescale=2*pi*sqrt(m/k);
dt=timescale/100;

% set the initial and final times
tstart=0;
tfinal=10*timescale;

% set the initial conditions in the y0 column vector
u_init=zeros(2,1);  
u_init(1)=.2; % initial position theta radians
u_init(2)=0; % initial velocity

% calling ode solver
[t,u]=ode45(@q4_ode_springmass,[tstart:dt:tfinal],u_init);

% store the solution that comes back into x and v arrays
x = 180/pi * u(:,1); % radian-->degree
v = u(:,2);



% plot the position vs. time
plot(t,x)
title('spring mass oscillations');
xlabel('time');
ylabel('positionx');

% make a "phase-space" plot of v vs. x
figure
plot(x,v)
title('spring mass phase space');
xlabel('positionx');
ylabel('velocityx');
