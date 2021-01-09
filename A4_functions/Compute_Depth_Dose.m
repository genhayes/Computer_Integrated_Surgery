%Genevieve Hayes
%Dec 2020

function [dose_absoroption_function_table] = Compute_Depth_Dose(max_head_size,increment)
%COMPUTE_DEPTH_DOSE builds a look up table for the Dose Absorption Function
%from 0 to the maximum head size.
%[dose_absoroption_function_table] = Compute_Depth_Dose(max_head_size, increment)
%where max_head_size is in mm and increment is the amount to increment the depth 
%by in mm, dose_absoroption_function_table is a table with columns 'Depth' 
%in mm and 'Dose' in %.

%Initialize Depth and Dose arrays
Depth = zeros(max_head_size,1)';
Dose = zeros(max_head_size,1)';

%Compute dose values based on skin depth
for depth_from_skin = 0:increment:20
    i = round(depth_from_skin./increment);
    Depth(i+1) = depth_from_skin;
    Dose(i+1) = 0.025.*depth_from_skin+0.5;
end

if max_head_size > 20 %mm
    for depth_from_skin = 21:increment:max_head_size
        i = round(depth_from_skin./increment);
        Depth(i+1) = depth_from_skin;
        Dose(i+1) = -0.005.*depth_from_skin+1.1;
    end 
end

%Build table
dose_absoroption_function_table = table(Depth(:), Dose(:), 'VariableNames', {'Depth', 'Dose'});

end

