clear;
close all;

%anaytically the relation between the angle made with horizontal and
%acceleration can be derived.

%plot of the angle obtained with values of acceleration in the horizontal
%direction.

nObs=1000;
g=9.8;
theta=zeros(1,nObs);

for ax=1:nObs
    
    %plot theta in degrees.
    theta(ax)=atan(ax/g);
    theta(ax)=theta(ax)*180/pi; %convert to degrees.
    
end

plot(1:nObs,theta)
title('Angle made with the vertical against acceleration of the frame');
xlabel('acceleration');
ylabel('angle in degrees');