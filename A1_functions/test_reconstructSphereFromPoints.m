% Testing functions for intersectionOfVectorWithPlane
% Genevieve Hayes
% CISC 330 - A1

function tests = test_reconstructSphereFromPoints
tests = functiontests(localfunctions);
end

function testOriginUnitSphere(testCase)
% Test case for unit sphere centered at the origin with 20x20 patches
[X,Y,Z] = sphere; 
pointsMatrix = [reshape(X,[],1),reshape(Y,[],1),reshape(Z,[],1)]; %Build matrix of points using flattened X,Y,Z 

[actSolution_C, actSolution_R] = reconstructSphereFromPoints(pointsMatrix);
expSolution_C = [0 0 0];
expSolution_R = 1;
verifyEqual(testCase,actSolution_C,expSolution_C)
verifyEqual(testCase,actSolution_R,expSolution_R)
end

function testXYShiftedUnitSphere(testCase)
% Test case for unit sphere centered at (1,1,0) with 20x20 patches
[X,Y,Z] = sphere; 
pointsMatrix = [reshape(X,[],1)+1,reshape(Y,[],1)+1,reshape(Z,[],1)]; %Build matrix of points using flattened X,Y,Z 

[actSolution_C, actSolution_R] = reconstructSphereFromPoints(pointsMatrix);
expSolution_C = [1 1 0];
expSolution_R = 1;
verifyEqual(testCase,actSolution_C,expSolution_C)
verifyEqual(testCase,actSolution_R,expSolution_R)
end

function testXYZShiftedSphereWithR5(testCase)
% Test case for sphere with radius 5 centered at (3,3,3) with 20x20 patches
[X,Y,Z] = sphere; 
pointsMatrix = [reshape(X,[],1).*5+3,reshape(Y,[],1).*5+3,reshape(Z,[],1).*5+3]; %Build matrix of points using flattened X,Y,Z 

[actSolution_C, actSolution_R] = reconstructSphereFromPoints(pointsMatrix);
expSolution_C = [3 3 3];
expSolution_R = 5;
verifyEqual(testCase,actSolution_C,expSolution_C)
verifyEqual(testCase,actSolution_R,expSolution_R)
end
