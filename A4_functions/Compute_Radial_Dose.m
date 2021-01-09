%Genevieve Hayes
%Dec 2020

function [radial_dose_function_table] = Compute_Radial_Dose(start_radial_dose,end_radial_dose,increment)
%COMPUTE_RADIAL_DOSE builds a look up table for the Radial Dose Function
%from start_radial_dose to end_radial_dose
%[radial_dose_function_table] = Compute_Radial_Dose(start_radial_dose,end_radial_dose,increment)
%where start_radial_dose and end_radial_dose are in mm and radial_dose_function_table is a
%table with columns 'Radial_Distinace' in mm and 'Dose' in %. Increment is the amount to increment the depth 
%by in mm.

num_points = abs(start_radial_dose - end_radial_dose);
Radial_Distance = zeros(num_points,1)';
Dose = zeros(num_points,1)';

%Define slope for dose drop-off
m = 1/15;

%Compute dose values based on radial distance range
for i = 0:increment:num_points
    ind = round(i./increment);
    Radial_Distance(ind+1) = start_radial_dose + i;
    if i+start_radial_dose<=-22.5 || i+start_radial_dose>=22.5
        Dose(ind+1) = 0;
    
    elseif i+start_radial_dose>-22.5 && i+start_radial_dose<=-7.5
        Dose(ind+1) = m*(start_radial_dose + i)+1.5;
    
    elseif i+start_radial_dose>-7.5 && i+start_radial_dose<=7.5
        Dose(ind+1) = 1;
    
    elseif i+start_radial_dose>7.5 || i+start_radial_dose<22.5
        Dose(ind+1) = -m*(start_radial_dose + i)+1.5;
        
    end
end

%Build table
radial_dose_function_table = table(Radial_Distance(:), Dose(:), 'VariableNames', {'Radial_Distance', 'Dose'});

end

