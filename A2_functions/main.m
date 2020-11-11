%% CISC 330 A2
%Genevieve Hayes
%Nov 03, 2020

%% This script runs all the tests and simulations for A2
% An error is expected on line 130 to illustrate an ambiguous REMs matrix
% Use the "Run Section" option to run the sections after line 130 the 
% or to run each section individially 

%% Initialize all components
clear
clc
format shortG
addpath('Part1MaxTRE')
addpath('Part2Workspace')
addpath('Part3FrameTransforms')
addpath('Part4DRProjector')
addpath('Part5TargetReconstruction')
addpath('Part6Correspondence')
addpath('Part7Simulation')

SDD = 2000; %mm, source-detector distance (SDD)
SAD = 1000; %mm, source-axis distance (SAD)
ADD = SDD-SAD; %mm, axis-detector distance (ADD)
DsideLength = 400; %mm, squate detector side lengths
angleA = 45; %degrees, rotation of detector A
angleB = -45; %degrees, rotation of detector B

%% Part 1
% Runs defined unit tests for this function
runtests('test_CheckCompleteCoverageOfSphereByCylinder.m')

%% Part 2
Rworkspace = calculateWorkspaceRadius(SDD,DsideLength)

%% Part 3
[TransCKtoA,TransCKtoB] = generateFrameTransformsForCKToDetectors(angleA,angleB,ADD)

% Runs defined unit tests for the CK to detector transformation function
runtests('test_generateFrameTransformsForCKToDetectors.m')

%% Part 4
% Runs defined unit tests for the CK to detector transformation function
runtests('test_projectCKpointOntoDetectorImages.m')

%% Part 5
% Runs defined unit tests for the CK to detector transformation function
runtests('test_generateCKTargetPointAndREMfromABImagePoint.m')

%You can check the reconstruction of any marker points in the CK frame by putting new
%values into PointCK1, PointCK2 or PointCK3
PointCK1 = [1,2,3]';
PointCK2 = [10,20,30]';
PointCK3 = [90,90,0]';

MarkerPtsCK = [PointCK1, PointCK2, PointCK3];
[ImgPtsA, ImgPtsB] = projectCKpointOntoDetectorImages(MarkerPtsCK, SDD, ADD, angleA,angleB);
[TargetPtsCK3D,REMs] = reconstructCKTargetMatrixFromDetectorImages(ImgPtsA,ImgPtsB,ADD, angleA, angleB); 
%In this case, use perfectly correlated matrix to illustrate the marker
%reconstruction (reconstructed points on the diagonals of the TargetPts3D
%and REMs matrices)
correspondenceMatrix = [1,1;2,2;3,3]; 
TargetPtsCK = getCorrespondenceTargetPoints(TargetPtsCK3D, correspondenceMatrix);
REMck = getCorrespondenceREM(REMs, correspondenceMatrix);
fprintf('<strong>TEST 4 - Reconstruction of Multiple Markers:</strong>\n')
fprintf('Input marget points in CK frame, MarkerPtsCK = [')
fprintf(' %g ', MarkerPtsCK(:,1));
fprintf(']\n [');
fprintf(' %g ', MarkerPtsCK(:,2));
fprintf(']\n [');
fprintf(' %g ', MarkerPtsCK(:,3));
fprintf(']\n');
fprintf('Output target point in CK frame, TarkerPtsCK = [')
fprintf(' %g ', TargetPtsCK(:,1));
fprintf(']\n [');
fprintf(' %g ', TargetPtsCK(:,2));
fprintf(']\n [');
fprintf(' %g ', TargetPtsCK(:,3));
fprintf(']\n');
fprintf('The REM for each point is, REMs = [')
fprintf(' %g ', REMck);
fprintf(']\n\n');
%% Part 6
%Case1: 
c1M1 = [0,0,-50]';
c1M2 = [0,0,0]';
c1M3 = [0,0,50]';

MarkerPtsCK_case1 = [c1M1,c1M2,c1M3];
[ImgPtsA, ImgPtsB] = projectCKpointOntoDetectorImages(MarkerPtsCK_case1, SDD, ADD, angleA,angleB);
[TargetPtsCK3D,REMs] = reconstructCKTargetMatrixFromDetectorImages(ImgPtsA,ImgPtsB, ADD, angleA, angleB);
correspondenceMatrix_case1 = buildCorrespondenceMatrixFromREMs(REMs)
TargetPtsCK2D_case1 = getCorrespondenceTargetPoints(TargetPtsCK3D, correspondenceMatrix_case1);
TRE_case1 = norm(MarkerPtsCK_case1 - TargetPtsCK2D_case1)

fprintf('<strong>TEST 1:</strong>\n')
fprintf('M1 = [')
fprintf(' %g ', c1M1(1:3));
fprintf(']\n');
fprintf('M2 = [')
fprintf(' %g ', c1M2(1:3));
fprintf(']\n');
fprintf('M3 = [')
fprintf(' %g ', c1M3(1:3));
fprintf(']\n');
fprintf('The reconstructed markers in CK frame are, M1 = [');
fprintf(' %g ', TargetPtsCK2D_case1(:,1));
fprintf(']\n');
fprintf('M2 = [')
fprintf(' %g ', TargetPtsCK2D_case1(:,2));
fprintf(']\n');
fprintf('M3 = [')
fprintf(' %g ', TargetPtsCK2D_case1(:,3));
fprintf(']\n');
fprintf('The TRE with this reconstruction, PdB = [')
fprintf(' %g ', TRE_case1);
fprintf(']\n\n');

