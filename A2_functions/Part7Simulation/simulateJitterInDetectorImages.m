function [TREck,REMck] = simulateJitterInDetectorImages(MarkerPtsCK, Magnitude_jitter,SDD, ADD, angleA,angleB)
%SIMULATEJITTERINDETECTORIMAGES Summary of this function goes here
%[TREck, REMck] = simulateJitterInDetectorImages(MarkerPtsCK, Magnitude_jitter)
%where markersCK is a 2D array of vectors where each column represents one
%point in 3D space in the Cyber Knife frame and Magnitude_jitters is a 
%scalar distance corresponding to the magnitude of the image point error 
%in mm. TREck is a vector of the norm

%Project markers onto the detector images
[ImgPtsA, ImgPtsB] = projectCKpointOntoDetectorImages(MarkerPtsCK, SDD, ADD, angleA,angleB);

%Initialize matrix of jittered image points
ImgPtsA_jitter = ones(size(ImgPtsA));
ImgPtsB_jitter = ones(size(ImgPtsA));

[~,num_points] = size(MarkerPtsCK);

%Add jitter to each of the detector points in the detector frame
for k=1:num_points
    %Generate 2D random error vectors
    ErrA = Magnitude_jitter*Random_Unit_Vector(2);
    ErrB = Magnitude_jitter*Random_Unit_Vector(2);
    ImgPtsA_jitter([1 3],k) = ImgPtsA([1 3],k) + ErrA;
    ImgPtsA_jitter(2,k) = ImgPtsA(2,k);
    ImgPtsB_jitter([1 3],k) = ImgPtsB([1 3],k) + ErrB; 
    ImgPtsB_jitter(2,k) = ImgPtsB(2,k);
end

%Reconstruct all possible marker locations and their corresponding REMs
[TargetPtsCK3D,REMs] = reconstructCKTargetMatrixFromDetectorImages(ImgPtsA_jitter,ImgPtsB_jitter, ADD, angleA, angleB);

%Use the diagonal of the correspondence Matrix
range = 1:1:num_points;
correspondenceMatrix = [range',range'];

%Get actual reconstructed marker locations by correlating the correspondence matrix with all possible marker locations
TargetPtsCK2D = getCorrespondenceTargetPoints(TargetPtsCK3D, correspondenceMatrix);
%Get REMS of actual reconstructed marker locations by correlating the
%correspondence matrix with all REMs
%%REMck = getCorrespondenceTargetPoints(REMs, correspondenceMatrix);
[REMck] = getCorrespondenceREM(REMs, correspondenceMatrix);
%Calculate the TRE by taking the magnitude of the difference between the real and
%reconstructed marker points 
TREck = vecnorm(MarkerPtsCK - TargetPtsCK2D);

%Debugging tools
difIm = ImgPtsA_jitter(:,k) - ImgPtsA(:,k);

ImgPtsA = ImgPtsA;
ImgPtsA_jitter = ImgPtsA_jitter;

ImgPtsB = ImgPtsB;
ImgPtsB_jitter = ImgPtsB_jitter;
end

