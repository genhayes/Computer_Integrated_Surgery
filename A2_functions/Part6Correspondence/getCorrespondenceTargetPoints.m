function [TargetPtsCK2D] = getCorrespondenceTargetPoints(TargetPtsCK3D, correspondenceMatrix)
%GETCORRESPONDENCETARGETPOINTS retrieves the reconstructed target points 
%found in the correspondence matrix between the Detector A and B images.
%[TargetPtsCK2D] = getCorrespondenceTargetPoints(TargetPtsCK3D,
%correspondenceMatrix) where TargetPtsCK3D is a 3D array of target points 
%in CK frame where each row of TargetPtsCK3D corresponds to the input 
%ImgPtsA column and each column of TargetPtsCK3D corresponds to the input 
%ImgPtsB column. The correspondence matrix is defined such that column 1 
%are the indices of the target number in the Detector A image points and 
%column 2 are the indices of the target number in the Detector B image points. 
%TargetPtsCK2D is a is a 2D array of vectors where each column represents 
%one target point in 3D space in the Cyber Knife frame.

%Get points from TargetPtsCK using correspondence matrix
[numpoints, ~] = size(correspondenceMatrix);
matrix_depth = size(TargetPtsCK3D,3);
TargetPtsCK2D = zeros(matrix_depth,numpoints);

for i = 1:numpoints
    
    %Get the indexes of the corresponding points 
    indAindex = correspondenceMatrix(i,1);
    indBindex = correspondenceMatrix(i,2);
    
    TargetPtsCK2D(:,i) = TargetPtsCK3D(indBindex,indAindex,:);
end

end

