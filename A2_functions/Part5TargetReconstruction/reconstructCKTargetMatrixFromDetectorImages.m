function [TargetPtsCK3D,REMs] = reconstructCKTargetMatrixFromDetectorImages(ImgPtsA,ImgPtsB, ADD, angleA, angleB)
%RECONSTRUCTCKTARGETMATRIXFROMDETECTORIMAGES reconstructs a set of target
%points in CK frame from their image points on Detectors A and B.
%[TargetPtsCK,REMs] =
%reconstructCKTargetMatrixFromDetectorImages(ImgPtsA,ImgPtsB, ADD, angleA, angleB) where ImgPtsA
%and ImgPtsB are 2D arrays of vectors where each column represents one
%point on the detector in Detector frames A and B respectively.
%TargetPtsCK3D is a 3D array of target points in CK frame where each row of 
%TargetPtsCK3D corresponds to the input ImgPtsA column and each column of 
%TargetPtsCK3D corresponds to the input ImgPtsB column. REMs is a 2D array 
%of the residual error metrics for each target vector in TargetPtsCK3D.

[~,num_points] = size(ImgPtsA); %The number of columns corresponds to the number of input points

% Initialize target and REM arrays
TargetPtsCK3D = zeros([num_points,num_points,3]);
REMs = ones(num_points,num_points);

for i = 1:num_points %iterate over detector A points
    for j = 1:num_points %iterate over detector A points
        [TargetPtCK,REM] = generateCKTargetPointAndREMfromABImagePoint(ImgPtsA(:,i), ImgPtsB(:,j), ADD, angleA, angleB);
        REMs(i,j) = REM; %build REMs matrix with euclidean errors
        TargetPtsCK3D(i,j,:) = TargetPtCK; %build TargetPtsCK matrix with the points of closest intersection

    end 
end
end

