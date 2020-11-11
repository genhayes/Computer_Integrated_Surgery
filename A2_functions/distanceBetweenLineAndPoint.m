function [distance] = distanceBetweenLineAndPoint(L1,L2,P)
%DISTANCEBETWEENLINEANDPOINT determines the closest distance between a line
%and a point.
%[d] = distanceBetweenLineAndPoint(L1,L2,P) where L1 is a point on the line
%and L2 is another point on the line. P is the point with which to find the
%closest approach of the line.

%Calculate the distance between the point and the line
d_PtoL1 = L1-P;

Lvector = L2-L1;
Lnorm = Lvector/norm(Lvector);

dvector = d_PtoL1 - (dot(d_PtoL1,Lnorm)*(Lnorm));

%Caluclate magnitude of distance vector
distance = norm(dvector);
end

