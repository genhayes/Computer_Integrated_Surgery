% Genevieve Hayes
% CISC 330 - A1 Question 6

function [vector] = generateRandomUnitVector(dim)
%GENERATERANDOMUNITVECTOR generates a unit vector in a random direction in 
%2D or in 3D.
%[vector] = generateRandomUnitVector(dim) where dim = 2 or 3 for the
%dimension.

    theta_min = 0;
    theta_max = 2*pi;
    
    if dim == 2
        randTheta = (theta_max-theta_min).*rand(1,1) + theta_min; %generate a random number between 0 and 2*pi
        vector = [cos(randTheta), sin(randTheta)]; %construct unit vector in 2D
        vector = vector/norm(vector);
    elseif dim == 3
        randTheta = (theta_max-theta_min).*rand(1,1) + theta_min; %generate a random number between 0 and 2*pi
        z = (1-(-1)).*rand(1,1) + (-1); %generate a random number between -1 and 1
        vector = [sqrt(1-z.^2).*cos(randTheta), sqrt(1-z.^2).*sin(randTheta), z]; %construct unit vector in 3D
        vector = vector/norm(vector);
    else %dimension input not supported
        fprintf('Error: Dimension must be 2 or 3!\n');
end

