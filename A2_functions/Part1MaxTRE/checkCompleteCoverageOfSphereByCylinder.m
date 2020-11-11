% Genevieve Hayes
% CISC 330 - A2 Question 1

function checkCoverage = checkCompleteCoverageOfSphereByCylinder(C,R,r,P,v,margin)
%CHECKCOMPLETECOVERAGEOFSPHEREBYCYLINDER determines if a sphere is 
%completely surrounded by a cylinder and returns 0 if it does not, 1 if the 
%it does or 2 if the the sphere and cylinder intersect only partially. 
%checkCoverage = checkCompleteCoverageOfSphere(C,R,r,P,v) where the sphere is 
%defined by by its center (C) and radius (R), and the cylinder is given by 
%its radius (r), a point on its central axis (P) and the direction vector 
%of its central axis (v). The margin is the defined as the extra
%coverage of the cylinder required around the sphere and can be set to 0 is
%not applicable.

    P1 = P;
    P2 = C;
    v1 = v;
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
        checkCoverage = 0;
    else
        V = [-v1', v2', v3'];
        P = [P1(1)-P2(1); P1(2)-P2(2); P1(3)-P2(3)];
        t = inv(V)*P;
        cylinder_center = P1+(t(1).*v1);
        
        d = abs(cylinder_center-C);
        d_between_centers = sqrt(d(1).^2+d(2).^2+d(3).^2);
        
        %round d_between_centers to 2 decimal places 
        Ndecimals = 2;
        f = 10.^Ndecimals;
        d_between_centers = round(f*d_between_centers)/f;
        
        max_wiggle_room = r-R-margin;
        
        if d_between_centers < max_wiggle_room
            checkCoverage = 1;
        elseif d_between_centers-r-R > 0
            checkCoverage = 0;
        elseif d_between_centers-r-R <= 0
            checkCoverage = 2;
        else
            fprintf('Error in checkCompleteCoverageOfSphereByCylinder')
            checkCoverage = Nan;
        end
    end
        
end
