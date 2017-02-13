function F = q3_projectile_ideal(t, u);

% In our case we will use:
% u(1) -> x
% u(2) -> y
% u(3) -> vx
% u(4) -> vy

% declare the globals so its value
% set in the main script can be used here
global constx
global R
global consty

% make the column vector F with length equal to u
F = zeros(length(u), 1);

%if the height from ground becomes <= 0 the motion must end
if u(2) < 0
    return;
end

% Now build the elements of F
% dx/dt=vx and dy/dt=vy
F(1) = u(3);
F(2) = u(4);

% finding dvx/dt and dvy/dt
F(3) = constx;
F(4) = -consty * (1 - 2 * u(2) / R);