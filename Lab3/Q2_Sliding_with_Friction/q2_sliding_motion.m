function F = q2_sliding_motion(t, u);

% In our case we will use:
% u(1) -> x
% u(2) -> v
 
% declare the globals so its value
% set in the main script can be used here
global const 
global mu_s 
global theta

% make a zero column vector F of size of u
F = zeros(length(u), 1);

% dx/dt=v 
F(1) = u(2);

% the mass will start to slide only when theta > atan(mu_s) deg. Hence the
% motion is valid only for such angles. Hence, check this condition.
% if angle is less an the mass is initially moving then it would eventually
% come to rest. At that point stop the calculation
if(u(2) <= 0 && theta < atan(mu_s))
    return;
end

F(2) = const;