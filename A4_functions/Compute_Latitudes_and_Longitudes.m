%Genevieve Hayes
%Dec 2020

function [latitudes, longitudes] = Compute_Latitudes_and_Longitudes(beam_nvectors)
%COMPUTE_LATITUDES_AND_LONGITUDES Computes the latitudes and longitudes
%from each 3D vector in an array of beam vectors.
%[latitudes, longitudes] = Compute_Latitudes_and_Longitudes(beam_nvectors)

%Initialize arrays
longitudes = zeros(length(beam_nvectors),1);
latitudes = zeros(length(beam_nvectors),1);

%Calculate each latitude and longitude
for i = 1:length(beam_nvectors)
    longitudes(i) = atan2(beam_nvectors(i,2),beam_nvectors(i,1));
    latitudes(i) = atan2(beam_nvectors(i,3),sqrt(beam_nvectors(i,1)^2+beam_nvectors(i,2)^2));
end

end

