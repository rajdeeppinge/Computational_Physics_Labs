function F = q3_b_ode_air_drag_density(t, u);

% In our case we will use:
% u(1) -> x
% u(2) -> y
% u(3) -> vx
% u(4) -> vy
% u(5) -> init_vel;
% u(6) -> wind_vel_x;
% u(7) -> wind_vel_y;


% declare the globals so its value
% set in the main script can be used here
global constx;
global g;
global B;
global y0;
global mass;

% make the column vector F with length equal to u
F = zeros(length(u), 1);

%if the height from ground becomes <= 0 the motion must end
if u(2) < 0
    return;
end

% Now build the elements of F
% dx/dt=vx and dy/dt = vy
F(1) = u(3);
F(2) = u(4);

% finding dvx/dt and dvy/dt
F(3) = constx - exp(-u(2)/y0) * (B / mass) * (u(3) / sqrt(u(3)^2 + u(4)^2)) * ((u(3)+u(6))^2 + (u(4)+u(7))^2);
F(4) = -g - exp(-u(2)/y0) * (B / mass) * (u(4) / sqrt(u(3)^2 + u(4)^2)) * ((u(3)+u(6))^2 + (u(4)+u(7))^2);