%Case2: 
c2M1 = [0,0,0]';
c2M2 = [50,0,0]';
c2M3 = [0,0,50]';

MarkerPtsCK_case2 = [c2M1,c2M2,c2M3];
fprintf('<strong>TEST 2:</strong>\n')
fprintf('M1 = [')
fprintf(' %g ', c2M1(1:3));
fprintf(']\n');
fprintf('M2 = [')
fprintf(' %g ', c2M2(1:3));
fprintf(']\n');
fprintf('M3 = [')
fprintf(' %g ', c2M3(1:3));
fprintf(']\n');
fprintf('Since some of the points are non unique, the REMs matrix has ambiguity and could not be properly correlated to the target matrix.\n\n');
fprintf('Expected error:');
[ImgPtsA, ImgPtsB] = projectCKpointOntoDetectorImages(MarkerPtsCK_case2, SDD, ADD, angleA,angleB);
[TargetPtsCK3D,REMs] = reconstructCKTargetMatrixFromDetectorImages(ImgPtsA,ImgPtsB, ADD, angleA, angleB);
correspondenceMatrix = buildCorrespondenceMatrixFromREMs(REMs);
TargetPtsCK2D_case2 = getCorrespondenceTargetPoints(TargetPtsCK3D, correspondenceMatrix);

TRE_case2 = norm(MarkerPtsCK_case2 - TargetPtsCK2D_case2);

%% Part 7 - Simulation

%generate 100 random markers within the workspace
Rmin = 0;
Rmax = calculateWorkspaceRadius(SDD,DsideLength); %(mm)
num_markers = 100; %number of markers per
Rmarkers = Rmin+rand(1,num_markers)*(Rmax-Rmin);
MarkerPtsCK = ones(3,length(Rmarkers));

for i=1:length(Rmarkers)
    MarkerPtsCK(:,i) = Rmarkers(i).*Random_Unit_Vector(3);
end

Err_limit = 9;%mm
step = 0.5; %mm

%Define the maximum TRE 
MaxTRE = 2.5; %mm

TRE_all = ones(1,num_markers*(Err_limit/step));
REM_all = ones(1,num_markers*(Err_limit/step));
error_all = ones(1,num_markers*(Err_limit/step));
checkFail = ones(1, num_markers);
FailureRate_all = ones(1,num_markers*(Err_limit/step));

TRE_mean = ones(1,(Err_limit/step));
REM_mean = ones(1,(Err_limit/step));
error_mean = ones(1,(Err_limit/step));
FailureRate_tot = ones(1,(Err_limit/step));

for error = 0: step : Err_limit
    i = int16(error*num_markers/step)+1; %first index of each chuck of new error magnitude outputs
    ind = int16(error/step)+1; %increment index for each new error magnitude
    
    [TREck, REMck] = simulateJitterInDetectorImages(MarkerPtsCK, error ,SDD , ADD, angleA, angleB);
    
    indices_allowed = find(abs(TREck)<Rmarkers);
    TREck = TREck(indices_allowed);
    REMck = REMck(indices_allowed);
    
    num_allowed = length(indices_allowed);
    
    TRE_all(i:i+(num_allowed-1)) = TREck;  
    TRE_mean(ind) = mean(TREck);
    
    REM_all(i:i+(num_allowed-1)) = REMck; 
    REM_mean(ind) = mean(REMck);
    
    error_all(i:i+(num_allowed-1)) = error;
    error_mean(ind) = error;
    
    %Determine the failure rate
    checkFail = TRE_all;
    checkFail(TRE_all >= MaxTRE) = 1;
    checkFail(TRE_all < MaxTRE) = 0;
    total = 1:1:length(checkFail);
    FailureRate_all(i:i+(num_allowed-1)) = (cumsum(checkFail)/total)*100;
    FailureRate_tot(ind) = FailureRate_all(i+(num_allowed-1));
end

figure;hold on;
title('TRE as a function of the Error Magnitude')
ylabel('TRE (mm)')
xlabel('Error Magnitude (mm)')
plot(error_all,TRE_all,'.c')
plot(error_mean,TRE_mean,'*-m')
yline(2.5,'r')
legend('All TRE', 'Mean TRE','Max Allowed TRE')

hold off;

figure;hold on;
title('Failure Rate as a function of the Error Magnitude')
ylabel('Failure Rate (%)')
xlabel('Error Magnitude (mm)')
yline(15,'r')
%plot(error_all,FailureRate_all,'ob')
plot(error_mean,FailureRate_tot,'*-m')
legend('Failure Rate', 'Max Allowed Failure Rate')

hold off;

figure;hold on;
title('TRE as a function of the REM')
ylabel('TRE (mm)')
xlabel('REM')
plot(REM_all,TRE_all,'.g')
plot(REM_mean,TRE_mean,'*-b')
yline(2.5,'r')
legend('All TRE', 'Mean TRE','Max Allowed TRE')