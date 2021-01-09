% Testing functions for checkTrianglesCongruent
% Genevieve Hayes
% CISC 330 - A3

function tests = test_checkTrianglesCongruent
tests = functiontests(localfunctions);
end

function testCongruent(testCase)
% Test where triangles are congruent
A0 = [-2,-2,0]';
B0 = [4,-2,0]';
C0 = [-2,4,0]';

A = [-2,-4,0]';
B = [4,-4,0]';
C = [-2,2,0]';

actSolution = checkTrianglesCongruent(A0,B0,C0,A,B,C);
expSolution = 1;
verifyEqual(testCase,actSolution,expSolution)
end

function testNotCongruent(testCase)
% Test where triangles are not congruent
A0 = [-2,-2,0]';
B0 = [4,-2,0]';
C0 = [-2,4,0]';

A = [-10,-5,0]';
B = [4,-4,0]';
C = [-2,2,1]';

actSolution = checkTrianglesCongruent(A0,B0,C0,A,B,C);
expSolution = 0;
verifyEqual(testCase,actSolution,expSolution)
end