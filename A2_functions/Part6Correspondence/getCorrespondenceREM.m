function [REMck] = getCorrespondenceREM(REMs, correspondenceMatrix)
%GETCORRESPONDENCEREM retrieves the reconstructed REM 
%found in the correspondence matrix between the Detector A and B images.
%[REMck] = getCorrespondenceREM(REMs, correspondenceMatrix)
%where REMs is a 2D array of all posible REM values 
%in CK frame where each row of REM corresponds to the input 
%ImgPtsA column and each column of REM corresponds to the input 
%ImgPtsB column. The correspondence matrix is defined such that column 1 
%are the indices of the target number in the Detector A image points and 
%column 2 are the indices of the target number in the Detector B image points. 
%REMck is a is a 1D array of vectors where each value represents the REM for the
%Corresponding target point in the Cyber Knife frame.

%Get points from TargetPtsCK using correspondence matrix
[numpoints, ~] = size(correspondenceMatrix);
matrix_depth = size(REMs,3);
REMck = zeros(matrix_depth,numpoints);

for i = 1:numpoints
    
    %Get the indexes of the corresponding points 
    indAindex = correspondenceMatrix(i,1);
    indBindex = correspondenceMatrix(i,2);
    
    REMck(:,i) = REMs(indBindex,indAindex);
end

end


