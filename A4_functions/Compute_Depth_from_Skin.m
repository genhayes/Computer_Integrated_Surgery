%Genevieve Hayes
%Dec 2020

function [depth_from_skin] = Compute_Depth_from_Skin(point_of_interest, beam_nvectors, beam_index, isocenter, skin_entry_points)
%COMPUTE_DEPTH_FROM_SKIN Summary of this function goes here
%[depth_from_skin] = Compute_Depth_from_Skin(point_of_interest, beam_nvectors, beam_index, isocenter, skin_entry_points)

[~,radial_distance_vector] = distanceBetweenLineAndPoint(isocenter,isocenter+beam_nvectors(beam_index,:),point_of_interest);

point_onbeam = point_of_interest+radial_distance_vector;
depth_from_skin = norm(skin_entry_points(beam_index,:) - point_onbeam);

end

