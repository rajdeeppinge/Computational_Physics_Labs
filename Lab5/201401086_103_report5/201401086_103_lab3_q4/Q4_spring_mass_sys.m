clear;
close all;

global cnst;
global beta;
global b;
g=9.8;
k=1000;
m=1;

cnst=k/m;
beta=1;
b=2*m*beta;


timescale=2*pi*sqrt(m/k);
dt=timescale/100;

% set the initial and final times
tstart=0;
tfinal=10*timescale;

% set the initial conditions in the y0 column vector
u0=zeros(2,1);  
u0(1)=1; % initial position; %theta(1)=.2;
u0(2)=0; % initial velocity

% set the solve options
%options=odeset('RelTol',1e-8); %%%%%% Assignment to understand "options"
%[t,u]=ode45(@rhs,[tstart,tfinal],u0,options);
[t,u]=ode45(@q4_ode_springmass,[tstart:dt:tfinal],u0);

% store the solution that comes back into x and v arrays
x=u(:,1); % radian-->degree
v=u(:,2);
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
