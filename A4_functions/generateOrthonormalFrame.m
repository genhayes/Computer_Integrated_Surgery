% Genevieve Hayes
% CISC 330 - A1 Question 7

function [Oe,e1,e2,e3] = generateOrthonormalFrame(A,B,C)
%GENERATEORTHONORMALFRAME Creates an orthonormal frame of basis vectors from 
%3 points.
%[Oe,e1,e2,e3] = generateOrthogonalFrame(A,B,C) where A, B and C are 
%points in 2- or 3-dimensional space. The output orthogonal frame is the 
%defined by a centre point (Oe) and 3 base vectors (e1, e2 and e3).

e1 = B-A;
e1 = e1 ./ norm(e1); %Normalize

e3 = cross(e1,(C-A));
e3 = e3 ./ norm(e3); %Normalize

e2 = cross(e3,e1);
e2 = e2 ./ norm(e2); %Normalize

Oe = [(A(1)+B(1)+C(1))/3,(A(2)+B(2)+C(2))/3,(A(3)+B(3)+C(3))/3];

end

