%% CISC 330 A3
%Genevieve Hayes
%Nov 23, 2020

% This script runs all the tests and simulations for A3

%% Initialize all components
clc
clear

%% Part 1: Tool Tip Calibration Testing
fprintf('<strong>Tool Tip Calibration Testing:</strong>\n')
N = 100; %Number of spherical pivot poses

%Generate N random angles between 0 and 30 degrees about the Z axis
%   Note: since this is a cone, x and z pivots are proportional, just with a phase shift
min_angleZ = 0;
max_angleZ = 30;
angleZ = min_angleZ + (max_angleZ-min_angleZ).*rand(N,1);

%Generate N random angles between 0 and 360 degrees about the Y axis
min_angleY = 0;
max_angleY = 360;
angleY = min_angleY + (max_angleY-min_angleY).*rand(N,1);

%Start with ground-truth model of the tracked tool
Tip_tool_gt = [0,-20,0]';
At_track_gt = -Tip_tool_gt + [-2,-2,0]';
Bt_track_gt = -Tip_tool_gt + [4,-2,0]';
Ct_track_gt = -Tip_tool_gt + [-2,4,0]';

%Initialize array of pose vectors
At_track = ones(N,3);
Bt_track = ones(N,3);
Ct_track = ones(N,3);

for i = 1:N
    %Generate rotation matrix about the z axis
    [~,R4by4Z] = rotationMatrixAboutFrameAxis(3,angleZ(i));
    %Generate rotation matrix about the y axis
    [~,R4by4Y] = rotationMatrixAboutFrameAxis(2,angleY(i));
    
    %Apply rotations with padding
    A_rotated = R4by4Z*R4by4Y*[At_track_gt;1];
    At_track(i,:) = A_rotated(1:3);
    B_rotated = R4by4Z*R4by4Y*[Bt_track_gt;1];
    Bt_track(i,:) = B_rotated(1:3);
    C_rotated = R4by4Z*R4by4Y*[Ct_track_gt;1];
    Ct_track(i,:) = C_rotated(1:3);
end

%Determine Tip_tool
Tip_tool = toolTipCalibration(At_track,Bt_track,Ct_track)

