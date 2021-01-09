%% CISC 330 A4
%Genevieve Hayes
%Dec 11, 2020
% This script runs all the tests and simulations for CISC330 A4

close all
clc
clear
%% Initialize constants
DOSE_VOXEL_SIZE = 10; %mm -- set to 1mm to recreate README results

D0 = 1; %unit
D100 = 20; %units (amount of dose prescribed to PTV)
DOARMAX = 10; %units (no part of the OAR can receive more than this dose)
%Helmet
beam_separation_angle = 30; %degrees
beam_diameter = 30; %mm

%PTV and OAR
ptv_radius = 15; %mm
ptv_center = [30, 0, 15]; %mm
oar_radius = 15; %mm
oar_center = [0, 30, 45]; %mm

%Head
head_a = 80; %mm
head_b = 100; %mm
head_c = 80; %mm
head_center = [0, 0, 0]; %mm

isocenter = ptv_center;

%% Part 2: Compute Box Dose
fprintf('<strong>Part 2: Computing Dose Box</strong>\n')

[dose_box] = Compute_Dose_Box(ptv_center, ptv_radius, oar_center, oar_radius);

%% Part 3: Draw 3D Scene
fprintf('<strong>Part 3: Drawing Radiosurgery Scene</strong>\n')

%plot PTV and OAR
[X,Y,Z] = sphere(20);
h1 = surf(ptv_radius*X+ptv_center(1),ptv_radius*Y+ptv_center(2),ptv_radius*Z+ptv_center(3));
set(h1, 'FaceAlpha', 0.4)
shading interp
labelptv = {'PTV'};
text(ptv_center(1)+ptv_radius, ptv_center(2)+ptv_radius, ptv_center(3)+ptv_radius, labelptv,'VerticalAlignment','top','HorizontalAlignment','left')
hold on;
xlim([-150 150])
ylim([-150 150])
zlim([-150 150])
hold on;
h2 = surf(oar_radius*X+oar_center(1),oar_radius*Y+oar_center(2),oar_radius*Z+oar_center(3));
colormap HSV;
set(h2, 'FaceAlpha', 0.8)
shading interp
labeloar = {'OAR'};
text(oar_center(1)+oar_radius, oar_center(2)+oar_radius,oar_center(3)+oar_radius,labeloar,'VerticalAlignment','top','HorizontalAlignment','left')
hold on;
xlabel('x')
ylabel('y')
zlabel('z')

%plot dosebox
box_center = dose_box(1:3);
box_side_lengths = dose_box(4:6);
P = box_center ;   % you center point 
L = box_side_lengths ;  % your cube dimensions 
O = P-L/2 ;       % Get the origin of cube so that P is at center 
plotcube(L,O,.1,[1 0 0]);   % use function plotcube 
labelbox = {'Dose Box'};
text(box_center(1)+box_side_lengths(1)/2, box_center(2)+box_side_lengths(2)/2, box_center(3), labelbox,'VerticalAlignment','bottom','HorizontalAlignment','right')
hold on

%plot isocenter
plot3(isocenter(1),isocenter(2),isocenter(3),'*b','linewidth', 10)
labelisocenter = {'Isocenter'};
text(isocenter(1), isocenter(2),labelisocenter,'VerticalAlignment','top','HorizontalAlignment','left')
hold on

%plot head
[Xhead,Yhead,Zhead] = ellipsoid(head_center(1),head_center(2),head_center(3),head_a,head_b,head_c,20);
head = surf(Xhead,Yhead,Zhead);
set(head, 'FaceAlpha', 0.1)
labelhead = {'Head'};
text(head_center(1), head_center(2)+head_b, head_center(3)+head_c, labelhead,'VerticalAlignment','top','HorizontalAlignment','left')
title('Part 3: Radiosurgery Scene')

%% Part 4: Estimate Dose
fprintf('<strong>Part 4: Estimating Dose</strong>\n')

