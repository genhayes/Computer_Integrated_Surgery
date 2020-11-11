function [correspondence] = buildCorrespondenceMatrixFromREMs(REMs)
%BUILDCORRESPONDENCEMATRIXFROMREMS Builds the correspondence matrix from
%the REMs matrix developed from reconstructing Cyber Knife target points
%from Detector A and B images.
%[correspondence] = buildCorrespondenceMatrixFromREMs(REMS) where REMs is
%an NxN matrix were the row number corresponds to the vector number from
%ImgPtsA and the column number corresponds to the vector number from
%ImgPtsB. The output is the correspondence matrix where column 1 are
%the indices of the target number in the Detector A image points and column
%2 are the indices of the target number in the Detector B image points.

% Build correspondence matrix from REMs
[REM_numrows, REM_numcolumns] = size(REMs);

% Find index of closest approach
%[Min, Ind] = min(REMs,[],1);
%[~, Ind] = min(REMs,[],1);

[MinAInd,MinBInd] = find(REMs<0.00001);

% If each element in row or column is not UNIQUE then there is ambiguity in
% the signals;
if length(MinAInd) ~= length(unique(MinAInd)) || length(MinBInd) ~= length(unique(MinBInd))
    msg = 'ERROR: Ambiguous REMs matrix, cannot compute correspondence matrix';
    error(msg)
    %disp(msg);
else
    correspondence = ones(REM_numcolumns,2);
    for i = 1:REM_numcolumns
        [~, Ind_minInColumn] = min(REMs(:,i));
        [~, Ind_minInRow] = min(REMs(i,:));
        A = i; %label markers based on the order that they appear in A
        B = Ind_minInColumn;

        correspondence(i,1) = A;
        correspondence(i,2) = B;
    end
end
end

