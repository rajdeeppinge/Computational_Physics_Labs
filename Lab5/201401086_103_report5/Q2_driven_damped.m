clear;
close all;
% declare the pendulam variables to be global and set it

g = 9.8;
l = 9.8;

global omega_not;
omega_not = sqrt(g/l);

b = 0.02;              % critical case 2*l*sqrt(g/l);
m = 0.1;
global beta;
beta = b/(2*m);

global f0;
f0 = 1.5;

global omega_dri;

omega_dri_step = 0.1;
%omega_dri=0:omega_dri_step:(5*omega_not);


timescale = 2*pi*sqrt(l/g);
dt = timescale/100;

% set the initial and final times
%tstart = 0;


% set the initial conditions in the y0 column vector
u_init = zeros(2, 1);  
u_init(1) = 0.5; % initial position theta radians;
u_init(2) = 0; % initial velocity

omega_arr = 0.1:omega_dri_step:(5*omega_not);
%computationally finding the phase difference
phase_arr = zeros(length(omega_arr));
pointer = 1;
%time_diff_zero_crossing = 0;

global zero_time; global drive_f_time_period; global tfinal;


for omega_dri = 0.1:omega_dri_step:(5*omega_not)
    % call ode solver
    drive_f_time_period = 2*pi/omega_dri;
    
    tstart = 0;
    tfinal = 50*drive_f_time_period;
    dt = (tfinal-tstart)/500;
    
    options=odeset('RelTol',1e-8);
    [t,u]=ode45(@q2_ode_driven_damped, tstart:dt:tfinal, u_init, options);
    
    time_zero_crossing = zero_time;
    output_zero_crossing = 0;
    
    drive_f_dt = drive_f_time_period/50;
    
    for time = time_zero_crossing : drive_f_dt: (time_zero_crossing + drive_f_time_period)
        if( cos(omega_dri*time) > 0 && ( cos(omega_dri*(time+drive_f_dt) ) < 0) )
            output_zero_crossing = time;
            break;
        end
    end
    
    phase_arr(pointer) = ( (output_zero_crossing-time_zero_crossing) / drive_f_time_period) * 2*pi;

    if(phase_arr(pointer) >= 2*pi)
       phase_arr(pointer) = phase_arr(pointer) - 2*pi; 
    end
    
    pointer = pointer+1;

end

% plot the position vs. time
plot(omega_arr, phase_arr);
title('Phase angle observation')
xlabel('frequency of drivin force')
ylabel('phase angle between driving force and motion of pendulum')