%Genevieve Hayes
%Dec 2020

function [beam_safety_flags,num_unsafe_beams] = Compute_Beam_Safety_Flags(oar_center,oar_radius,beam_diameter,isocenter,beam_nvectors)
%COMPUTE_BEAM_SAFETY_FLAGS Determines to safety flags for each beam. The
%beam is unsafe when it intersects at all with the OAR.
%[beam_safety_flags,num_unsafe_beams] =
%Compute_Beam_Safety_Flags(oar_center,oar_radius,beam_diameter,isocenter,beam_nvectors)
%where beam_safety_flags is a binary 1D array where 1 indicates a beam that
%intersect with the OAR and num_unsafe_beams is the number of beams
%that intersect with the OAR.

%Initialize array
numInts = zeros(length(beam_nvectors),1);

for i = 1:length(beam_nvectors)
    numInts(i) = numIntersectionsOfSphereAndCylinder(oar_center,oar_radius,beam_diameter/2,isocenter,-beam_nvectors(i,:));
end

%Make outputs binary
beam_safety_flags = numInts > 0.5;

%Compute number of unsafe beams
num_unsafe_beams = sum(beam_safety_flags(:) == 1);

end

