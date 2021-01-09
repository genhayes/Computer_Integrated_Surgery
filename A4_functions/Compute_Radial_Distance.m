%Genevieve Hayes
%Dec 2020

function radial_distance = Compute_Radial_Distance(point_of_interest, beam_nvectors, beam_index, isocenter)
%COMPUTE_RADIAL_DISTANCE Computes the radial distance between a point of
%interest and the center line of a beam.
%radial_distance = Compute_Radial_Distance(point_of_interest,
%beam_nvectors, beam_index, isocenter)

[radial_distance, ~] = distanceBetweenLineAndPoint(isocenter,isocenter+beam_nvectors(beam_index,:),point_of_interest);

end

