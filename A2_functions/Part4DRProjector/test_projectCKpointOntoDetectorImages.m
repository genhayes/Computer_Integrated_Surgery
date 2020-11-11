% Testing functions for projectCKpointOntoDetectorImages
% Genevieve Hayes
% CISC 330 - A2

function tests = test_projectCKpointOntoDetectorImages
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

Pt = [0,0,0]';
MarkerPtsCK = [Pt];
[ImgPtsA, ImgPtsB] = projectCKpointOntoDetectorImages(MarkerPtsCK, SDD, ADD, angleA,angleB);

actSolution_A = ImgPtsA;
actSolution_B = ImgPtsB;

%round actual solutions to 2 decimal places 
Ndecimals = 2;
f = 10.^Ndecimals;
actSolution_A = round(f*actSolution_A)/f;
actSolution_B = round(f*actSolution_B)/f;

expSolution_A = [0,0,0]';
expSolution_B = [0,0,0]';
verifyEqual(testCase,actSolution_A,expSolution_A)
verifyEqual(testCase,actSolution_B,expSolution_B)

fprintf('<strong>TEST 1 - CK origin:</strong>\n')
fprintf('Input point, Pck = [')
fprintf(' %g ', Pt(1:3));
fprintf(']\n');
fprintf('Image point in Detector A frame, PdA = [')
fprintf(' %g ', actSolution_A(1:3));
fprintf(']\n');
fprintf('Image point in Detector B frame, PdB = [')
fprintf(' %g ', actSolution_B(1:3));
fprintf(']\n\n');
end

function testWorkspaceEdge(testCase)
% Test case of point at the Workspace edge
SDD = 2000; %mm, source-detector distance (SDD)
SAD = 1000; %mm, source-axis distance (SAD)
ADD = SDD-SAD; %mm, axis-detector distance (ADD)
DsideLength = 400; %mm, squate detector side lengths
angleA = 45; %degrees, rotation of detector A
angleB = -45; %degrees, rotation of detector B

%[Rworkspace] = calculateWorkspaceRadius(2000,DsideLength);

Pt = [100,0,0,1]'; %Location of Source B in CK frame;
[~,R4by4] = rotationMatrixAboutFrameAxis(3,angleA);
Pt = R4by4*Pt;

MarkerPtsCK = [Pt(1:3)];
[ImgPtsA, ImgPtsB] = projectCKpointOntoDetectorImages(MarkerPtsCK, SDD, ADD, angleA,angleB);

actSolution_A = ImgPtsA;
actSolution_B = ImgPtsB;

%round actual solutions to 2 decimal places 
Ndecimals = 2;
f = 10.^Ndecimals;
actSolution_A = round(f*actSolution_A)/f;
actSolution_B = round(f*actSolution_B)/f;

expSolution_A = [0,0,0]';
expSolution_B = [200,0,0]';
verifyEqual(testCase,actSolution_A,expSolution_A)
verifyEqual(testCase,actSolution_B,expSolution_B)

fprintf('<strong>TEST 2 - CK Workspace Edge Location (Yck=0, Zck=0):</strong>\n')
fprintf('Input point, Pck = [')
fprintf(' %g ', Pt(1:3));
fprintf(']\n');
fprintf('Image point in Detector A frame, PdA = [')
fprintf(' %g ', actSolution_A(1:3));
fprintf(']\n');
fprintf('Image point in Detector B frame, PdB = [')
fprintf(' %g ', actSolution_B(1:3));
fprintf(']\n\n');
end