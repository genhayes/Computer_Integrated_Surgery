% Testing functions for numIntersectionsOfSphereAndCylinder
% Genevieve Hayes
% CISC 330 - A1

function tests = test_numIntersectionsOfSphereAndCylinder
tests = functiontests(localfunctions);
end

function testZeroIntersections(testCase)
% Test case for zero intersections between sphere and cylinder
actSolution_numInt = numIntersectionsOfSphereAndCylinder([0,0,0],1,1,[20,0,0],[0,1,0]);
expSolution_numInt = 0;
verifyEqual(testCase,actSolution_numInt,expSolution_numInt)
end

function testOneIntersection(testCase)
% Test case for one intersection between the sphere and cylinder
actSolution_numInt = numIntersectionsOfSphereAndCylinder([0,0,0],1,1,[2,-5,0],[0,10,0]);
expSolution_numInt = 1;
verifyEqual(testCase,actSolution_numInt,expSolution_numInt)
end

function testTwoIntersection(testCase)
% Test case for "two" intersections between the sphere and cylinder (i.e.
% cylinder going in 1 side of the sphere and exiting another
actSolution_numInt = numIntersectionsOfSphereAndCylinder([0,0,0],2,1,[0,-1,0],[0,1,0]);
expSolution_numInt = 2;
verifyEqual(testCase,actSolution_numInt,expSolution_numInt)
end

