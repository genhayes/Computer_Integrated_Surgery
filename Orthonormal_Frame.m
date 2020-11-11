% 7. Generate-Orthonormal-Frame

% one average, two dot products, and normalizations
% get the center as the average and get the bases as two dot products and
% then normalize in the end

function [ e1, e2, e3, Oe ] = Orthonormal_Frame( A,B,C )
    Oe = (A+B+C)/3;                                 %center of gravity
    e1 = (B-A)/norm(B-A);                           %first basis vector
    e3 = cross(e1, (C-A))/norm(cross(e1, (C-A)));   %third basis vector
    e2 = cross(e3,e1)/norm(cross(e3,e1));           %second basis vector satisfying right hand rule
end
