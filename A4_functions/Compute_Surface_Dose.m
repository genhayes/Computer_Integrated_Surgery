%Genevieve Hayes 
%Dec 2020

function [points,point_doses] = Compute_Surface_Dose(num_points,sphere_center,sphere_radius,beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,indices_unsafe)
%COMPUTE_SURFACE_DOSE Generates points on the surface of a sphere and
%determines the dose at each point
%[points,point_doses] = Compute_Surface_Dose(num_points,sphere_center,sphere_radius,beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,indices_unsafe)

%Generate points on surface of sphere
rng(0,'twister')
rvals = 2*rand(num_points,1)-1;
elevation = asin(rvals);
azimuth = 2*pi*rand(num_points,1);
radii = sphere_radius*(ones(num_points));
[x,y,z] = sph2cart(azimuth,elevation,radii);

X = x+sphere_center(1);
Y = y+sphere_center(2);
Z = z+sphere_center(3);

%Initialize arrays
points = zeros(length(X),3);
point_doses = zeros(length(X),1);
ind = 1;

for i = 1:length(X)
    %Identify each point on surface
    point_of_interest = [X(i),Y(i),Z(i)];
    points(i,:) = point_of_interest;
    %Compute dose at each point
    point_doses(i) = Compute_Dose_from_All_Beams(point_of_interest,beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,indices_unsafe);
    ind=ind+1;
            
end


end

