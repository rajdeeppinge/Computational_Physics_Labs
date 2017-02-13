clear;
close all;

%state the parameters
g = 9.8;
 
thetadeg = 7;
theta = thetadeg*pi/180; 
init_vel = 10;
tstart = 0;
tfinal = 10;
dt = 0.1;

global drag;
drag=10;

global m;
m = 1; %mass of projectile

%we will need two ode's one for the projectile and one for the vehicle.
global acce_vehicle; %acceleration of the vehicle.;
global const;

acce_vehicle =10;
const = g;

%find the point of catching or impact.

%now we define the ode for the vehicle.

u1=zeros(2,1);  
u1(1)=0; % initial position of vehicle in x
u1(2)=0; % init vel of pos in x

% set the solve options
options = odeset('RelTol',1e-8); 
%[t,u]=ode45(@rhs,[tstart,tfinal],u0,options);
[tv, uv] = ode45(@ode_vehicle,[tstart:dt:tfinal],u1);
%hold on;
x_vehi = uv(:, 1);
v_vehi = uv(:, 2);
y_vehi = zeros(1, length(x_vehi));
%plot(x_vehi,y_vehi);

for thetadeg=1:90
    
    theta = thetadeg*pi/180;
    ux = init_vel * cos(theta);
    uy = init_vel * sin(theta);
    % set the initial conditions in the y0 column vector
    u0=zeros(4,1);  
    u0x(1)=0; % initial position of the projectile
    u0(2)=0;
    u0(3)=ux; % initial velocity of the pendulum
    u0(4)=uy;
    % set the solve options
    options=odeset('RelTol',1e-8); 
    %[t,u]=ode45(@rhs,[tstart,tfinal],u0,options);
    [t,u]=ode45(@ode_projectile,[tstart:dt:tfinal],u0);

    %extracting data from the ode solver output
    x_pos = u(:, 1);
    y_pos = u(:, 2);
    %plot(x_pos,y_pos)
    %hold on
    %plot(t,x_pos)
    %plot(t,y_pos)
    vx_vel = u(:, 3);
    vy_vel = u(:, 4);

    %plot(x_pos,y_pos); %plot of the projectile relative to the vehicle.
    %title('Trajectory of the projectile as seen in the reference frame of the vehicle');
    %xlabel('x');
    %ylabel('y');

    for loop=1:length(x_pos)

        distance=sqrt((x_pos(loop)-x_vehi(loop))^2+ ((y_pos(loop)-y_vehi(loop)))^2);

        if vy_vel(loop)<0 && distance<0.5
            impact=x_vehi(loop)
            check=x_pos(loop)
            check1=y_pos(loop)
            timeofimpact=t(loop)
            angleneeded=thetadeg

            figure
            plot(t,x_vehi)
            xlabel('time')
            ylabel('vehicle x position')
            title('vehicle movement')
            
            figure
            plot(t,x_pos)
            xlabel('time')
            ylabel('projectile x position')
            title('projectile x movement')

            figure
            plot(x_pos, x_vehi)
            xlabel('projectile x position')
            ylabel('vehicle x position')
            title('comparison movement')

            figure
            plot(x_pos,y_pos);
            xlabel('projectile x position')
            ylabel('projectile y position')
            title('trajectory of the particle in the with respect to the vehicle')

            figure
            plot(x_pos,vx_vel);
            xlabel('projectile x position')
            ylabel('projectile x velocity')
            title('phase space plot of the projectile with reference to the vehicle')

            break
        end
    end
end
 
