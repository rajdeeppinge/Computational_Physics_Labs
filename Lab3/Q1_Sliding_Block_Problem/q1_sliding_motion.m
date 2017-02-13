function F = q1_sliding_motion(t, u);
 
% In our case we will use:
% u(1) -> x
% u(2) -> v
 
% declare the globals so its value
% set in the main script can be used here
global const;
 
% make a zero column vector F of size of u
F = zeros(length(u), 1);
 
% dx/dt=v means that F(1)=u(2)
F(1) = u(2);
% dv/dt=-g * sin(theta)
F(2) = const;