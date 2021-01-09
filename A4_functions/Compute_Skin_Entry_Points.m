%Genevieve Hayes
%Dec 2020

function [skin_entry_points,depth_to_isocenter] = Compute_Skin_Entry_Points(beam_nvectors,isocenter,head_a,head_b,head_c)
%COMPUTE_SKIN_ENTRY_POINT Computes the skin entry point for each beam as
%well as the depth that the isocenter is from that skin entry point.
%[skin_entry_points,depth_to_isocenter] =
%Compute_Skin_Entry_Points(beam_nvectors,isocenter,head_a,head_b,head_c) where
%beam_separation_angle is the angle between beams and isocenter is a 3D point 
%at the center of the PTV. head_a, _b and _c are the half lengths of the
%principal axes of an ellipsoid. skin_entry_points is a 2D array with each 
%row corresponding the the [x,y,z] skin entry point and depth_to_isocenter 
%is a 1D array of euclidean distances.

%Initialize arrays
skin_entry_points = zeros(size(beam_nvectors));
depth_to_isocenter = zeros(length(beam_nvectors),1);

for i = 1:length(beam_nvectors)
    %Compute intersection point of beam with head
    [~,skinpoint,~] = intersectionOfVectorWithEllipsoid(isocenter,-beam_nvectors(i,:),head_a,head_b,head_c);
    skin_entry_points(i,:) = skinpoint;   
    
    %Compute distance between skin entry point and isocenter
    depth_to_isocenter(i) = pdist([skin_entry_points(i,:);isocenter],'euclidean');
    
end

end

