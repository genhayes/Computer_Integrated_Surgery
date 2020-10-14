% Genevieve Hayes
% CISC 330 - A1 Question 3

function [numInt,Int1,Int2] = intersectionOfVectorWithEllipsoid(P,v,a,b,c)
%INTERSECTIONOFVECTORWITHELLIPSOID computes the intersection(s), Int, of a 
%vector and the canonical ellipsoid with half-axes lengths a, b, c. 
%[numInt,Int1,Int2] = intersectionOfVectorWithEllipsoid(P,v,a,b,c) where 
%the vector is defined by fixed point P and direction vector v, and the
%ellipsoid is defined by its half-axes lengths, centred at (0,0,0) and 
%satisfying the equation x^2/a^2 + y^2/b^2 + z^2/c^2 = 1.
%  If the vector does not intersect with the ellipsoid, NaNs are returned
%  for Int1 and Int2.
%  If a single point of intersection occurents, Int1 = Int2.
%  If two points of intersetion occur, two distinct Int1 and In2 are
%  returned.

    syms t
    L = P+(t*v);
    x = L(1); %P(1)+(t*v(1)); 
    y = L(2); %P(2)+(t*v(2));
    z = L(3); %P(3)+(t*v(3));

    equ = x^2/a^2 + y^2/b^2 + z^2/c^2 - 1 == 0;
    t_solved = solve(equ);

    if isreal(t_solved) %Check if any intersections occur
        Int1 = double([subs(L(1), t, t_solved(1)), subs(L(2), t, t_solved(1)), subs(L(3), t, t_solved(1))]);
        Int2 = double([subs(L(1), t, t_solved(2)), subs(L(2), t, t_solved(2)), subs(L(3), t, t_solved(2))]);
        if Int1 == Int2
            numInt = 1;
        else 
            numInt = 2;
        end
    else %No intersections if t_solved contains imaginary numbers
        Int1 = [NaN,NaN,NaN];
        Int2 = [NaN,NaN,NaN];
        numInt = 0;
    end

    fprintf('The number of intersections with the ellipsoid is: [');
        fprintf(' %g ', numInt);
        fprintf(']\n');
        fprintf('The Line intersections with the ellipsoid at: [');
        fprintf(' %g ', Int1);
        fprintf(']\n');
        fprintf('and at: [');
        fprintf(' %g ', Int2);
        fprintf(']\n');
        fprintf('---\n');
end