%Check that output solution matches ground truth
Tip_tool_checkEqual = isequal(Tip_tool,Tip_tool_gt')
%% Part 2: Tool Axis Calibration Testing
fprintf('<strong>Tool Tip Calibration Testing:</strong>\n')
n = 500; %Number of simulated tool poses

%Generate N random angles between 0 and 360 degrees
min_angleY = 0;
max_angleY = 360;
angleY = min_angleY + (max_angleY-min_angleY).*rand(n,1);

%Start with ground-truth model of the tracked tool
Tip_tool_gt = [0,-20,0]';
At_track_gt = -Tip_tool_gt + [-2,-2,0]';
Bt_track_gt = -Tip_tool_gt + [4,-2,0]';
Ct_track_gt = -Tip_tool_gt + [-2,4,0]';

%Initialize array of pose vectors
At_track2 = ones(n,3);
Bt_track2 = ones(n,3);
Ct_track2 = ones(n,3);

for i = 1:n
    %Generate rotation matrix about the y axis
    [~,R4by4Y] = rotationMatrixAboutFrameAxis(2,angleY(i));
    
    %Apply rotations with padding
    A_rotated = R4by4Y*[At_track_gt;1];
    At_track2(i,:) = A_rotated(1:3);
    B_rotated = R4by4Y*[Bt_track_gt;1];
    Bt_track2(i,:) = B_rotated(1:3);
    C_rotated = R4by4Y*[Ct_track_gt;1];
    Ct_track2(i,:) = C_rotated(1:3);
end

[vax_tool] = toolAxisCalibration(At_track2,Bt_track2,Ct_track2);

%define precision
numDecimals = 2; %round to 3 decimal places
f = 10.^numDecimals;
vax_tool = round(f.*vax_tool)./f

%Check that output solution matches ground truth
vax_tool_checkEqual = isequal(vax_tool,[0,1,0])

%% Part 3: Surgical Navigation
%%Test checkTrianglesCongruent
%CheckTrianglesCongruent = runtests('test_checkTrianglesCongruent.m')

%Calibrate the tool
%Tip_tool = toolTipCalibration(At_track,Bt_track,Ct_track);  
%vax_tool = toolAxisCalibration(At_track2,Bt_track2,Ct_track2); 
Tip_tool = [0,-20,0]; 
vax_tool = [0,1,0];

%Pre-op plan
ApatCT = [-2,8,5];
BpatCT = [4,8,5];
CpatCT = [-2,14,5];

TumCtrCT = [0,0,0];
TumRadCT = 2;
WinCtrCT = [0,5,0];
WinRadCT = 1;

% Navigation Case 1
Apat1Track = [-2,8,55];
Bpat1Track = [4,8,55];
Cpat1Track = [-2,14,55];

AtoolTrack1 = [-2,18,50];
BtoolTrack1 = [4,18,50];
CtoolTrack1 = [-2,24,50];

fprintf('<strong>Case 1:</strong>\n')
surgicalNavigationSimulation(Tip_tool, vax_tool, ApatCT, BpatCT, CpatCT, Apat1Track, Bpat1Track, Cpat1Track, AtoolTrack1, BtoolTrack1, CtoolTrack1, TumCtrCT, TumRadCT, WinCtrCT, WinRadCT, 1)

%% Part 3.2: Surgical Navigation

Tip_tool = [0,-20,0];
vax_tool = [0,1,0];

%Pre-op plan
ApatCT = [-2,8,5];
BpatCT = [4,8,5];
CpatCT = [-2,14,5];

TumCtrCT = [0,0,0];
TumRadCT = 2;
WinCtrCT = [0,5,0];
WinRadCT = 1;

% Navigation Case 2
Apat2Track = [-2,8,55];
Bpat2Track = [4,8,55];
Cpat2Track = [-2,14,55];

AtoolTrack2 = [-2,23,50];
BtoolTrack2 = [4,23,50];
CtoolTrack2 = [-2,29,50];

fprintf('<strong>Case 2:</strong>\n')
surgicalNavigationSimulation(Tip_tool, vax_tool, ApatCT, BpatCT, CpatCT, Apat2Track, Bpat2Track, Cpat2Track, AtoolTrack2, BtoolTrack2, CtoolTrack2, TumCtrCT, TumRadCT, WinCtrCT, WinRadCT, 1)

%% Part 3.3: Surgical Navigation

Tip_tool = [0,-20,0];
vax_tool = [0,1,0];

%Pre-op plan
ApatCT = [-2,8,5];
BpatCT = [4,8,5];
CpatCT = [-2,14,5];

TumCtrCT = [0,0,0];
TumRadCT = 2;
WinCtrCT = [0,5,0];
WinRadCT = 1;

% Navigation Case 3
Apat3Track = [-2,8,55];
Bpat3Track = [4,8,55];
Cpat3Track = [-2,14,55];

AtoolTrack3 = [-3,25,50];
BtoolTrack3 = [3,25,50];
CtoolTrack3 = [-3,31,50];

fprintf('<strong>Case 3:</strong>\n')
surgicalNavigationSimulation(Tip_tool, vax_tool, ApatCT, BpatCT, CpatCT, Apat3Track, Bpat3Track, Cpat3Track, AtoolTrack3, BtoolTrack3, CtoolTrack3, TumCtrCT, TumRadCT, WinCtrCT, WinRadCT, 1)


%%
% % Plot in 3D
% figure()
% set(gcf, 'renderer', 'zbuffer')
% [Xtum,Ytum,Ztum] = sphere;
% lightGrey = 0.8*[1 1 1]; 
% surface(Xtum*TumRadCT+TumCtr_track(1),Ytum*TumRadCT+TumCtr_track(2),Ztum*TumRadCT+TumCtr_track(3),'FaceColor', 'none','EdgeColor',lightGrey)
% hold on;
% 
% [Xwin,Ywin,Zwin] = sphere;
% lightGreen = 0.8*[1 5 70]; 
% surface(Xwin.*WinRadCT+WinCtr_track(1),Ywin.*WinRadCT+WinCtr_track(2),Zwin.*WinRadCT+WinCtr_track(3),'FaceColor', 'none','EdgeColor',lightGrey)
% 
% hold on;
% drill_tip = Otip_track;                       
% drill_vax = vax_track.*15;                   
% dp = drill_vax-drill_tip;                         
% quiver3(drill_tip(1),drill_tip(2),drill_tip(3),dp(1),dp(2),dp(3),0,'b')
% 
% hold on;
% trajectory_vax = -vax_track(1:2).*10;             
% %dp_trajectory = trajectory_vax-drill_tip; 
% dp_trajectory = -dp*1.5;
% quiver3(drill_tip(1),drill_tip(2),drill_tip(3),dp_trajectory(1),dp_trajectory(2),dp_trajectory(3),0,'--c')
% 
% hold on;
% plot3(Otip_track(1), Otip_track(2), Otip_track(3), '*b')
% hold on;
% 
% xlabel('x');
% ylabel('y');
% zlabel('z');
% xlim([-100 100])
% ylim([-100 100])
% zlim([-100 100])
% title('Surgical Navigation Case 3')
% legend('Tumour', 'Window', 'Drill Axis', 'Drill Tip')

%% Bonus Question 1: Alternative Method of Tool Tip Calibration

fprintf('<strong>Alternative Method Tool Tip Calibration Testing:</strong>\n')
N = 100; %Number of spherical pivot poses

%Generate N random angles between 0 and 30 degrees about the Z axis
%   Note: since this is a cone, x and z pivots are proportional, just with a phase shift
min_angleZ = 0;
max_angleZ = 30;
angleZ = min_angleZ + (max_angleZ-min_angleZ).*rand(N,1);

%Generate N random angles between 0 and 360 degrees about the Y axis
min_angleY = 0;
max_angleY = 360;
angleY = min_angleY + (max_angleY-min_angleY).*rand(N,1);

%Start with ground-truth model of the tracked tool
Tip_tool_gt = [0,-20,0]';
At_track_gt = -Tip_tool_gt + [-2,-2,0]';
Bt_track_gt = -Tip_tool_gt + [4,-2,0]';
Ct_track_gt = -Tip_tool_gt + [-2,4,0]';

%Initialize array of pose vectors
At_track = ones(N,3);
Bt_track = ones(N,3);
Ct_track = ones(N,3);

for i = 1:N
    %Generate rotation matrix about the z axis
    [~,R4by4Z] = rotationMatrixAboutFrameAxis(3,angleZ(i));
    %Generate rotation matrix about the y axis
    [~,R4by4Y] = rotationMatrixAboutFrameAxis(2,angleY(i));
    
    %Apply rotations with padding
    A_rotated = R4by4Z*R4by4Y*[At_track_gt;1];
    At_track(i,:) = A_rotated(1:3);
    B_rotated = R4by4Z*R4by4Y*[Bt_track_gt;1];
    Bt_track(i,:) = B_rotated(1:3);
    C_rotated = R4by4Z*R4by4Y*[Ct_track_gt;1];
    Ct_track(i,:) = C_rotated(1:3);
end

[Tip_tool_alt] = toolTipCalibrationTransformOffset(At_track,Bt_track,Ct_track)

%Check that output solution matches ground truth
Tip_tool_alt_checkEqual = isequal(Tip_tool_alt,Tip_tool_gt')

%% Bonus Question 2: Second Alternative Method of Tool Tip Calibration

fprintf('<strong>Second Alternative Method Tool Tip Calibration Testing:</strong>\n')
N = 100; %Number of spherical pivot poses

%Generate N random angles between 0 and 30 degrees about the Z axis
%   Note: since this is a cone, x and z pivots are proportional, just with a phase shift
min_angleZ = 0;
max_angleZ = 30;
angleZ = min_angleZ + (max_angleZ-min_angleZ).*rand(N,1);

%Generate N random angles between 0 and 360 degrees about the Y axis
min_angleY = 0;
max_angleY = 360;
angleY = min_angleY + (max_angleY-min_angleY).*rand(N,1);

%Start with ground-truth model of the tracked tool
Tip_tool_gt = [0,-20,0]';
At_track_gt = -Tip_tool_gt + [-2,-2,0]';
Bt_track_gt = -Tip_tool_gt + [4,-2,0]';
Ct_track_gt = -Tip_tool_gt + [-2,4,0]';

%Initialize array of pose vectors
At_track = ones(N,3);
Bt_track = ones(N,3);
Ct_track = ones(N,3);

for i = 1:N
    %Generate rotation matrix about the z axis
    [~,R4by4Z] = rotationMatrixAboutFrameAxis(3,angleZ(i));
    %Generate rotation matrix about the y axis
    [~,R4by4Y] = rotationMatrixAboutFrameAxis(2,angleY(i));
    
    %Apply rotations with padding
    A_rotated = R4by4Z*R4by4Y*[At_track_gt;1];
    At_track(i,:) = A_rotated(1:3);
    B_rotated = R4by4Z*R4by4Y*[Bt_track_gt;1];
    Bt_track(i,:) = B_rotated(1:3);
    C_rotated = R4by4Z*R4by4Y*[Ct_track_gt;1];
    Ct_track(i,:) = C_rotated(1:3);
end

[Tip_tool_alt2] = toolTipCalibrationPosePlanes(At_track,Bt_track,Ct_track)

fprintf('Rounding Tip_tool_alt2 to 0 decimal places:\n')
%define precision
numDecimals = 0; %round to 0 decimal places
f = 10.^numDecimals;
Tip_tool_alt2_nodecimals = round(f.*Tip_tool)./f

%Check that output solution matches ground truth
Tip_tool_alt2_checkEqual = isequal(Tip_tool_alt2_nodecimals,Tip_tool_gt')



