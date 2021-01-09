function [dose_box] = Compute_Dose_Box(ptv_center, ptv_radius, oar_center, oar_radius)
%COMPUTE_DOSE_BOX calculates the dose box around the Prescribed Target
%Volume and the Organ at Risk.
%[dose_box] = Compute_Dose_Box(ptv_center, ptv_radius, oar_center,
%   oar_radius) where the 3D center coordinates and radii are in mm. dose
%   box is a 1D array with the 3D coordinates of the box center and box
%   side lengths;

%Calculate all possible extents of the dose box
box_extents = zeros([4,3]);
box_extents(1,:) = ptv_center + ptv_radius;
box_extents(2,:) = ptv_center - ptv_radius;
box_extents(3,:) = oar_center + oar_radius;
box_extents(4,:) = oar_center - oar_radius;

%Calculate box center
box_center = (ptv_center + oar_center)/2;

%Calculate max side lengths
box_max = max(box_extents);
box_min = min(box_extents);
box_side_lengths = box_max - box_min;

dose_box = [box_center,box_side_lengths];
end

