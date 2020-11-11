% Genevieve Hayes
% CISC 330 - A2 Question 3

function [TransCKtoA,TransCKtoB] = generateFrameTransformsForCKToDetectors(angleA,angleB,ADD)
%GENERATEFRAMETRANSFORMSFORCKTODETECTORS determines the transformation
%matrices to take a point from Cyber Knife home frame to the detector A and
%B frames.
%[TransCKtoA,TransCKtoB] = generateFrameTransformsForCKToDetectors() where
%TransCKtoA and TransCKtoB are 4x4 transformation matrices such that 
%PA = TransCKtoA*PCK and PB = TransCKtoB*PCK.

% Calculate rotation matrix for rotating from detector A to CK (-45
% degrees looking down the -z-axis)
[~,R4by4A] = rotationMatrixAboutFrameAxis(3,angleA);
% Calculate rotation matrix for rotating from detector B to CK (+45
% degrees looking down the -z-axis)
[~,R4by4B] = rotationMatrixAboutFrameAxis(3,angleB);

e1_d = [1,0,0,1]';
e2_d = [0,1,0,1]';
e3_d = [0,0,1,1]';

%Calculate orthogonal basis vectors relative to detector A
e1_ckrelA = R4by4A*e1_d;
e2_ckrelA = R4by4A*e2_d;
e3_ckrelA = R4by4A*e3_d;

%Calculate orthogonal basis vectors relative to detector B
e1_ckrelB = R4by4B*e1_d;
e2_ckrelB = R4by4B*e2_d;
e3_ckrelB = R4by4B*e3_d;

OckrelA = [0,ADD,0]; %The origin of the CK frame realtive to detector A (mm)
OckrelB = [0,ADD,0]; %The origin of the CK frame realtive to detector B (mm)

TransCKtoA = generateFrameTransformationToHome(OckrelA,e1_ckrelA(1:3),e2_ckrelA(1:3),e3_ckrelA(1:3));
TransCKtoB = generateFrameTransformationToHome(OckrelB,e1_ckrelB(1:3),e2_ckrelB(1:3),e3_ckrelB(1:3));
end

