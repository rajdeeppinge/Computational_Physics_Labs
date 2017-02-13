% this code is used to plot the variation of the phase angle between
% driving force and the displacement motion as a function of the driving
% frequency. 

clear all;
close all;

global C mass l g beta Fd driver_angular_freq driver_time_period simulationt zero_crossing_time min_square_theta; 

g=9.8;
l=9.8; % so that g/l is 1

%natural angular_frequency is 1. We will run the code for driving_freq = 0
%to 5.

timescale=2*pi*sqrt(l/g);
mass = 0.1;
%we will be considering only the underdamped case.

C = 0.02 % C is the drag constant Fdamp = C*length*omega
beta = C/(2*mass);
Fd = 1.5 % this is the driving force

driver_angular_freq = 1; % its the angular frequency 

dt=timescale/100;
simulationt=50*timescale;
start_time = 0;

theta_degrees_initial = 0.5*180/pi; %given 0.5 radians
omega_initial = 0; 

%using ode solver
%give initial conditions

u0 = zeros(2,1);
u0(1) = theta_degrees_initial*pi/180;
u0(2) = omega_initial;

start_freq = 0.1;
end_freq = 5;
incremental_freq = 0.1;
 
frequency_array = start_freq : incremental_freq : end_freq ;
phase_array = zeros(length(frequency_array));
index = 1;

for driver_angular_freq = start_freq : incremental_freq : end_freq   

    min_square_theta = 500*500; %used in odesolver. Set to some high value
    driver_time_period = 2*pi / driver_angular_freq;
    %We don't need to run the solver for the same simulation time for each of the angular frequencies.

    % In fact as the frequency increases, the oscillations stabilise

    % relavively quickly and hence computational time reduces.

    % This property is utilised here and 2 end cases have been ised:

    % They are driver_angular_freq = 0.1 , stabilising time = 300s

    % driver_angular_freq = 5 , stabilising time = 60s

    simulationt = -48.979*driver_angular_freq + 304.897;                % for optimising the simulation time  
    [t,u] = ode45(@q2_phase_ode , [start_time : dt : simulationt] , u0);
    %we have the +ve slope zero crossing for the displacement motion graph.
    %search for the first zero crossing for the force after

    %zero_crossing_time
    time = zero_crossing_time;
    force_zero_crossing = 0;
    incremental_step = (driver_time_period/50);
    
    for t1 = time : incremental_step : (time + driver_time_period)
       if(cos(driver_angular_freq*t1) < 0 && (cos(driver_angular_freq*(t1 + incremental_step)) > 0) )
            force_zero_crossing = t1;
            break;
       end   
    end
    
    phase_array(index) = ((( - force_zero_crossing + zero_crossing_time)*2*pi)/driver_time_period) + 2*pi;

    if(phase_array(index) > 6.28)
        phase_array(index) = phase_array(index) - 2*pi;
    end  

    index = index + 1;

end 

plot(frequency_array , phase_array);
xlabel('frequency of driving force')
ylabel('phase angle between driving force and motion of pendulum')
title('Phase angle observation')