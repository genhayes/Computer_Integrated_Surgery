% Testing functions for intersectionOfVectorWithPlane
% Genevieve Hayes
% CISC 330 - A1

function tests = test_intersectionOfVectorWithPlane
tests = functiontests(localfunctions);
end

function testParallelVectorAndPlane(testCase)
% Test case for vector that is parallel with plane
actSolution_Int = intersectionOfVectorWithPlane([0,0,0],[0,1,0],[0,1,0],[1,0,0]);
expSolution_Int = [NaN NaN NaN];
verifyEqual(testCase,actSolution_Int,expSolution_Int)
end

function testYdirectionVectorThroughXPlane(testCase)
% Test case for Y direction vector passing through X plane at x = 2
actSolution_Int = intersectionOfVectorWithPlane([0,0,0],[0,1,0],[2,-1,0],[0,2,0]);
expSolution_Int = [2 0 0];
verifyEqual(testCase,actSolution_Int,expSolution_Int)
end

function testYZdirectionVectorThroughXPlane(testCase)
% Test case for Y-Z direction vector passing through plane below X axis
actSolution_Int = intersectionOfVectorWithPlane([0,-1,0],[0,1,0],[1,-1,1],[0,1,1]);
expSolution_Int = [1 -1 1];
verifyEqual(testCase,actSolution_Int,expSolution_Int)
end
