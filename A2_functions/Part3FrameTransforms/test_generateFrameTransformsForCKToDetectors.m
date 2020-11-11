% Testing functions for generateFrameTransformsForCKToDetectors
% Genevieve Hayes
% CISC 330 - A2

function tests = test_generateFrameTransformsForCKToDetectors
tests = functiontests(localfunctions);
end

function testCKOrigin(testCase)
% Test case of point at CK origin
SDD = 2000; %mm, source-detector distance (SDD)
SAD = 1000; %mm, source-axis distance (SAD)
ADD = SDD-SAD; %mm, axis-detector distance (ADD)
DsideLength = 400; %mm, squate detector side lengths
angleA = 45; %degrees, rotation of detector A
angleB = -45; %degrees, rotation of detector B

[TransCKtoA,TransCKtoB] = generateFrameTransformsForCKToDetectors(angleA,angleB,ADD);
P_CK1 = [0,0,0,1]';
actSolution_PA1 = TransCKtoA*P_CK1;
actSolution_PB1 = TransCKtoB*P_CK1;

%round actual solutions to 2 decimal places 
Ndecimals = 2;
f = 10.^Ndecimals;
actSolution_PA1 = round(f*actSolution_PA1)/f;
actSolution_PB1 = round(f*actSolution_PB1)/f;

expSolution_PA1 = [0,ADD,0,1]';
expSolution_PB1 = [0,ADD,0,1]';
verifyEqual(testCase,actSolution_PA1,expSolution_PA1)
verifyEqual(testCase,actSolution_PB1,expSolution_PB1)

fprintf('<strong>TEST 1 - CK origin:</strong>\n')
fprintf('Input point, Pck = [')
fprintf('%g', P_CK1(1:3));
fprintf(']\n');
fprintf('Point in Detector A frame, PdA = [')
fprintf('%g', actSolution_PA1(1:3));
fprintf(']\n');
fprintf('Point in Detector B frame, PdB = [')
fprintf('%g', actSolution_PB1(1:3));
fprintf(']\n\n');
end
%
function testDoubleTheDistanceForDetectorB(testCase)
% Test case of a point 100 cm beyond the source in the opposite direction of relative to e2_B
SDD = 2000; %mm, source-detector distance (SDD)
SAD = 1000; %mm, source-axis distance (SAD)
ADD = SDD-SAD; %mm, axis-detector distance (ADD)
DsideLength = 400; %mm, squate detector side lengths
angleA = 45; %degrees, rotation of detector A
angleB = -45; %degrees, rotation of detector B

[TransCKtoA,TransCKtoB] = generateFrameTransformsForCKToDetectors(angleA,angleB,ADD);
P_CK2 = [ADD*cosd(angleA),ADD*sind(angleA),0,1]';
actSolution_PA2 = TransCKtoA*P_CK2;
actSolution_PB2 = TransCKtoB*P_CK2;

%round actual solutions to 2 decimal places 
Ndecimals = 2;
f = 10.^Ndecimals;
actSolution_PA2 = round(f*actSolution_PA2)/f;
actSolution_PB2 = round(f*actSolution_PB2)/f;

expSolution_PA2 = [ADD,ADD,0,1]';
expSolution_PB2 = [0,SDD,0,1]';
verifyEqual(testCase,actSolution_PA2,expSolution_PA2)
verifyEqual(testCase,actSolution_PB2,expSolution_PB2)

fprintf('<strong>TEST 2 - Source B Location:</strong>\n')
fprintf('Input point, Pck = [')
fprintf('%g', P_CK2(1:3));
fprintf(']\n');
fprintf('Point in Detector A frame, PdA = [')
fprintf('%g', actSolution_PA2(1:3));
fprintf(']\n');
fprintf('Point in Detector B frame, PdB = [')
fprintf('%g', actSolution_PB2(1:3));
fprintf(']\n\n');
end

function testDetectorAOrigin(testCase)
% Test case of point at Detector A origin
SDD = 2000; %mm, source-detector distance (SDD)
SAD = 1000; %mm, source-axis distance (SAD)
ADD = SDD-SAD; %mm, axis-detector distance (ADD)
DsideLength = 400; %mm, squate detector side lengths
angleA = 45; %degrees, rotation of detector A
angleB = -45; %degrees, rotation of detector B

[TransCKtoA,TransCKtoB] = generateFrameTransformsForCKToDetectors(angleA,angleB,ADD);
P_CK3 = [ADD*cosd(angleA),-ADD*sind(angleA),0,1]';
actSolution_PA3 = TransCKtoA*P_CK3;
actSolution_PB3 = TransCKtoB*P_CK3;

%round actual solutions to 2 decimal places 
Ndecimals = 2;
f = 10.^Ndecimals;
actSolution_PA3 = round(f*actSolution_PA3)/f;
actSolution_PB3 = round(f*actSolution_PB3)/f;

expSolution_PA3 = [0,0,0,1]';
expSolution_PB3 = [ADD,ADD,0,1]';
verifyEqual(testCase,actSolution_PA3,expSolution_PA3)
verifyEqual(testCase,actSolution_PB3,expSolution_PB3)

fprintf('<strong>TEST 3 - Detector A Center:</strong>\n')
fprintf('Input point, Pck = [')
fprintf('%g', P_CK3(1:3));
fprintf(']\n');
fprintf('Point in Detector A frame, PdA = [')
fprintf('%g', actSolution_PA3(1:3));
fprintf(']\n');
fprintf('Point in Detector B frame, PdB = [')
fprintf('%g', actSolution_PB3(1:3));
fprintf(']\n\n');
end
