%Genevieve Hayes
%Dec 2020

function [doseColors] = Create_Color_Map(x,dose)
%CREATE_COLOR_MAP Creates a color map for the dose values of coordinates.
%[doseColors] = Create_Color_Map(x,dose)

%Create a colormap
numPoints = length(x);
cmap = jet(numPoints);
%Make doses into a colormap.
minDose = min(dose);
maxDose = max(dose);
%Get a percentage of the way the doses are from max to min
percentage = (maxDose - dose) / (maxDose - minDose);
%Find the index for each dose in the range 1 to the number of colors in our colormap
indexes = round(percentage * (numPoints - 1)  + 1);

doseColors = cmap(numPoints-indexes+1, :);

end

