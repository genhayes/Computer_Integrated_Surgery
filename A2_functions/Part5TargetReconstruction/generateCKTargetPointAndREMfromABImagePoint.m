function [TargetPtCK,REM] = generateCKTargetPointAndREMfromABImagePoint(ImgPtA, ImgPtB, ADD, angleA, angleB)
%GENERATECKTARGETPOINTANDREMFROMABIMAGEPOINT Summary of this function goes here
%RECONSTRUCTCKTARGETMATRIXFROMDETECTORIMAGES reconstructs a single target
%point and its REM in CK frame from an image point on Detectors A and B.
%[TargetPtCK,REM] = generateCKTargetPointAndREMfromABImagePoint(ImgPtA, ImgPtB, ADD, angleA, angleB)) 
%where ImgPtA and ImgPtB are each a column vector of the x-y-z coordinates 
%corresponding to the point on each detector in Detector frames A and B 
%respectively.

%Pad image points with 1
ImgA = vertcat(ImgPtA,1);
ImgB = vertcat(ImgPtB,1);

% Define locations of sources A and B in the CK frame (mm)
P_SACK = [-ADD*cosd(angleA),ADD*sind(angleA),0,1]';
P_SBCK = [ADD*cosd(angleB),-ADD*sind(angleB),0,1]';

% Transform from Detector frames to CK frame
% Generate frame transformation martices from CK frame to Detector frames
[TransCKtoA,TransCKtoB] = generateFrameTransformsForCKToDetectors(angleA,angleB,ADD);

%Transform from detector frames to CK frame
P_ACK = inv(TransCKtoA)*ImgA; %inverse transform to get to CK frame
P_BCK = inv(TransCKtoB)*ImgB;

%Calculate direction vector of each point by pointing it toward its source
v_ACK = (P_ACK(1:3) - P_SACK(1:3));%./norm((P_ACK(1:3) - P_SACK(1:3)));
v_BCK = (P_BCK(1:3) - P_SBCK(1:3));%./norm((P_BCK(1:3) - P_SBCK(1:3)));

%Find the closest intersection point of the lines ImgA to SourceA and ImgB
%to SourceB
[TargetPtCK,~] = closestIntersectionOf2Vectors(P_ACK(1:3)',v_ACK',P_BCK(1:3)',v_BCK');
%Find the error in the closest intersection point of the lines ImgA to SourceA and ImgB
%to SourceB
[~,REM] = closestEuclideanIntersectionOf2Vectors(P_ACK(1:3)',v_ACK',P_BCK(1:3)',v_BCK');

TargetPtCK = TargetPtCK'; %Transform into column vector
end

