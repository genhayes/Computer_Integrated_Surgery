

function [Rworkspace] = calculateWorkspaceRadius(d_StoD,sideLength_D)
%CALCULATEWORKSPACERADIUS determines the radius of a circular workspace
%between a source and a square detector.
%Rworkspace = calculateWorkspaceRadius(d_StoD,sideLength_D) 
%where d_StoD is the distance between the source and the center of the
%detector and sideLength_D is the length of one side of the square detector.

PsourceRelToDetectors = [0;d_StoD/2;0];
detectorEdge = [sideLength_D/2;-d_StoD/2;0];

%Calculate the maximum radius of the workspace
[Rworkspace] = distanceBetweenLineAndPoint(PsourceRelToDetectors,detectorEdge,[0;0;0]);

end