%In a half-sphere, 37 beams can fit with a 30 degree distance between them
num_beams = (90/beam_separation_angle)*(360/beam_separation_angle) + 1; %+1 is the top of the sphere

%ISOCENTER ESTIMATE
%We want to underestimate the dose at the isocenter so let us take the
%shortest distance that this point could be to the skin
shortest_radius = head_a;
d_ptvctr2headctr = (ptv_center - head_center);
min_ptv_skin_depth = norm(shortest_radius - (d_ptvctr2headctr));
%Using min_ptv_skin_depth = 115mm in the depth absorption function table to estimate the dose 
dose_depth_at_115 = 0.80; %per beam
total_dose_at_isocenter_underestimate = dose_depth_at_115*num_beams

%OAR Estimate
largest_radius = head_b;
d_oarctr2headctr = (oar_center - head_center);
d_oarctr2ptvctr = norm(oar_center-ptv_center);
oar_angle_at_risk = 2*atand((oar_radius+beam_diameter/2)/d_oarctr2ptvctr);
num_possible_oar_beam_intersections = 2*oar_angle_at_risk/beam_separation_angle; %multiply by 2 to account for xy plane as well as the  
max_oar_skin_depth = norm(largest_radius - d_oarctr2headctr+oar_radius);
%Using min_ptv_skin_depth = 159 mm in the depth absorption function table to estimate the dose 
dose_depth_at_159 = 0.9; %per beam
%Assume 1 beam center is 7.5mm offset from the OAR (still 1 unit dose), the
%next beam center will be at:
next_beam_center = tand(30)*d_oarctr2ptvctr;
% This is within the 30mm diameter of the OAR, therefore it is possible for
% all 4 beams to pass within 7.5mm of the OAR with would apply a full dose
% from each
dose_radial_at_7_5 = 1;
dose_oar_perbeam = dose_depth_at_159*dose_radial_at_7_5;
total_dose_at_oar_overestimate = dose_oar_perbeam*num_possible_oar_beam_intersections

%% Part 5: Compute Dose Absorption Function Table
fprintf('<strong>Part 5: Computing Dose Absorption Function Table</strong>\n')

max_head_size = 2*max([head_a,head_b,head_c])
increment = 0.1; %mm

[dose_absorption_function_table] = Compute_Depth_Dose(max_head_size,increment)

figure()
plot(dose_absorption_function_table.Depth,dose_absorption_function_table.Dose, '*')
xlabel('Depth from Skin (mm)')
title('Part 5: Dose Absorption Function')

%% Part 6: Compute Radial Dose Function Table
fprintf('<strong>Part 6: Computing Radial Dose Function Table</strong>\n')

start_radial_dose = -30; %mm
end_radial_dose = 30; %mm
increment = 0.1; %mm

[radial_dose_function_table] = Compute_Radial_Dose(start_radial_dose,end_radial_dose,increment)

figure()
plot(radial_dose_function_table.Radial_Distance,radial_dose_function_table.Dose, '*')
xlabel('Radial Distance (mm)')
title('Part 6: Radial Dose Function')

%% Part 7: Compute Beam Directions
fprintf('<strong>Part 7: Computing Beam Directions</strong>\n')

beam_separation_angle = 30; %degrees
beam_diameter = 30; %mm
isocenter = [30, 0, 15]; %mm

[beam_nvectors] = Compute_Beam_Directions(beam_separation_angle)

fprintf('<strong>Part 7: Computing Latitudes and Longitudes</strong>\n')
[latitudes, longitudes] = Compute_Latitudes_and_Longitudes(beam_nvectors)

u = ones(length(beam_nvectors),1)*isocenter(1);
v = ones(length(beam_nvectors),1)*isocenter(2);
w = ones(length(beam_nvectors),1)*isocenter(3);
x = beam_nvectors(:,1);
y = beam_nvectors(:,2);
z = beam_nvectors(:,3);

figure()
h7 = quiver3(u+x,v+y,w+z,-x,-y,-z);
set(h7,'AutoScale','on', 'AutoScaleFactor', 1.2)
xlabel('x')
ylabel('y')
zlabel('z')
title('Part 7: Beam directions top view toward isocenter')

