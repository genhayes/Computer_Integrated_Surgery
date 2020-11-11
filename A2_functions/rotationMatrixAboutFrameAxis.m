% Genevieve Hayes
% CISC 330 - A1 Question 8

function [R3by3,R4by4] = rotationMatrixAboutFrameAxis(axis,angle)
%ROTATIONMATRIXABOUTFRAMEAXIS Generates a transformation matrix to rotate a
%point about one of the (x,y,z) frame axes by a given rotation angle in both 
%3x3 and 4x4 form.
%[R3by3,R4by4] = rotationMatrixAboutFrameAxis(axis,angle) where axis is
%1,2,3 for x,y,z respectively and angle is in degrees and is counterclockwise 
%if looking in the negative direction.

t = angle;

if axis == 1; %rotation about x-axis
    R3by3 = [1 0 0; 0 cosd(t) sind(t); 0 -sind(t) cosd(t)];
    R4by4 = [1 0 0 0; 0 cosd(t) sind(t) 0; 0 -sind(t) cosd(t) 0;0 0 0 1];
elseif axis == 2; %rotation about y-axis
    R3by3 = [cosd(t) 0 -sind(t); 0 1 0; sind(t) 0 cosd(t)];
    R4by4 = [cosd(t) 0 -sind(t) 0; 0 1 0 0; sind(t) 0 cosd(t) 0;0 0 0 1];
elseif axis == 3; %rotation about z-axis
    R3by3 = [cosd(t) sind(t) 0; -sind(t) cosd(t) 0; 0 0 1];
    R4by4 = [cosd(t) sind(t) 0 0; -sind(t) cosd(t) 0 0; 0 0 1 0; 0 0 0 1];
else
    fprintf('Error: Unsupported axis. Axis must be 1, 2 or 3 (for x,y,z).\n');
end
end

