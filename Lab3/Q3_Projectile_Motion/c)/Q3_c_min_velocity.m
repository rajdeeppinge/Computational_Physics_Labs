clear 
close all;

% declaring constants and initial values
total_time=100;
dt=0.1;
npoints = total_time/dt; 

global constx g mass B y0;
constx = 0;
g = 9.8;
mass = 1; %kg
B = 4e-5 * mass;
y0 = 1000;

range_x = 5e3;     % 5km
delta = 10;        % precision of 10 meters

flag = 0;

min_height = -2000;
max_height = 2000;
dh = 100;
height = [min_height : dh : max_height];

init_vel = 100;
max_vel = 600;
dv = 2;
min_vel = max_vel;
vel_arr = zeros( (max_height-min_height)/dh + 1, 1);

vx = zeros(npoints,1);
vy = zeros(npoints,1);

x = zeros(npoints,1);
y = zeros(npoints,1);
time = zeros(npoints,1);

init_theta = 0;
max_theta = 60;
d_theta = 1;

%loop
for height_y = min_height : dh : max_height
    for v = init_vel : dv : max_vel
        min_vel = max_vel;

        for theta_degree = init_theta : d_theta : max_theta
            theta = (pi/180) * theta_degree;    %in radians
            
            vx(1) = v * cos(theta);
            vy(1) = v * sin(theta);
            
            x(1) = 0;
            y(1) = 0;
            time(1) = 0;
            
            for step = 2 : npoints
                time(step) = time(step-1) + dt;
                x(step) = x(step-1) + vx(step-1) * dt;
                vx(step) = vx(step-1) - exp(-y(step-1)/y0) * (B / mass) * vx(step-1) * sqrt(vx(step-1)^2 + vy(step-1)^2) * dt;
                y(step) = y(step-1) + vy(step-1) * dt;
                vy(step) = vy(step-1) - g * dt - exp(-y(step-1)/y0) * (B / mass) * vy(step-1) * sqrt(vx(step-1)^2 + vy(step-1)^2) * dt;
                
                if( ((range_x - x(step))^2 + (height_y - y(step))^2) < delta^2 )
                    if( v < min_vel )
                        min_vel = v;
                        flag = 1;
                    end
                    break;
                end
            end
            
            if(flag == 1)
                break;
            end
        end
        
        if(flag == 1)
            flag = 0;
            break;
        end
    end
    
    vel_arr( (height_y/dh) + 1 - (min_height/dh) ) = min_vel;
end

% plotting graph
plot(height, vel_arr)
title('graph for minimum velocity vs height')
xlabel('height')
ylabel('minimum velocity')