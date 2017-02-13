function F = ode_projectile(t,u) % @ symbol not required during definition, req during use.

% In our case we will use:
% u(1) -> x
% u(2) -> y
% u(3) -> vx
% u(4) -> vy

% declare the globals so its value
% set in the main script can be used here
global const
global acce_vehicle; 
global drag;
global m;
% make the column output vector F filled with zeros, so that it is
% initialized to same direction as our input col vec
F = zeros(length(u), 1);

if (u(2)<0) %proj under the ground doesn't make sense.
    return;
end
% Now build the elements of F
%
% so the equation dx/dt=v means that F(1)=u(2)
F(1) = u(3);
F(2) = u(4);
% Again, in our original ODEs we have:

vel_mag=sqrt(u(3)^2+u(4)^2);
% so the equation dv/dt=-....
F(3) =-acce_vehicle-(drag*vel_mag*u(3)/m); %should be -g

F(4) = -const-(drag*vel_mag*u(4)/m);

