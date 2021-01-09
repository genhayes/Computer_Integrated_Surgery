%Genevieve Hayes
%Nov 20, 2020

function [checkCongruent] = checkTrianglesCongruent(A0,B0,C0,A,B,C)
%CHECKTRIANGLESCONGRUENT checks if the triangle formed by A, B, C is
%congruent to the A0, B0, C0.
%[checkCongruent] = checkTrianglesCongruent(A0,B0,C0,A,B,C) where A0, B0,
%C0 and A, B, C are vectors corresponding to the corners of two triangles.

AB = norm(A - B);
BC = norm(B - C);
CA = norm(C - A);

AB0 = norm(A0 - B0);
BC0 = norm(B0 - C0);
CA0 = norm(C0 - A0);

if abs(AB0 - AB) < 0.0001 && abs(BC0 - BC) < 0.0001 && abs(CA0 - CA) < 0.0001
    checkCongruent = 1;
else
    checkCongruent = 0;
end

end