figure()
h7 = quiver3(u,v,w,x,y,z,'b');
set(h7,'AutoScale','on', 'AutoScaleFactor', 120)
xlabel('x')
ylabel('y')
zlabel('z')
title('Part 7: Beam Directions')
hold on

%plot head
[Xhead,Yhead,Zhead] = ellipsoid(head_center(1),head_center(2),head_center(3),head_a,head_b,head_c,20);
head = surf(Xhead,Yhead,Zhead);
set(head, 'FaceAlpha', 0.1)

%% Part 8 - Compute Skin Entry Points (and Depth from Skin Entry Points to Isocenter)
fprintf('<strong>Part 8: Computing Skin Entry Points and Skin Depth to Isocenter</strong>\n')

tic
[skin_entry_points,depth_to_isocenter] = Compute_Skin_Entry_Points(beam_nvectors,isocenter,head_a,head_b,head_c)
toc

%plot skin entry points
figure()
plot3(skin_entry_points(:,1),skin_entry_points(:,2),skin_entry_points(:,3),'r*','linewidth', 15)
hold on

%plot head
[Xhead,Yhead,Zhead] = ellipsoid(head_center(1),head_center(2),head_center(3),head_a,head_b,head_c,20);
head = surf(Xhead,Yhead,Zhead);
set(head, 'FaceAlpha', 0.1)
hold on

%plot beams
h8 = quiver3(u,v,w,x,y,z,'b');
set(h8,'AutoScale','on', 'AutoScaleFactor', 130)

xlabel('x')
ylabel('y')
zlabel('z')
title('Part 8: Skin Entry Points')
legend('Skin Entry Points')

%% Part 9 - Compute Beam Safety Flags
fprintf('<strong>Part 9: Computing Beam Safety Flags</strong>\n')

tic
[beam_safety_flags,num_unsafe_beams] = Compute_Beam_Safety_Flags(oar_center,oar_radius,beam_diameter,isocenter,beam_nvectors)
toc

indices_unsafe = find(beam_safety_flags);
unsafe_beams = beam_nvectors(indices_unsafe,:);

%plot unsafe beams
u = ones(length(unsafe_beams),1)*isocenter(1);
v = ones(length(unsafe_beams),1)*isocenter(2);
w = ones(length(unsafe_beams),1)*isocenter(3);
x = unsafe_beams(:,1);
y = unsafe_beams(:,2);
z = unsafe_beams(:,3);

figure()
h9 = quiver3(u,v,w,x,y,z,'b');
set(h9,'AutoScale','on', 'AutoScaleFactor', 120)
hold on

%plot tumours
[X,Y,Z] = sphere(20);
h1 = surf(ptv_radius*X+ptv_center(1),ptv_radius*Y+ptv_center(2),ptv_radius*Z+ptv_center(3));
set(h1, 'FaceAlpha', 0.5)
shading interp
labelptv = {'PTV'};
text(ptv_center(1)+ptv_radius, ptv_center(2)+ptv_radius, ptv_center(3)+ptv_radius, labelptv,'VerticalAlignment','top','HorizontalAlignment','left')
hold on;
xlim([-150 150])
ylim([-150 150])
zlim([-150 150])
hold on;
h2 = surf(oar_radius*X+oar_center(1),oar_radius*Y+oar_center(2),oar_radius*Z+oar_center(3));
set(h2, 'FaceAlpha', 0.8)
shading interp
labeloar = {'OAR'};
text(oar_center(1)+oar_radius, oar_center(2)+oar_radius,oar_center(3)+oar_radius,labeloar,'VerticalAlignment','top','HorizontalAlignment','left')
hold on;
xlabel('x')
ylabel('y')
zlabel('z')
title('Part 9: Unsafe Beams')

