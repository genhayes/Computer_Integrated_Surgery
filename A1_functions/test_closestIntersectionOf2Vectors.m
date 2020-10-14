% Testing functions for intersectionOfVectorWithPlane
% Genevieve Hayes
% CISC 330 - A1

function tests = test_closestIntersectionOf2Vectors
tests = functiontests(localfunctions);
end

function testParallelUnitVectors(testCase)
% Test case of 2 parallel vectors
[actSolution_M, actSolution_dM] = closestIntersectionOf2Vectors([0,0,0],[0,1,0],[1,0,0],[0,1,0]);
expSolution_M = [NaN NaN NaN];
expSolution_dM = [NaN NaN NaN];
verifyEqual(testCase,actSolution_M,expSolution_M)
verifyEqual(testCase,actSolution_dM,expSolution_dM)
end

function testIntersectingXYPerpendicularVectors(testCase)
% Test case of perpendicular vectors which intersect at y = 2
[actSolution_M, actSolution_dM] = closestIntersectionOf2Vectors([0,0,0],[0,4,0],[-2,2,0],[4,0,0]);
expSolution_M = [0 2 0];
expSolution_dM = [0 0 0];
verifyEqual(testCase,actSolution_M,expSolution_M)
verifyEqual(testCase,actSolution_dM,expSolution_dM)
end

function testNonIntersectionXYZVectors(testCase)
% Test case of vectors that do not intersect with closest intersection
% occuring when L1 = [0,0,0] and L2 = [1,0,0]. Half this difference is
% [0.5,0,0] with error [0.5,0,0]
[actSolution_M, actSolution_dM] = closestIntersectionOf2Vectors([0,-1,0],[0,1,0],[1,0,0],[0,0,1]);
expSolution_M = [0.5 0 0];
expSolution_dM = [0.5 0 0];
verifyEqual(testCase,actSolution_M,expSolution_M)
verifyEqual(testCase,actSolution_dM,expSolution_dM)
end
