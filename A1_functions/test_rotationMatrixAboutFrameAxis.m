% Testing functions for rotationMatrixAboutFrameAxis
% Genevieve Hayes
% CISC 330 - A1

function tests = test_rotationMatrixAboutFrameAxis
tests = functiontests(localfunctions);
end

function testRotationAboutXofYUnitVector(testCase)
% Test a 90 rotation about the x-axis of a y-direction unit vector 
point = [0,1,0,0]; %(x,y,z) point with zero padding
[R3by3,R4by4] = rotationMatrixAboutFrameAxis(1,90);
rotatedPoint = R4by4*point';
actSolution = rotatedPoint(1:3)';
expSolution = [0,0,1];
verifyEqual(testCase,actSolution,expSolution)
end

%function testRotationAboutXofXUnitVector(testCase)
%% Test a 90 rotation about the x-axis of a x-direction unit vector 
%point = [1,0,0,0];  %(x,y,z) point with zero padding
%[R3by3,R4by4] = rotationMatrixAboutFrameAxis(1,90);
%rotatedPoint = R4by4*point';
%actSolution = rotatedPoint(1:3)';
%expSolution = [1,0,0];
%verifyEqual(testCase,actSolution,expSolution)
%end

function test30DegreeRotationAboutZofXYZVector(testCase)
% Test a 30 rotation about the z-axis of a xyz-direction vector 
a=1;
point = [a,a*sqrt(3),1,0]; %(x,y,z) point with zero padding
[R3by3,R4by4] = rotationMatrixAboutFrameAxis(3,-30);
rotatedPoint = R4by4*point';

%round final answers to 5 decimal places
Ndecimals = 5;
f = 10.^Ndecimals;

actSolution = rotatedPoint(1:3)';
actSolution = round(f*actSolution)/f;
expSolution = [a*sqrt(3),a,1];
expSolution = round(f*expSolution)/f;
verifyEqual(testCase,actSolution,expSolution)
end

function test60degreeRotationAboutYofXYZVector(testCase)
% Test a 60 rotation about the y-axis of a xyz-direction vector 
a=1;
point = [a,1,a*sqrt(3),0]; %(x,y,z) point with zero padding
[R3by3,R4by4] = rotationMatrixAboutFrameAxis(2,60);
rotatedPoint = R4by4*point';

%round final answers to 5 decimal places
Ndecimals = 5;
f = 10.^Ndecimals;

actSolution = rotatedPoint(1:3)';
actSolution = round(f*actSolution)/f;
expSolution = [2,1,0];
expSolution = round(f*expSolution)/f;
verifyEqual(testCase,actSolution,expSolution)
end
