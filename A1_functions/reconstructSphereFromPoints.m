% Genevieve Hayes
% CISC 330 - A1 Question 5

function [C,R] = reconstructSphereFromPoints(pointsMatrix)
%RECONSTRUCTSPHEREFROMPOINTS reconstructs the best fitting sphere in 3D from
%a set of points using least square optimization.
%[C,R] = reconstructSphereFromPoints(pointsMatrix) where pointsMatrix has to 
%contain 3 columns and at least 4 rows; the first column with Xs, 2nd 
%column with Ys and 3rd columns with Zs for the sphere to be fit to.
%Ouptuts are rounded to 5 decimal places.

x_vals = pointsMatrix(:,1); %extract x values
y_vals = pointsMatrix(:,2); %extract y values
z_vals = pointsMatrix(:,3); %extract z values

AA = [-2*x_vals, -2*y_vals , -2*z_vals , ones(size(x_vals))];
BB = [-(x_vals.^2+y_vals.^2+z_vals.^2)];
YY = mldivide(AA,BB); %Trying to solve AA*YY = BB

C = YY(1:3)';
D = YY(4); % D^2 = C(1)^2 + C(2)^2 + C(3)^2 -r^2(where C(1), C(2), C(3) are the center coordinates of the sphere)
R = sqrt((C(1)^2+C(2)^2+C(3)^2)-D);

%define precision
numDecimals = 5; %round to 5 decimal places
f = 10.^numDecimals;
C = round(f*C)/f;
R = round(f*R)/f;
end

