function [full_point_dose_value] = Compute_Dose_from_All_Beams(point_of_interest,beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,indices_unsafe)
%COMPUTE_DOSE_FROM_ALL_BEAMS Computes the dose in a given point of interest
%from all beams.
%[full_point_dose_value] = Compute_Dose_from_All_Beams(point_of_interest,beam_nvectors,beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,indices_unsafe)

point_dose_values = zeros(length(beam_nvectors),1);

for i = 1:length(beam_nvectors)
    if any(indices_unsafe(:) == i)
        point_dose_values(i) = 0;
    else
        [radial_distance] = Compute_Radial_Distance(point_of_interest, beam_nvectors, i, isocenter);
        [depth_from_skin] = Compute_Depth_from_Skin(point_of_interest, beam_nvectors, i, isocenter, skin_entry_points);
        [point_dose_value] = Compute_Point_Dose_from_Beam(dose_absorption_function_table,depth_from_skin,radial_dose_function_table,radial_distance);
    
        point_dose_values(i) = point_dose_value;
    end
end

full_point_dose_value = sum(point_dose_values);

end