%% Part 10 - Compute Radial Distance
fprintf('<strong>Part 10: Computing Radial Distance</strong>\n')
fprintf('Testing the top helmet beam radial distance to lateral PTV edge:\n')

point_of_interest = [ptv_center(1)+ptv_radius,ptv_center(2),ptv_center(3)];
beam_index = 1;
radial_distance = Compute_Radial_Distance(point_of_interest, beam_nvectors, beam_index, isocenter)

%% Part 11 - Depth from Skin
fprintf('<strong>Part 11: Computing Depth from Skin</strong>\n')
fprintf('Testing the top helmet beam radial distance to lateral PTV edge:\n')

point_of_interest = [ptv_center(1)+ptv_radius,ptv_center(2),ptv_center(3)];
beam_index = 1;
skin_entry_point = skin_entry_points(beam_index,:)
[depth_from_skin] = Compute_Depth_from_Skin(point_of_interest, beam_nvectors, beam_index, isocenter, skin_entry_points)

%% Part 12 - Compute Point Dose from Beam
fprintf('<strong>Part 12: Computing Point Dose from Beam</strong>\n')
fprintf('Testing with the isocenter as the point of interest which is 60 mm in depth with an expected ~0.80 dose:\n')

[radial_distance] = Compute_Radial_Distance(isocenter, beam_nvectors, beam_index, isocenter);
[depth_from_skin] = Compute_Depth_from_Skin(isocenter, beam_nvectors, beam_index, isocenter, skin_entry_points);

[closest_depth,ind_closest_depth] = min(abs(dose_absorption_function_table.Depth-ones(length(dose_absorption_function_table.Depth),1).*depth_from_skin));
depth_dose = dose_absorption_function_table.Dose(ind_closest_depth)

[closest_rad,ind_closest_rad] = min(abs(radial_dose_function_table.Radial_Distance-ones(length(radial_dose_function_table.Radial_Distance),1).*radial_distance));
rad_dose = radial_dose_function_table.Dose(ind_closest_rad)

[point_dose_value] = Compute_Point_Dose_from_Beam(dose_absorption_function_table,depth_from_skin,radial_dose_function_table,radial_distance)

%% Part 13 - Compute Dose from All Beam
fprintf('<strong>Part 12: Computing Point Dose from All Beams</strong>\n')
fprintf('Testing with the isocenter as the point of interest with all safe beams:\n')
point_of_interest_P13 = isocenter;

[full_isocenter_dose_value_from_safe_beams] = Compute_Dose_from_All_Beams(point_of_interest_P13,beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,indices_unsafe)

%% Part 13 - Compute Dose from All Beam to Check Dose Estimates (Part 4 - Sanity Check)
fprintf('<strong>Part 12: Computing Point Dose from All Beams to Check Dose Estimates</strong>\n')
fprintf('Testing with the isocenter as the point of interest with all beams:\n')
%The dose at the isocenter with ALL beams turned on
[isocenter_dose_value] = Compute_Dose_from_All_Beams(isocenter,beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,[])

fprintf('Testing with the OAR point closest to PTV as the point of interest with all beams:\n')
%The dose at the point on the OAR closest to PTV with ALL beams turned on
offset_toward_isocenter = oar_radius*(oar_center-isocenter)/norm(oar_center-isocenter);
oar_closest_to_isocenter = oar_center+offset_toward_isocenter;
[OAR_max_dose_value] = Compute_Dose_from_All_Beams(oar_closest_to_isocenter,beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,[])

%% Part 14 - Compute Dose
fprintf('<strong>Part 14: Computing the Dose Inside Dose Box</strong>\n')

voxel_size = DOSE_VOXEL_SIZE; %mm

tic
%Build points of interest inside dose box
[dose_box] = Compute_Dose_Box(ptv_center, ptv_radius, oar_center, oar_radius);
%Commute points and dose at each point
[points,point_doses] = Compute_Dose(dose_box, voxel_size, beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,indices_unsafe);
toc

[max_point_dose_in_dosebox,index_max_point_dose]=max(point_doses)

