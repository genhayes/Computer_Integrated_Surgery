% Genevieve Hayes
% CISC 330 - A1 Question 2

function Int = intersectionOfVectorWithPlane(A,n,P,v)
%INTERSECTIONOFVECTORWITHPLANE computes the intersection, Int, of a vector 
%and a plane. 
%Int = intersectionOfVectorWithPlane(A,n,P,v) where the plane is defined by
%a given point A and its normal vector n, and the vector is
%defined by fixed point P and direction vector v.

    if n.*v ==0 %check if via dot product (n.*v)
        fprintf('Error: Vector and plane are parallel!\n');
        Int = [NaN NaN NaN];
    else
        t = ((A-P).*n)/(v.*n);
        Int = P + t*v;
    end
    
%     fprintf('Line intersects with the plane at: [');
%     fprintf('%g ', Int);
%     fprintf(']\n');
%     fprintf('---\n');
end

