% Code to replicate the given flow plot with the help of quiver and
% stramline functions of matlab

clear;
close all;

xarr = -10:1:10;  %array of x values
yarr = -10:1:10;  %array of y values

%Define the grid of arrays xarr and yarr
[x,y] = meshgrid(xarr, yarr);

%Velocity arrays vx and vy
vx = 0.2.*x.*x+0.5.*y.*y+20;
vy = -0.1.*y.*y.*y+0.5.*x.*x-10;

%Create a quiver plot to indicate the velocity at each node of the grid
figure
quiver(x, y, vx, vy, 'm')
xlabel('position in x')
ylabel('position in y')
title('flow plot')

%Generate a streamline plot with appropriate starting positions given by
% startx and starty
starty = -10:1:10;  % starting position array for x dimension
startx = -10.*ones(size(starty));   % starting position array for x dimension
streamline(x, y, vx, vy, startx, starty)