%% Part 14 Continued - Plot
fprintf('<strong>Part 14: Plotting the Dose Box Grid</strong>\n')

%Create a colormap
numPoints = length(points(:,1));
cmap = cool(numPoints);
%Make doses into a colormap.
minDose = min(point_doses);
maxDose = max(point_doses);
%Get a percentage of the way the doses are from max to min
percentage = (maxDose - point_doses) / (maxDose - minDose);
%Find the index for each dose in the range 1 to the number of colors in our colormap
indexes = round(percentage * (numPoints - 1)  + 1);
doseColors = cmap(numPoints-indexes+1, :);

figure()
scatter3(points(:,1), points(:,2), points(:,3), 14, doseColors, 'filled');
cb = colorbar;
cb.Title.String = "Dose";
caxis([minDose maxDose])
hold on;

%plot PTV and OAR
[X,Y,Z] = sphere(20);
h1 = surf(ptv_radius*X+ptv_center(1),ptv_radius*Y+ptv_center(2),ptv_radius*Z+ptv_center(3));
set(h1, 'FaceAlpha', 0.5)
shading interp
labelptv = {'PTV'};
text(ptv_center(1)+ptv_radius, ptv_center(2)+ptv_radius, ptv_center(3)+ptv_radius, labelptv,'VerticalAlignment','top','HorizontalAlignment','left')
hold on;
xlim([-150 150])
ylim([-150 150])
zlim([-150 150])
hold on;
h2 = surf(oar_radius*X+oar_center(1),oar_radius*Y+oar_center(2),oar_radius*Z+oar_center(3));
set(h2, 'FaceAlpha', 0.6)
shading interp
labeloar = {'OAR'};
text(oar_center(1)+oar_radius, oar_center(2)+oar_radius,oar_center(3)+oar_radius,labeloar,'VerticalAlignment','top','HorizontalAlignment','left')
hold on;

u = ones(length(beam_nvectors),1)*isocenter(1);
v = ones(length(beam_nvectors),1)*isocenter(2);
w = ones(length(beam_nvectors),1)*isocenter(3);
x = beam_nvectors(:,1);
y = beam_nvectors(:,2);
z = beam_nvectors(:,3);

h7 = quiver3(u,v,w,x,y,z,'b');
set(h7,'AutoScale','on', 'AutoScaleFactor', 120)
xlabel('x')
ylabel('y')
zlabel('z')
title('Dose in OAR and PTV Box')
hold on

%plot head
[Xhead,Yhead,Zhead] = ellipsoid(head_center(1),head_center(2),head_center(3),head_a,head_b,head_c,20);
head = surf(Xhead,Yhead,Zhead);
set(head, 'FaceAlpha', 0.1)

%% Part 15 - Dosimetry Analysis PTV and OAR
fprintf('<strong>Part 15: Computing the Dose in the PTV</strong>\n')

voxel_size = DOSE_VOXEL_SIZE; %mm

tic
%Build points of interest inside PTV box
[ptv_box] = Compute_Dose_Box(ptv_center, ptv_radius, ptv_center, ptv_radius);
[points_ptv,point_doses_ptv] = Compute_Dose(ptv_box, voxel_size, beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,indices_unsafe);
[max_point_dose_ptv,index_max_point_dose_ptv] = max(point_doses_ptv);
[min_point_dose_ptv,~] = min(point_doses_ptv);
toc

fprintf('<strong>Part 15: Computing the Dose in the OAR</strong>\n')

%Build points of interest inside OAR box
tic
[oar_box] = Compute_Dose_Box(oar_center, oar_radius, oar_center, oar_radius);
[points_oar,point_doses_oar] = Compute_Dose(oar_box, voxel_size, beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,indices_unsafe);
[max_point_dose_oar,index_max_point_dose_oar] = max(point_doses_oar);
toc

%% Part 15 - Dosimetry Analysis Plot PTV and OAR
fprintf('<strong>Part 15: Plot the Dose Grid Boxes Around the PTV and the OAR</strong>\n')

