function F=q2_ode_solver(t,u)
% In our case we will use:
% u(1) -> x
% u(2) -> vx

% constants
global Re
global Me
global G
global g

F=zeros(length(u),1);

%plot(0, u(1), 'o')
%hold on
%axis([0 10 -15 1500])
%pause(.1)

%to stop the motion below x=0
if(u(1) < 0)
    return;
end

F(1) = u(2);

F(2) = - ( G*Me )/( (u(1)+Re)*(u(1)+Re) );