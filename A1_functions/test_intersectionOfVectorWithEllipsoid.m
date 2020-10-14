% Testing functions for intersectionOfVectorWithEllipsoid
% Genevieve Hayes
% CISC 330 - A1

function tests = test_intersectionOfVectorWithEllipsoid
tests = functiontests(localfunctions);
end

function testTwoIntersectionsOfVectorWithEllipsoid(testCase)
% Test the case of 2 intercepts with ellipsoid
[actSolution_numInt, actSolution_Int1, actSolution_Int2] = intersectionOfVectorWithEllipsoid([0,-2,0],[0,4,0],1,1,1);
expSolution_numInt = [2];
expSolution_Int1 = [0 -1 0];
expSolution_Int2 = [0 1 0];
verifyEqual(testCase,actSolution_numInt,expSolution_numInt)
verifyEqual(testCase,actSolution_Int1,expSolution_Int1)
verifyEqual(testCase,actSolution_Int2,expSolution_Int2)
end

function testOneIntersectionsOfVectorWithEllipsoid(testCase)
% Test the case of 1 intercept with ellipsoid
[actSolution_numInt, actSolution_Int1, actSolution_Int2] = intersectionOfVectorWithEllipsoid([-1,-2,0],[0,4,0],1,1,1);
expSolution_numInt = [1];
expSolution_Int1 = [-1 0 0];
expSolution_Int2 = [-1 0 0];
verifyEqual(testCase,actSolution_numInt,expSolution_numInt)
verifyEqual(testCase,actSolution_Int1,expSolution_Int1)
verifyEqual(testCase,actSolution_Int2,expSolution_Int2)
end

function testZeroIntersectionOfVectorWithEllipsoid(testCase)
% Test the case of 0 intercepts with ellipsoid
[actSolution_numInt, actSolution_Int1, actSolution_Int2] = intersectionOfVectorWithEllipsoid([-5,-2,0],[0,4,0],1,1,1);
expSolution_numInt = [0];
expSolution_Int1 = [NaN NaN NaN];
expSolution_Int2 = [NaN NaN NaN];
verifyEqual(testCase,actSolution_numInt,expSolution_numInt)
verifyEqual(testCase,actSolution_Int1,expSolution_Int1)
verifyEqual(testCase,actSolution_Int2,expSolution_Int2)
end