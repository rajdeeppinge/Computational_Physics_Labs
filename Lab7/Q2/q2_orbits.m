%problem 2 elliptical orbits and other orbital parameters
clear;
close all;
 
%define constants
global Ms;        % Mass of the sun
Ms = 1;           % taking unit of mass to be a solar mass unit
 
global R;         % length of semi-major axis of the orbit
R = 1;            % in AU the distance_from_centre between the earth and the sun 
 
global Me;       % Mass of the Earth
Me = 3.0035e-6;  % mass of the earth in solar mass units
 
global G;         % universal gravitational constant
G = 4*pi*pi;      % converted in the form of units AU, years, solar mass unit
 
global HalfTimePeriod;
HalfTimePeriod = 0;     % in years
 
global MajorAxisLength;
MajorAxisLength = 0;    % in AU
 
%initial position of planet
global x_init; global y_init;
x_init = R;
y_init = 0;
 
% Initial velocity in AU/year
v_init = 1.2*2*pi;
v_init_x = 0;
v_init_y = v_init;
 
start_time = 0;
total_time = 2.4;         %in years
dt = total_time/1000;
  
npoints=total_time/dt;
  
% set the initial and final time
tstart = start_time;
tfinal = total_time;
 
% set the initial conditions in the y0 column vector
u0 = zeros(4,1);  
u0(1) = x_init;         % initial position in x-direction
u0(2) = y_init;         % initial position in y-direction
u0(3) = v_init_x;       % initial velocity in x-direction
u0(4) = v_init_y;       % initial velocity in y-direction
 
% ode solver function call
options = odeset('RelTol',1e-8);
[t,u] = ode45(@q1_ode, [tstart:dt:tfinal], u0, options);
 
% store the solution which determines the motion of planet
x = u(:,1);
y = u(:,2);
vx = u(:,3);
vy = u(:,4);
 
 
%Time period (in years)
T = HalfTimePeriod * 2
 
% Semi Major Axis (in AU)
a = MajorAxisLength / 2
  
Kepler3LawRatio = (T*T)/(a*a*a)
 
% plot the orbit of planet
plot(x,y)
title('Orbit of planet')
xlabel('x-distance_from_centre (in AU)')
ylabel('y-distance_from_centre (in AU)')


% To see the variation in kinectic energy w.r.t. time and verify if total
% energy is same or not.
% units of energy SI -> kg*m^2/sec^2 
% converted to Solar mass unit * AU^2 / year^2

kinetic_energy = zeros(1, length(x));   %length as many points as returned by the array
potential_energy = zeros(1, length(x));
total_energy = zeros(1, length(x)); 

theta = zeros(1, length(x));
distance_from_centre = zeros(1, length(x));
velocity_magnitude = zeros(1, length(x));

for loop = 1 : length(total_energy)
    distance_from_centre(loop) = sqrt( x(loop)^2+ y(loop)^2 ); 
    
    velocity_magnitude(loop) = sqrt( vx(loop)^2 + vy(loop)^2 );
    
    kinetic_energy(loop) = 1/2 * Me * (velocity_magnitude(loop)^2);
    potential_energy(loop) = - G * Ms * Me / distance_from_centre(loop);
    total_energy(loop) = kinetic_energy(loop) + potential_energy(loop);     
end

% plot kinetic energy vs time
figure
plot(t, kinetic_energy.*1e5)
title('Kinetic energy plot')
xlabel('time')
ylabel('kinetic energy ( * 1e-5 )')

% plot potential energy vs time
figure
plot(t, potential_energy.*1e5)
title('Potential energy plot')
xlabel('time')
ylabel('potential energy ( * 1e-5 )')

% plot potential energy vs time
figure
plot(t, total_energy.*1e5)
axis([0 2.4 -10 10])
title('Total energy plot')
xlabel('time')
ylabel('total energy ( * 1e-5 )')

%figure
%plot(theta, velocity_magnitude);
%figure
%plot(distance_from_centre, velocity_magnitude);

% find a and b parameters of ellipse
% a = semi-major axis
% b = semi-minor axis
a = ( max(x)-min(x) ) / 2;
b = ( max(y)-min(y) ) / 2;

% to see the magnitude of velocity at each instant, we use the quiver plot
figure
quiver(x, y, vx, vy);

%now let us find the apporox area swept in time dt at four different locations
% area = 0.5*r*r*d_theta
area1 = abs(0.5*( x(floor(length(x)/4))^2+y(floor(length(x)/4))^2 ) * ( atan(y(floor(length(x)/4)+1)/x(floor(length(x)/4)+1)) - atan((floor(length(x)/4))/(floor(length(x)/4))) ))
area2 = abs(0.5*( x(floor(length(x)/3))^2+y(floor(length(x)/3))^2 ) * ( atan(y(floor(length(x)/3)+1)/x(floor(length(x)/3)+1)) - atan((floor(length(x)/3))/(floor(length(x)/3))) ))
area3 = abs(0.5*( x(floor(length(x)/2))^2+y(floor(length(x)/2))^2 ) * ( atan(y(floor(length(x)/2)+1)/x(floor(length(x)/2)+1)) - atan((floor(length(x)/2))/(floor(length(x)/2))) ))
area4 = abs(0.5*( x(3*floor(length(x)/4))^2+y(3*floor(length(x)/4))^2 ) * ( atan(y(3*floor(length(x)/4)+1)/x(3*floor(length(x)/4)+1)) - atan((3*floor(length(x)/4))/(3*floor(length(x)/4))) ))


% Here we find the area swept by the planet in certain time interval
area_in_given_time = 0;
for time = 1 : length(t)-1
    curr_radius = sqrt(x(time)^2+y(time)^2);
    
    dtheta = abs( (atan(y(time+1)/x(time+1)) - atan(y(time)/x(time)) ) *(180/pi) );  % in degrees
    area_in_given_time = area_in_given_time + (1/2 * (curr_radius^2) * dtheta);
    
    %dtheta = abs((atan(y(floor(length(x)/4)+1)/x(floor(length(x)/4)+1)) - atan(y(floor(length(x)/4))/x(floor(length(x)/4))))*(180/pi) )  % in degrees
    %number_of_slices = 360 / dtheta
    %area_in_1_year = abs(area1 * number_of_slices * total_time)
end

area_in_given_time/100  % divided by 100 since a factor of 100 was considered in the above calculation in the loop 

%analytical area of ellipse
area_analytical = pi * a * b 