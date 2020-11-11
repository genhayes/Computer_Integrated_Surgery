function [ImgPtsA, ImgPtsB] = projectCKpointOntoDetectorImages(MarkerPtsCK, SDD, ADD, angleA,angleB)
%PROJECTCKPOINTONTODETECTORIMAGES is the digital radiography projector that
%computes the projected position of the detector image points corresponding 
%to a series of 3D points in the Cyber Knife frame.
%[ImgPtsA, ImgPtsB] = projectCKpointOntoDetectorImages(MarkerPtsCK) where
%MarkerPtsCK is a 2D array of vectors where each column represents one
%point in 3D space in the Cyber Knife frame. ImgPtsA and ImgPtsB are 2D 
%arrays of the vectors projected onto Detectors A and B respectively.
%Lengths are in mm.

% Define source A and B locations relative to Detector A and B respectively
% (mm)
P_SA = [0,SDD,0,1]';
P_SB = [0,SDD,0,1]';
% Define center point and normal vector of 
A_A = [0,0,0];
n_A = [0,1,0];
A_B = [0,0,0];
n_B = [0,1,0];
% Generate frame transformation martices from CK frame to Detector frames
[TransCKtoA,TransCKtoB] = generateFrameTransformsForCKToDetectors(angleA,angleB,ADD);

[num_rows,num_columns] = size(MarkerPtsCK);
% Initialize image arrays
ImgPtsA = zeros(size(MarkerPtsCK));
ImgPtsB = zeros(size(MarkerPtsCK));

for i = 1:num_columns
    % Transform one vector at a time and zero pad
    P_CK = vertcat(MarkerPtsCK(:,i),1); 
    
    % Transform point from CK frame to Detector frames
    P_A = TransCKtoA*P_CK;
    P_B = TransCKtoB*P_CK;

    % Calcutate direction vector of point projected onto the Detector A and B
    v_A = (P_A(1:3) - P_SA(1:3));
    v_B = (P_B(1:3) - P_SB(1:3));

    Int_A = intersectionOfVectorWithPlane(A_A,n_A,P_A(1:3)',v_A');
    Int_B = intersectionOfVectorWithPlane(A_B,n_B,P_B(1:3)',v_B');
    
    ImgPtsA(:,i) = Int_A';
    ImgPtsB(:,i) = Int_B';
end
end


