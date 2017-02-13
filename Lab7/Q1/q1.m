%problem 1 orbit simaulation of all planets
clear;
close all;
 
%define constants
global Ms;        % Mass of the sun
Ms = 1;           % taking unit of mass to be a solar mass unit
 
global G;         % universal gravitational constant
G = 4*pi*pi;      % converted in the form of units AU, years, solar mass unit
 
global R;         % length of semi-major axis of the orbit
global HalfTimePeriod;
global MajorAxisLength;
global x_init; global y_init;
global x_max;
 
 
num_planets = 7;
radius = [0.7233 1.0000 1.5237 5.2028 9.5388 19.191 30.061];
time_period = [0.6152 1.0000 1.8809 11.8600 29.4560 84.0700 164.8100];
 
expt_time_period = zeros(1,num_planets);
expt_radius = zeros(1,num_planets);
Kepler3LawRatio = zeros(1,num_planets);
eccentricity = zeros(1,num_planets) 

for i = 1:num_planets
    
    R = radius(i);            % in AU the distance between the earth and the sun 
 
    %%%%
    % An important observation
    % The nature of the orbit of the orbiting body does not depend on the mass
    % of the body
    % It only depends on initial velocity and the mass of the centrl body(star)
    % around which it rotates
    %%%%
 
    %global Me;       % Mass of the Earth
    %Me = 6e24/2e30;  % mass of the earth in solar mass units
    
    HalfTimePeriod = 0;     % in years
 
    MajorAxisLength = 0;    % in AU
 
    %initial position of planet
    x_init = R;
    y_init = 0;
 
 
    start_time = 0;
    total_time = 2.4*time_period(i);         %in years
    dt = total_time/100;
 
 
    % Initial velocity in AU/year
    v_init = 1.0001*sqrt(G*Ms/R);
    v_init_x = 0;
    v_init_y = v_init;
 
 
    %npoints=total_time/dt;
 
 
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
 
 
    % find a and b parameters of ellipse
    % a = semi-major axis
    % b = semi-minor axis
    a = ( max(x)-min(x) ) / 2;
    b = ( max(y)-min(y) ) / 2;
    
    %Time period (in years)
    expt_time_period(i) = HalfTimePeriod * 2;
 
    % Semi Major Axis (in AU)
    expt_radius(i) = MajorAxisLength / 2;
 
 
    Kepler3LawRatio(i) = ( expt_time_period(i)^2 ) / (expt_radius(i)^3);
 
 
    eccentricity(i) = abs(sqrt(1 - b*b/a*a));
    
    % to plot all of them on the same graph
    if (i ~= 1)
        hold on;
    end
 
    % plot the orbit of planet
    plot(x,y)
    title('Orbit of planet')
    xlabel('x-distance (in AU)')
    ylabel('y-distance (in AU)')
 
end
 
i=1:num_planets;
 
figure
plot(i, Kepler3LawRatio)
axis([1 7 0 2])
title('Verifying Kepler''s 3rd law')
xlabel('planet')
ylabel('Ratio (T^2/a^3)')
