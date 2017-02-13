function F = elevator_ode(t,u)

% In our case we will use:
% u(1) -> y
% u(2) -> vy

% declare the globals so its value set in the main script can be used here
global g_eff;

% make the column vector F
F = zeros(length(u), 1);

% dx/dt = v
F(1) = u(2);

% dv/dt = acceleration
F(2) = g_eff;