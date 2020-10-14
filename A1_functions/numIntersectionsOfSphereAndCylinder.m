% Genevieve Hayes
% CISC 330 - A1 Question 4

function numInt = numIntersectionsOfSphereAndCylinder(C,R,r,P,v)
%NUMINTERSECTIONSOFSPHEREANDCYLINDER computes the number of intersections of a 
%sphere and an infinite cylinder; 0 if none, 1 if the cylinder and sphere just touch
%or 2 if the cylinder enters and exits the sphere from different locations. 
%numInt = intersectionOfSphereAndCylinder(C,R,r,P,v) where the sphere is 
%defined by by its center (C) and radius (R), and the cylinder is given by 
%its radius (r), a point on its central axis (P) and the direction vector 
%of its central axis (v).

    P1 = P;
    P2 = C;
    v1 = v
    if v(3) == 0
        syms q
            equ = v1(1) + v1(2) + q == 0;
    else 
        syms q
            equ = v1(1) + v1(2) + v1(3).*q == 0;
    end
        
    q_solved = solve(equ);
    
    v2 = [1,1,q_solved];
    v2 = v2./norm(v2);
    v3 = cross(v2,v1); %Find vector orthogonal to both line 1 and line 2
    if cross(v2,v1) == [0,0,0] %if the vectors are parallel
        numInt = 0;
    else
        V = [-v1', v2', v3'];
        P = [P1(1)-P2(1); P1(2)-P2(2); P1(3)-P2(3)];
        t = inv(V)*P;
        L1 = P1+(t(1).*v1);
        
        d = abs(L1-C);
        num = sqrt(d(1).^2+d(2).^2+d(3).^2) - R - r;
        
        %round num to 2 decimal places 
        Ndecimals = 2;
        f = 10.^Ndecimals;
        num = round(f*num)/f;
        
        if num < 0
            numInt = 2;
        elseif num > 0
            numInt = 0;
        else num == 0
            numInt = 1;
        end
    end
        
    
    %d = abs(P-C)./sqrt(1+(v.*v));
    %if dM > 0.00
        %numInt = 0;
    %else 
    %    d = abs(L1-C)./sqrt(1+(v.*v));
    
   % num = sqrt(d(1).^2+d(2).^2+d(3).^2) - R - r;

end

