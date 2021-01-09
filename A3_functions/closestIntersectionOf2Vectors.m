% Genevieve Hayes
% CISC 330 - A1 Question 1

function [M,dM] = closestIntersectionOf2Vectors(P1,v1,P2,v2)
%CLOSESTINTERSECTIONOF2VECTORS computes the approximate (symbolic) 
%intersection of two vectors, M, with an error metric, dM.
%[M,dM] = closestIntersectionOf2Vectors(P1,v1,P2,v2) where vector 1 is
%defined by fixed point P1 and direction vector v1, and vector 2 is
%defined by fixed point P2 and direction vector v2.

    v3 = cross(v2,v1); %Find vector orthogonal to both line 1 and line 2
    if cross(v2,v1) == [0,0,0] %if the vectors are parallel
        fprintf('Error: Vectors are parallel!\n');
        M = [NaN NaN NaN];
        dM = [NaN NaN NaN];
    else
        V = [-v1', v2', v3'];
        P = [P1(1)-P2(1); P1(2)-P2(2); P1(3)-P2(3)];
        t = inv(V)*P;
        L1 = P1+(t(1).*v1);
        L2 = P2+(t(2).*v2);
        M = (L2+L1)/2; %Compute closest intersection
        dM = abs(L2-L1)/2; %Compute error in closest intersection
        %M_eulcidean = norm(L2+L1)/2
        %dM_euclidean = norm(L2-L1)/2
    end

    fprintf('Lines intersect approximately at: [');
    fprintf(' %g ', M);
    fprintf(']\n');
    fprintf('The error of the approximate intersect is: [');
    fprintf(' %g ', dM);
    fprintf(']\n');
    fprintf('---\n');
end

