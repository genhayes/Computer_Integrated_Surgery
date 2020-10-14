% Testing functions for generateRandomUnitVector
% Genevieve Hayes
% CISC 330 - A1

function tests = test_generateRandomUnitVector
tests = functiontests(localfunctions);
end

function testandPlot2Dand3DRandomUnitVector(testCase)
%Plots 2D generated random unit vectors and 3D generated random unit vectors
n_iter = 200; %define the number of vectors to generate
vectors2D = zeros(2,n_iter);
vectors3D = zeros(3,n_iter);

for i=1:n_iter
    vectors2D(:,i) = generateRandomUnitVector(2);
    vectors3D(:,i) = generateRandomUnitVector(3);
end

origin = zeros(1,n_iter);

%Verify that the length of each vector is 1
actSolution_2D = vectors2D(1,1)^2 + vectors2D(2,1)^2;
actSolution_3D = vectors3D(1,1)^2 + vectors3D(2,1)^2 + vectors3D(3,1)^2;
expSolution_2D = 1;
expSolution_3D = 1;

Ndecimals = 3;
f = 10.^Ndecimals;
actSolution_2D = round(f*actSolution_2D)/f;
actSolution_3D = round(f*actSolution_3D)/f;

verifyEqual(testCase,actSolution_2D,expSolution_2D)
verifyEqual(testCase,actSolution_3D,expSolution_3D)

%Plot 2D on unit circle
figure(1);
hold on;
title('2D Random Unit Vector Figure')
q = quiver(origin,origin,vectors2D(1,:),vectors2D(2,:));
hold off;

%Plot 3D on unit sphere
figure(2);
hold on;
title('3D Random Unit Vector Figure')
q3 = quiver3(origin,origin,origin,vectors3D(1,:),vectors3D(2,:),vectors3D(3,:));
hold off;
end

