%Genevieve Hayes
%Dec 2020

function [points,point_doses] = Compute_Dose(dose_box, increment, beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,indices_unsafe)
%CREATE_POINTS_IN_BOX Computes equidistant points inside a dose_box and the
%dose at those points.
%points,point_doses] = Compute_Dose(dose_box, increment, beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,indices_unsafe)

%Determine the number of grid points in x,y and z
numx = length(dose_box(1)-dose_box(4)/2:increment:dose_box(1)+dose_box(4)/2);
numy = length(dose_box(2)-dose_box(5)/2:increment:dose_box(2)+dose_box(5)/2);
numz = length(dose_box(3)-dose_box(6)/2:increment:dose_box(3)+dose_box(6)/2);

%Initialize arrays
points = zeros(numx*numy*numz,3);
point_doses = zeros(numx*numy*numz,1);
ind = 1;

for xbox = dose_box(1)-dose_box(4)/2:increment:dose_box(1)+dose_box(4)/2
    for ybox = dose_box(2)-dose_box(5)/2:increment:dose_box(2)+dose_box(5)/2
        for zbox = dose_box(3)-dose_box(6)/2:increment:dose_box(3)+dose_box(6)/2
 
            point_of_interest = [xbox,ybox,zbox];
            points(ind,:) = point_of_interest;
            %Calculate dose at each point
            point_doses(ind) = Compute_Dose_from_All_Beams(point_of_interest,beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,indices_unsafe);
            ind=ind+1;
            
        end
    end
end

end

