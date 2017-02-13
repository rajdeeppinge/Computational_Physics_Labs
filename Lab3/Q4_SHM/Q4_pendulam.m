clear;
close all;

% declaring initial values and constants
global const;
global beta;
global b;
g=9.8;
l=1;
const=g/l;
beta=0;
b=2*l*beta;

timescale=2*pi*sqrt(l/g);
dt=timescale/100;

% set the initial and final times
tstart=0;
tfinal=10*timescale;

% set the initial conditions
u_init=zeros(2,1);  
u_init(1)=.2; % initial position theta radians
u_init(2)=0; % initial velocity

% calling ode solver
[t,u]=ode45(@q4_pendulumodefunction,[tstart:dt:tfinal],u_init);

% store the solution that comes back into x and v arrays
x = pi/180 *u(:,1); % radian-->degree
v = u(:,2);



% plot graphs
plot(t,x)
title('pendulum');
xlabel('time');
ylabel('positionx');

figure
plot(x,v)
title('pendulum phase space');
xlabel('positionx');
ylabel('velocityx');