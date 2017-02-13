clear;
close all;

%state the parameters
global g;
g = -9.8;   % gravitational acceleration -> convention is negativein downward direction

global acce_vehicle; %acceleration of the vehicle.;
acce_vehicle = 5;

m = 1;      %mass of projectile 

theta_degree = 1;       % angle of projection
%theta = theta_degree * pi/180; 

init_vel = 50;          % initial velocity

total_time = 100;       % total time

tstart = 0;
tfinal = total_time;
dt = total_time / 1000;

%we will need two ode's one for the projectile and one for the vehicle.

%now we define the ode for the vehicle.
%u1=zeros(2,1);  
%u1(1)=0;        % initial position of vehicle in x
%u1(2)=0;        % init vel of pos in x

% set the solve options
%options = odeset('RelTol', 1e-8); 
%[tv, uv] = ode45(@ode_vehicle, [tstart : dt : tfinal], u1, options);

%x_vehi = uv(:, 1);
%v_vehi = uv(:, 2);
%y_vehi = zeros(1,length(x_vehi));


for theta_degree = 1 : 90
    
    theta = theta_degree * pi/180;
    ux = init_vel * cos(theta);
    uy = init_vel * sin(theta);
    
    % set the initial conditions in the y0 column vector
    u0 = zeros(4, 1);  
    u0(1) = 0; % initial position of the projectile
    u0(2) = 0;
    u0(3) = ux; % initial velocity of the pendulum
    u0(4) = uy;
    
    % set the solve options
    options = odeset('RelTol', 1e-8); 
    [t,u] = ode45(@ode_projectile, [tstart : dt : tfinal], u0, options);

    %extracting data from the ode solver output
    x_pos = u(:, 1);
    y_pos = u(:, 2);
    vx_vel = u(:, 3);
    vy_vel = u(:, 4);
    
    for loop = 1 : length(x_pos)

        %find the point of catching or impact.
        distance = sqrt( (x_pos(loop))^2 + (y_pos(loop))^2 );

        if vy_vel(loop) < 0 && distance < 1
            %impact = x_vehi(loop)
            check = x_pos(loop)
            check1 = y_pos(loop)
            timeofimpact = t(loop)
            angleneeded = theta_degree

            figure
            plot(x_pos, y_pos)
            figure
            plot(t, x_pos)
            figure
            plot(t, y_pos)

            break
        end
    end 
end