%Create a colormaps
[doseColors] = Create_Color_Map([points_ptv(:,1);points_oar(:,1)],[point_doses_ptv;point_doses_oar]);

figure()
scatter3([points_ptv(:,1);points_oar(:,1)], [points_ptv(:,2);points_oar(:,2)], [points_ptv(:,3);points_oar(:,3)], 14, doseColors, 'filled');
axis equal
colormap jet
cb = colorbar;
cb.Title.String = "Dose";
caxis([min([point_doses_ptv;point_doses_oar]) max([point_doses_ptv;point_doses_oar])])
xlabel('x')
ylabel('y')
zlabel('z')
title('Part 15: Dose in OAR and PTV Boxes')

%% Part 15 - Dosimetry Analysis PTV and OAR Dose Volume Histogram
fprintf('<strong>Part 15: Computing the Dose Volume Histograms for PTV and OAR</strong>\n')

D100 = 20; %units (amount of dose prescribed to PTV)
inc = 0.01; %units
dose_max = 29; %units

[relative_dose_ptv,ratio_of_total_structure_volume_ptv] = Create_Dose_Volume_Histogram(point_doses_ptv,D100,dose_max,inc);
[relative_dose_oar,ratio_of_total_structure_volume_oar] = Create_Dose_Volume_Histogram(point_doses_oar,DOARMAX,dose_max,inc);

figure()
plot(relative_dose_ptv,ratio_of_total_structure_volume_ptv,'-g')
hold on
plot(relative_dose_oar,ratio_of_total_structure_volume_oar,'-r')
xlabel('Relative Dose (%)')
ylabel('Ratio of Total Structure Volume (%)')
title('Part 15: Dose Volume Histograms for PTV and OAR')
legend('PTV dose (relative to D100)','OAR dose (relative to DOARMAX)')
xlim([0 150])

fprintf('Number of OAR doses above DOARMAX:\n')
num_OAR_overdosed_points = sum(point_doses_oar>DOARMAX)
percentage_OAR_overdosed_points = num_OAR_overdosed_points/length(point_doses_oar)

%% Part 15 - Optimized Dosimetry Analysis PTV and OAR Dose Volume Histogram
fprintf('<strong>Part 15: Optimizing the Treatment Plan for PTV and OAR</strong>\n')
% The point of optimization is to get 100% relative dose inside PTV while keeping OAR below DOARMAX

D_factor3 = 3; %Optimization factor to scale the dose by 2
D_factor4 = 4; %Optimization factor to scale the dose by 3
D_factor5 = 5; %Optimization factor to scale the dose by 4

figure()
plot(relative_dose_ptv*D_factor3,ratio_of_total_structure_volume_ptv,'--g')
hold on
plot(relative_dose_ptv*D_factor4,ratio_of_total_structure_volume_ptv,'.-g')
hold on
plot(relative_dose_ptv*D_factor5,ratio_of_total_structure_volume_ptv,'*-g')
hold on
plot(relative_dose_oar*D_factor3,ratio_of_total_structure_volume_oar,'--r')
hold on
plot(relative_dose_oar*D_factor4,ratio_of_total_structure_volume_oar,'.-r')
hold on
plot(relative_dose_oar*D_factor5,ratio_of_total_structure_volume_oar,'*-r')
hold on
xline(100);
xlabel('Relative Dose (%)')
ylabel('Ratio of Total Structure Volume (%)')
title('Dose Volume Histogram for PTV and OAR with Different Optimization Factors')
legend('PTV dose factor 3 (relative to D100)','PTV dose factor 4 (relative to D100)','PTV dose factor 5 (relative to D100)','OAR dose factor 3 (relative to DOARMAX)','OAR dose factor 4 (relative to DOARMAX)','OAR dose factor 5 (relative to DOARMAX)')
xlim([0 150])

min_scaling_factor = D100/min_point_dose_ptv

