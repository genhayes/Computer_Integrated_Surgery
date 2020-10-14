% Testing functions for generateFrameTransformationToHome
% Genevieve Hayes
% CISC 330 - A1

function tests = test_generateFrameTransformationToHome
tests = functiontests(localfunctions);
end

function testTranslationX(testCase)
% Test a translation in the x axis 
Pe = [0 0 0 1];
T_e2h = generateFrameTransformationToHome([1,0,0],[1,0,0],[0,1,0],[0,0,1]);
Ph = T_e2h*Pe';
actSolution = Ph(1:3);
expSolution = [1,0,0];
verifyEqual(testCase,actSolution,expSolution')
end

function testTranslationXYZ(testCase)
% Test a translation in the x, y and z
Pe2 = [0 0 1 1];
T_e2h2 = generateFrameTransformationToHome([1,-1,1],[1,0,0],[0,1,0],[0,0,1]);
Ph2 = T_e2h2*Pe2';
actSolution = Ph2(1:3);
expSolution = [1,-1,2];
verifyEqual(testCase,actSolution,expSolution')
end

function testNegativeBasisRotation(testCase)
% Test a the negative basis vectors with no translation
Pe = [1 1 1 1];
T_e2h = generateFrameTransformationToHome([0,0,0],[-1,0,0],[0,-1,0],[0,0,-1]);
Ph = T_e2h*Pe';
actSolution = Ph(1:3);
expSolution = [-1,-1,-1];
verifyEqual(testCase,actSolution,expSolution')
end

function test60DegreeRotationAboutZ(testCase)
% Test a rotation of 60 degrees counterclockwise (looking into negative
% direction) about the z axis with no translation of Oe.

%generate rotation for 60 degree rotation counterclockwise (looking into negative direction) about the z axis
[Rz3by3,Rz4by4] = rotationMatrixAboutFrameAxis(3,60);
v1 = [1 0 0 1];
v2 = [0 1 0 1];
v3 = [0 0 1 1];
%rotate h basis by 60 degrees about the z axis
e1 = Rz4by4*v1';
e2 = Rz4by4*v2';
e3 = Rz4by4*v3';

Pe4 = [sqrt(3),1,1,1];
T_e2h4 = generateFrameTransformationToHome([0,0,0],e1(1:3),e2(1:3),e3(1:3));
Ph4 = T_e2h4*Pe4';

%round the output to 3 decimal places
Ndecimals = 3;
f = 10.^Ndecimals;
actSolution = round(f*Ph4(1:3))/f;

expSolution = [0,2,1];
verifyEqual(testCase,actSolution,expSolution')
end

function testOffsetAndNegativeBasisRotation(testCase)
% Test a the negative basis vectors an offset such that Oe = [0,1,0].

Pe5 = [0 -1 -0.5 1];
T_e2h5 = generateFrameTransformationToHome([0 1 0],[-1 0 0],[0 -1 0],[0 0 -1]);
Ph5 = T_e2h5*Pe5';

%round the output to 3 decimal places
Ndecimals = 3;
f = 10.^Ndecimals;
actSolution = round(f*Ph5(1:3))/f;

expSolution = [0,0,0.5];
verifyEqual(testCase,actSolution,expSolution')
end

function testOffsetAnd60DegreeRotationAboutZ(testCase)
% Test a rotation of 60 degrees counterclockwise (looking into negative
% direction) about the z axis with an offset such that Oe = [-1,1,0].

%generate rotation for 60 degree rotation counterclockwise (looking into negative direction) about the z axis
[Rz3by3,Rz4by4] = rotationMatrixAboutFrameAxis(3,60);
v1 = [1 0 0 1];
v2 = [0 1 0 1];
v3 = [0 0 1 1];
%rotate h basis by 60 degrees about the z axis
e1 = Rz4by4*v1';
e2 = Rz4by4*v2';
e3 = Rz4by4*v3';

Pe4 = [(sqrt(3)+1),0,1,1];
T_e2h4 = generateFrameTransformationToHome([-1,1,0],e1(1:3),e2(1:3),e3(1:3));
Ph4 = T_e2h4*Pe4';

%round the output to 3 decimal places
Ndecimals = 3;
f = 10.^Ndecimals;
actSolution = round(f*Ph4(1:3))/f;

expSolution = [0,2,1];
verifyEqual(testCase,actSolution,expSolution')
end


