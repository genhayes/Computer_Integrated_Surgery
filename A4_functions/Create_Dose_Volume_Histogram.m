%Genevieve Hayes
%Dec 2020

function [relative_dose,ratio_of_total_structure_volume] = Create_Dose_Volume_Histogram(point_doses,D100,dose_max,inc)
%CREATE_DOSE_VOLUME_HISTOGRAM Calculates ratio_of_total_structure_volume
%(%) and relative_dose (%) for a Dose Volume Histogram.
%[relative_dose,ratio_of_total_structure_volume] = Create_Dose_Volume_Histogram(point_doses,D100,dose_max,inc)

num_voxels = length(point_doses);

%Initialize arrays and increment
ratio_of_total_structure_volume = zeros(dose_max,1);
relative_dose = zeros(dose_max,1);
i = 1;

for dose = 0:inc:dose_max
    %calcualte ratio of total structure volume and relative dose 
    ratio_of_total_structure_volume(i) = sum(point_doses>dose)/num_voxels*100; %percent
    relative_dose(i) = dose/D100*100; %percent
    i = i+1;
end

end

