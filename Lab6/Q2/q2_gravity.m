clear;
close all;

% constants
global Re
global Me
global G
global g
Re = 6.4e6;  %radius of earth meters
Me = 6e24;  %mass of earth kg
G = 6.67e-11;   %universal gravitational constant
g = 9.8;        %gravitational constant

v0 = 1000;     %initial velocity m/s

timescale = 250;
dt = timescale/50;

% set the initial and final times
tstart = 0;
tfinal = timescale;

% set the initial conditions
u0 = zeros(2,1);  
u0(1) = 0; % initial position
u0(2) = v0; % initial velocity

% set the solve options
options=odeset('RelTol',1e-8);
[t,u]=ode45(@q2_ode_solver,[tstart:dt:tfinal],u0,options);

% store the solution that comes back into x and v arrays

%Define the position arrays x and y
xarr = u(:,1);
yarr = 0.*ones(size(xarr));

%Define the velocity arrays vx and vy
vx = u(:,2);
vy = 0.*ones(size(vx));

loops =length(xarr);

%creating a structure to store frame data
F(loops) = struct('cdata',[],'colormap',[]);

for index = 1:length(xarr)
    plot(yarr(index), xarr(index), '.');
    xlabel('position in y')
    ylabel('position in x')
    title('movie')
    
    %storing each frame
    F(index)=getframe(gcf);
    hold on
    pause(0.01);

end

%creating movie objs
movarr(loops)=struct('cdata',[],'colormap',[]);
for index = 1:length(xarr)
    
    %converting each frame to a movie image
    [X,map]=frame2im(F(index));
    
    %building the movie arrayt
    movarr(index)=immovie(X,map);
end

%converting the movie into avi format
movie2avi(movarr, 'D:\SEMESTER_4\CS201_Introductory_Computational_Physics\Labs\201401103_86_Report_6\rocketsim.avi', 'compression', 'None');