fprintf('<strong>Part 15: Optimization requires an increase in D0 by a factor of 7.5; Computing New DVH</strong>\n')
figure()
plot(relative_dose_ptv*7.5,ratio_of_total_structure_volume_ptv,'-g')
hold on
plot(relative_dose_oar*7.5,ratio_of_total_structure_volume_oar,'-r')
xlabel('Relative Dose (%)')
ylabel('Ratio of Total Structure Volume (%)')
title('Optimzed Dose Volume Histogram for PTV and OAR (Base dose increase by 7.5 times)')
xline(100);
legend('Optimized PTV dose (relative to D100)','Optimized OAR dose (relative to DOARMAX)')
xlim([0 150])

fprintf('Number of Optimized OAR doses above DOARMAX:\n')
num_OAR__op_overdosed_points = sum(point_doses_oar>DOARMAX)
percentage_OAR_op_overdosed_points = num_OAR_overdosed_points/length(point_doses_oar)

%% Part 16 - Compute Surface Dose to OAR
fprintf('<strong>Part 16: Computing the Surface Dose to the OAR</strong>\n')

num_points = 1500;

tic
[points_oar,point_oar_doses] = Compute_Surface_Dose(num_points,oar_center,oar_radius,beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,indices_unsafe)
toc

[max_oar_surface_dose, ind_oar_surface_dose] = max(point_oar_doses);

%Create a colormap
[doseColors_oar] = Create_Color_Map(points_oar(:,1),point_oar_doses);
figure()
scatter3(points_oar(:,1), points_oar(:,2), points_oar(:,3), 14, doseColors_oar, 'filled');
axis equal
colormap jet;
cb = colorbar;
cb.Title.String = "Dose";
caxis([min(point_oar_doses) max(point_oar_doses)])
hold on
plot3(points_oar(ind_oar_surface_dose,1), points_oar(ind_oar_surface_dose,2), points_oar(ind_oar_surface_dose,3),'*r','linewidth', 10)
hold on
xlabel('x')
ylabel('y')
zlabel('z')
labelhighestdose = {['Highest Dose : ', num2str(max_oar_surface_dose), 'units']};
text(points_oar(ind_oar_surface_dose,1), points_oar(ind_oar_surface_dose,2), points_oar(ind_oar_surface_dose,3), labelhighestdose,'VerticalAlignment','top','HorizontalAlignment','left')
title('Part 16: OAR Surface Dose')

%% Part 16 - Compute Surface Dose to PTV
fprintf('<strong>Part 16: Computing the surface dose to the PTV</strong>\n')

num_points = 1500;

tic
[points_ptv,point_ptv_doses] = Compute_Surface_Dose(num_points,ptv_center,ptv_radius,beam_nvectors,isocenter,skin_entry_points,dose_absorption_function_table,radial_dose_function_table,indices_unsafe)
toc

[max_ptv_surface_dose, ind_ptv_surface_dose] = max(point_ptv_doses);

%Create a colormap
[doseColors_ptv] = Create_Color_Map(points_ptv(:,1),point_ptv_doses);

figure()
scatter3(points_ptv(:,1), points_ptv(:,2), points_ptv(:,3), 14, doseColors_ptv, 'filled');
axis equal
colormap jet;
cb = colorbar;
cb.Title.String = "Dose";
caxis([min(point_ptv_doses) max(point_ptv_doses)])

hold on
plot3(points_ptv(ind_ptv_surface_dose,1), points_ptv(ind_ptv_surface_dose,2), points_ptv(ind_ptv_surface_dose,3),'*r','linewidth', 10)
hold on
labelhighestdose = {['Highest Dose : ', num2str(max_ptv_surface_dose), 'units']};
text(points_ptv(ind_ptv_surface_dose,1), points_ptv(ind_ptv_surface_dose,2), points_ptv(ind_ptv_surface_dose,3), labelhighestdose,'VerticalAlignment','top','HorizontalAlignment','left')
title('Part 16: PTV Surface Dose')
xlabel('x')
ylabel('y')
zlabel('z')
