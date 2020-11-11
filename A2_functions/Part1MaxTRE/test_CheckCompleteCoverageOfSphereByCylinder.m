% Testing functions for checkCompleteCoverageOfSphereByCylinder(C,R,r,P,v,margin)
% Genevieve Hayes
% CISC 330 - A2

function tests = test_CheckCompleteCoverageOfSphereByCylinder
tests = functiontests(localfunctions);
end

function testCovered(testCase)
% Test case of full coverage
actSolution = checkCompleteCoverageOfSphereByCylinder([0,0,0],10,17.5,[0,0,0],[0,1,0],5);
expSolution = 1;
verifyEqual(testCase,actSolution,expSolution)

fprintf('<strong>TEST 1 - r=10mm Tumor Covered by R=17.5mm Beam with 5mm Margin:</strong>\n')
fprintf('Input tumor center, Ct (mm) = [')
fprintf(' %g ', [0,0,0]);
fprintf(']\n');
fprintf('Input Beam axis center, Cb (mm) = [')
fprintf(' %g ', [0,0,0]);
fprintf(']\n');
fprintf('The output is (2 = Partially Covered, 1 = Completely Covered, 0 = No Coverage): [')
fprintf('%g', actSolution);
fprintf(']\n');
fprintf('Therefore this cylinder covers the entire tumor with a 5 mm margin.\n\n')
end

function testPartiallyCovered(testCase)
% Test case of partial coverage
actSolution = checkCompleteCoverageOfSphereByCylinder([0,0,0],10,17.5,[6,0,0],[0,1,0],5);
expSolution = 2;
verifyEqual(testCase,actSolution,expSolution)

fprintf('<strong>TEST 2 - r=10mm Tumor Partially Covered by R=17.5mm Beam with 5mm Margin:</strong>\n')
fprintf('Input tumor center, Ct (mm) = [')
fprintf(' %g ', [0,0,0]);
fprintf(']\n');
fprintf('Input Beam axis center, Cb (mm) = [')
fprintf(' %g ', [6,0,0]);
fprintf(']\n');
fprintf('The output is (2 = Partially Covered, 1 = Completely Covered, 0 = No Coverage): [')
fprintf('%g', actSolution);
fprintf(']\n');
fprintf('Therefore this cylinder partially covered the tumor with a 5 mm margin.\n\n')
end

function testNoCoverage(testCase)
% Test case of no coverage
actSolution = checkCompleteCoverageOfSphereByCylinder([0,0,0],10,17.5,[30,0,0],[0,1,0],5);
expSolution = 0;
verifyEqual(testCase,actSolution,expSolution)

fprintf('<strong>TEST 3 - r=10mm Tumor Not Covered by R=17.5mm Beam with 5mm Margin:</strong>\n')
fprintf('Input tumor center, Ct (mm) = [')
fprintf(' %g ', [0,0,0]);
fprintf(']\n');
fprintf('Input Beam axis center, Cb (mm) = [')
fprintf(' %g ', [30,0,0]);
fprintf(']\n');
fprintf('The output is (2 = Partially Covered, 1 = Completely Covered, 0 = No Coverage): [')
fprintf('%g', actSolution);
fprintf(']\n');
fprintf('Therefore this cylinder does not intersect with the tumor.\n\n')
end