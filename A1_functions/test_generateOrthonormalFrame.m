% Testing functions for generateOrthonormalFrame
% Genevieve Hayes
% CISC 330 - A1

function tests = test_generateOrthonormalFrame
tests = functiontests(localfunctions);
end

function testOriginXYUnitVectors(testCase)
% Test the case of the origin and an x and y unit vectors
[actSolution_Oe,actSolution_e1,actSolution_e2,actSolution_e3] = generateOrthonormalFrame([0,0,0],[1,0,0],[0,1,0]);
expSolution_Oe = [0.3333 0.3333 0];
expSolution_e1 = [1 0 0];
expSolution_e2 = [0 1 0];
expSolution_e3 = [0 0 1];

% round actual anser to 4 decimal places
Ndecimals = 4;
f = 10.^Ndecimals;
actSolution_Oe = round(f*actSolution_Oe)/f;

verifyEqual(testCase,actSolution_Oe,expSolution_Oe)
verifyEqual(testCase,abs(actSolution_e1),expSolution_e1)
verifyEqual(testCase,abs(actSolution_e2),expSolution_e2)
verifyEqual(testCase,abs(actSolution_e3),expSolution_e3)
end

function testEquilateralTriangle(testCase)
% Test the case of the an equilateral triangle about the point [0,1,1]
[actSolution_Oe,actSolution_e1,actSolution_e2,actSolution_e3] = generateOrthonormalFrame([0,0,0],[0,3,0],[0,0,3]);
expSolution_Oe = [0 1 1];
expSolution_e1 = [0 1 0];
expSolution_e2 = [0 0 1];
expSolution_e3 = [1 0 0];
verifyEqual(testCase,actSolution_Oe,expSolution_Oe)
verifyEqual(testCase,abs(actSolution_e1),expSolution_e1)
verifyEqual(testCase,abs(actSolution_e2),expSolution_e2)
verifyEqual(testCase,abs(actSolution_e3),expSolution_e3)
end

function testCollinearPoints(testCase)
% Test the case of colinear input points
[actSolution_Oe,actSolution_e1,actSolution_e2,actSolution_e3] = generateOrthonormalFrame([0,0,0],[3,0,0],[3,0,0]);
expSolution_Oe = [2 0 0];
expSolution_e1 = [1 0 0];
expSolution_e2 = [NaN NaN NaN];
expSolution_e3 = [NaN NaN NaN];
verifyEqual(testCase,actSolution_Oe,expSolution_Oe)
verifyEqual(testCase,abs(actSolution_e1),expSolution_e1)
verifyEqual(testCase,abs(actSolution_e2),expSolution_e2)
verifyEqual(testCase,abs(actSolution_e3),expSolution_e3)
end
