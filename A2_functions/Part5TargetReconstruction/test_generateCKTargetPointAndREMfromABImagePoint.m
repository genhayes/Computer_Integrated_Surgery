% Testing functions for generateCKTargetPointAndREMfromABImagePoint
% Genevieve Hayes
% CISC 330 - A2

function tests = test_generateCKTargetPointAndREMfromABImagePoint
tests = functiontests(localfunctions);
end

function testMarkerAtOrigin(testCase)
% Test case of the marker at the CK origin
SDD = 2000; %mm, source-detector distance (SDD)
SAD = 1000; %mm, source-axis distance (SAD)
ADD = SDD-SAD; %mm, axis-detector distance (ADD)
DsideLength = 400; %mm, squate detector side lengths
angleA = 45; %degrees, rotation of detector A
angleB = -45; %degrees, rotation of detector B
Pt = [0,0,0]';
MarkerPtCK = [Pt];
[ImgPtA, ImgPtB] = projectCKpointOntoDetectorImages(MarkerPtCK, SDD, ADD, angleA,angleB);
[TargetPtCK3D,REM] = generateCKTargetPointAndREMfromABImagePoint(ImgPtA, ImgPtB, ADD, angleA, angleB);

actSolution_TargetPtCK3D = TargetPtCK3D;
actSolution_REM = REM;

%round actual solutions to 2 decimal places 
Ndecimals = 2;
f = 10.^Ndecimals;
actSolution_TargetPtCK3D = round(f*actSolution_TargetPtCK3D)/f;
actSolution_REM = round(f*actSolution_REM)/f;

expSolution_TargetPtCK3D = [0,0,0]';
expSolution_REM = 0;
verifyEqual(testCase,actSolution_TargetPtCK3D,expSolution_TargetPtCK3D)
verifyEqual(testCase,actSolution_REM,expSolution_REM)

fprintf('<strong>TEST 1 - Marker at CK origin:</strong>\n')
fprintf('Input marget point in CK frame, MarkerPtCK = [')
fprintf(' %g ', MarkerPtCK(1:3));
fprintf(']\n');
fprintf('Output target point in CK frame, TarkerPtCK = [')
fprintf(' %g ', TargetPtCK3D(1:3));
fprintf(']\n');
fprintf('The REM for with point is, REM = [')
fprintf(' %g ', REM);
fprintf(']\n\n');
end

function testMarkerAtDetectorACenter(testCase)
% Test case of marker at the center of detector a relative to the CK frame
SDD = 2000; %mm, source-detector distance (SDD)
SAD = 1000; %mm, source-axis distance (SAD)
ADD = SDD-SAD; %mm, axis-detector distance (ADD)
DsideLength = 400; %mm, squate detector side lengths
angleA = 45; %degrees, rotation of detector A
angleB = -45; %degrees, rotation of detector B

Pt = [ADD*cosd(angleA),-ADD*sind(angleA),0]'; %Location of Detector A in CK frame
MarkerPtCK = [Pt];
[ImgPtA, ImgPtB] = projectCKpointOntoDetectorImages(MarkerPtCK, SDD, ADD, angleA,angleB);
[TargetPtCK3D,REM] = generateCKTargetPointAndREMfromABImagePoint(ImgPtA, ImgPtB, ADD, angleA, angleB);

actSolution_TargetPtCK3D = TargetPtCK3D;
actSolution_REM = REM;

expSolution_TargetPtCK3D = [ADD*cosd(angleA),-ADD*sind(angleA),0]';
expSolution_REM = 0;

%round actual solutions to 2 decimal places 
Ndecimals = 2;
f = 10.^Ndecimals;
actSolution_TargetPtCK3D = round(f*actSolution_TargetPtCK3D)/f;
actSolution_REM = round(f*actSolution_REM)/f;

expSolution_TargetPtCK3D = round(f*expSolution_TargetPtCK3D)/f;

verifyEqual(testCase,actSolution_TargetPtCK3D,expSolution_TargetPtCK3D)
verifyEqual(testCase,actSolution_REM,expSolution_REM)

fprintf('<strong>TEST 2 - Marker at Detector A Center:</strong>\n')
fprintf('Input marget point in CK frame, MarkerPtCK = [')
fprintf(' %g ', MarkerPtCK(1:3));
fprintf(']\n');
fprintf('Output target point in CK frame, TarkerPtCK = [')
fprintf(' %g ', TargetPtCK3D(1:3));
fprintf(']\n');
fprintf('The REM for with point is, REM = [')
fprintf(' %g ', REM);
fprintf(']\n\n');
end

function testMarkerAtPosition101010(testCase)
% Test case of marker at position (10,10,10) relative to the CK frame
SDD = 2000; %mm, source-detector distance (SDD)
SAD = 1000; %mm, source-axis distance (SAD)
ADD = SDD-SAD; %mm, axis-detector distance (ADD)
DsideLength = 400; %mm, squate detector side lengths
angleA = 45; %degrees, rotation of detector A
angleB = -45; %degrees, rotation of detector B

Pt = [10,10,10]'; %Location of Detector A in CK frame
MarkerPtCK = [Pt];
[ImgPtA, ImgPtB] = projectCKpointOntoDetectorImages(MarkerPtCK, SDD, ADD, angleA,angleB);
[TargetPtCK3D,REM] = generateCKTargetPointAndREMfromABImagePoint(ImgPtA, ImgPtB, ADD, angleA, angleB);

actSolution_TargetPtCK3D = TargetPtCK3D;
actSolution_REM = REM;

expSolution_TargetPtCK3D = [10,10,10]';
expSolution_REM = 0;

%round actual solutions to 2 decimal places 
Ndecimals = 2;
f = 10.^Ndecimals;
actSolution_TargetPtCK3D = round(f*actSolution_TargetPtCK3D)/f;
actSolution_REM = round(f*actSolution_REM)/f;

verifyEqual(testCase,actSolution_TargetPtCK3D,expSolution_TargetPtCK3D)
verifyEqual(testCase,actSolution_REM,expSolution_REM)

fprintf('<strong>TEST 3 - Marker at (10,10,10) in CK Frame:</strong>\n')
fprintf('Input marget point in CK frame, MarkerPtCK = [')
fprintf(' %g ', MarkerPtCK(1:3));
fprintf(']\n');
fprintf('Output target point in CK frame, TarkerPtCK = [')
fprintf(' %g ', TargetPtCK3D(1:3));
fprintf(']\n');
fprintf('The REM for with point is, REM = [')
fprintf(' %g ', REM);
fprintf(']\n\n');
end
