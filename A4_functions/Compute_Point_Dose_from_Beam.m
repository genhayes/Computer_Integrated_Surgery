%Genevieve Hayes
%Dec 2020

function [point_dose_value] = Compute_Point_Dose_from_Beam(dose_absorption_function_table,depth_from_skin,radial_dose_function_table,radial_distance)
%COMPUTE_POINT_DOSE_FROM_BEAM Computed the dose at a point of interest from
%a beam.
%[point_dose_value] = Compute_Point_Dose_from_Beam(dose_absorption_function_table,epth_from_skin,radial_dose_function_table,radial_distance)

%Compute closest depth absorption dose
[closest_depth,ind_closest_depth] = min(abs(dose_absorption_function_table.Depth-ones(length(dose_absorption_function_table.Depth),1).*depth_from_skin));
depth_dose = dose_absorption_function_table.Dose(ind_closest_depth);

%Compute closest radial dose
[closest_rad,ind_closest_rad] = min(abs(radial_dose_function_table.Radial_Distance-ones(length(radial_dose_function_table.Radial_Distance),1).*radial_distance));
rad_dose = radial_dose_function_table.Dose(ind_closest_rad);

%Compute full dose
point_dose_value = depth_dose*rad_dose;
end

